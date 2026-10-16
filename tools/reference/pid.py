#!/usr/bin/env python3
"""Эталонные значения для тестов FB_PID (набор FB_Pid_Test) и модель объекта FOPDT.

Только стандартная библиотека Python 3.11+. Каждое число, которое тест берёт отсюда, помечено в
тесте строкой «// ref: <сценарий>.<ключ>» перед ассертом и комментарием «источник:
tools/reference/pid.py, сценарий <имя>»; tools/project_checks/test_pid_reference.py сверяет
литерал в тесте с расчётом этого модуля.

Что моделируется
- ``PidSim`` — тот же дискретный алгоритм, что шаг 6 тела FB_PID (контракт API.md, 17.4–17.5;
  документ docs/fb/FB_PID.md): ошибка в % диапазона PV со знаком действия, зона
  нечувствительности, P по ошибке, D по измерению с фильтром первого порядка (обратная разность
  Эйлера), пределы и ограничение скорости выхода, обратный расчёт интегратора с постоянной
  слежения Tt (по выходу ФБ или по фактическому выходу механизма), предустановка I := u − P − D в
  Manual/слежении/OutOfService, шаг инициализации (первый расчёт, разрыв времени, возврат PV,
  выход из OutOfService), рампа задания, расчёт по реальному dt и периоду tSample.
  Режимы и запросы Auto — как в теле ФБ (OutOfService > Manual > Auto; Auto при негодной PV
  отклоняется). Тревоги, NE 107 и результат команд здесь не считаются: их проверяют тесты без
  эталонов.
- ``Fopdt`` — модель «первый порядок + запаздывание» помощника tests/POUs/Helpers/FB_FopdtModel:
  y[k+1] = y[k] + dt/T·(K·u[k − L/dt] − y[k]), dt = 0,1 с, L = 4 с (кольцо на 40 отсчётов).

Точность. Внутреннее состояние ФБ — LREAL (double), как здесь. Значения, которые в ST проходят
через REAL (входы rPv_eu, rTrack_pct, rOutAct_pct, поля Cmd и Cfg, выход rOut_pct, кольцо
запаздывания модели, выход модели rY), округляются до float32 функцией ``f32`` в тех же местах.
Время — целые наносекунды, как LTIME у FB_FakeTime (старт — 1 ч).

Запуск: ``python tools/reference/pid.py`` печатает все сценарии.
"""

from __future__ import annotations

import math
import struct
import sys
from collections.abc import Callable
from dataclasses import dataclass, fields
from enum import IntEnum

NS_PER_MS = 1_000_000
NS_PER_S = 1_000_000_000
T0_NS = 3600 * NS_PER_S  # FB_FakeTime стартует с LTIME#1H
PCT_FULL = 100.0


def f32(value: float) -> float:
    """Округление double до float32 (REAL CODESYS), к ближайшему."""
    return float(struct.unpack("<f", struct.pack("<f", value))[0])


def is_finite_real(value: float, sane_max: float = 1.0e30) -> bool:
    """F_IsFinite: не NaN, не ±Inf и |x| <= REAL_SANE_MAX."""
    return math.isfinite(value) and abs(value) <= sane_max


def rate_step(current: float, target: float, rate: float, step_s: float) -> float:
    """FB_PID.RateStep: скорость <= 0 — сразу к цели; шаг <= 0 — без изменения."""
    if rate <= 0.0:
        return target
    if step_s <= 0.0:
        return current
    if target > current:
        return min(target, current + rate * step_s)
    return max(target, current - rate * step_s)


def limit(lo: float, value: float, hi: float) -> float:
    """LIMIT(MN, IN, MX) = MIN(MAX(IN, MN), MX)."""
    return min(max(value, lo), hi)


class Mode(IntEnum):
    """E_DeviceMode (Local у ПИД нет)."""

    AUTO = 1
    MANUAL = 2
    OOS = 4


class PvFail(IntEnum):
    """E_PidPvFailAction."""

    HOLD = 0
    SAFE_OUT = 1
    SHED_TO_MANUAL = 2


@dataclass
class PidCfg:
    """ST_PidCfg: значения по умолчанию — как в DUT. REAL-поля округляются до float32."""

    direct: bool = False
    kp: float = 1.0
    ti_s: float = 30.0
    td_s: float = 0.0
    dfilter_n: float = 10.0
    tt_s: float = 0.0
    pv_min: float = 0.0
    pv_max: float = 100.0
    sp_min: float = 0.0
    sp_max: float = 100.0
    sp_rate: float = 0.0
    out_min: float = 0.0
    out_max: float = 100.0
    out_rate: float = 0.0
    deadband: float = 0.0
    t_sample_ms: int = 0
    t_dt_max_ms: int = 2000
    pv_fail: PvFail = PvFail.HOLD
    safe_out: float = 0.0
    sp_track_pv: bool = False
    use_out_act: bool = False

    def __post_init__(self) -> None:
        for item in fields(self):
            value = getattr(self, item.name)
            if isinstance(value, float):
                setattr(self, item.name, f32(value))


# Биты wCfgErr (карта битов docs/fb/FB_PID.md); перечисления в PidCfg всегда корректны
CFG_KP = 0x0002
CFG_TI_TD = 0x0004
CFG_DFILTER = 0x0008
CFG_TT = 0x0010
CFG_PV_RANGE = 0x0020
CFG_SP_RANGE = 0x0040
CFG_OUT_RANGE = 0x0080
CFG_DEADBAND = 0x0100
CFG_RATES = 0x0200
CFG_SAMPLE = 0x0400
CFG_PV_FAIL = 0x0800
DFILTER_N_MIN = 2.0
DFILTER_N_MAX = 50.0
DEADBAND_MAX_PCT = 10.0


def config_errors(cfg: PidCfg) -> int:
    """FB_PID.CheckConfig для числовых полей: сценарий с неверной Cfg в ST шёл бы без расчёта."""
    err = 0
    if cfg.kp <= 0.0:
        err |= CFG_KP
    if cfg.ti_s < 0.0 or cfg.td_s < 0.0:
        err |= CFG_TI_TD
    if cfg.td_s > 0.0 and not DFILTER_N_MIN <= cfg.dfilter_n <= DFILTER_N_MAX:
        err |= CFG_DFILTER
    if cfg.tt_s < 0.0:
        err |= CFG_TT
    if cfg.pv_min >= cfg.pv_max:
        err |= CFG_PV_RANGE
    if cfg.sp_min > cfg.sp_max:
        err |= CFG_SP_RANGE
    if cfg.out_min < 0.0 or cfg.out_max > PCT_FULL or cfg.out_min >= cfg.out_max:
        err |= CFG_OUT_RANGE
    if not 0.0 <= cfg.deadband <= DEADBAND_MAX_PCT:
        err |= CFG_DEADBAND
    if cfg.sp_rate < 0.0 or cfg.out_rate < 0.0:
        err |= CFG_RATES
    if cfg.t_dt_max_ms == 0 or cfg.t_sample_ms >= cfg.t_dt_max_ms:
        err |= CFG_SAMPLE
    if not cfg.out_min <= cfg.safe_out <= cfg.out_max:
        err |= CFG_PV_FAIL
    return err


class PidSim:
    """Шаги тела FB_PID, которые влияют на выход: 2а, 4, 5, 6 и хук OnModeChanged.

    Входы ФБ, поля Cmd и запросы режима — атрибуты (как VAR_INPUT, они сохраняются между
    вызовами); ``call()`` — один вызов ФБ в момент ``now_ns``. Конфигурация считается
    корректной (тесты без корректной Cfg эталона не требуют).
    """

    def __init__(self, cfg: PidCfg, remote_mode: Mode = Mode.MANUAL) -> None:
        if config_errors(cfg) != 0:
            raise ValueError(f"Cfg не проходит CheckConfig: 16#{config_errors(cfg):04X}")
        self.cfg = cfg
        self.now_ns = T0_NS
        # входы
        self.pv = 0.0
        self.pv_valid = False
        self.sp_ext = False
        self.sp_ext_value = 0.0
        self.track = False
        self.track_value = 0.0
        self.out_act = 0.0
        # Cmd, Retain
        self.cmd_sp = 0.0
        self.cmd_manual_out = 0.0
        self.set_auto = False
        self.set_manual = False
        self.set_oos = False
        self.remote_mode = remote_mode
        self.oos_retained = False
        # состояние
        self.mode = Mode.MANUAL
        self.first_call = True
        self.lr_i = 0.0
        self.lr_d = 0.0
        self.lr_p = 0.0
        self.lr_v = 0.0
        self.lr_err = 0.0
        self.lr_out = 0.0
        self.lr_pv_prev = 0.0
        self.lr_sp = 0.0
        self.lr_sp_target = 0.0
        self.lr_dt_calc = 0.0
        self.lt_last_calc = 0
        self.calc_init = True
        self.first_calc = True
        self.sp_init = True
        # флаги последнего вызова
        self.pv_ok = False
        self.dt_gap = False
        self.sp_invalid = False
        self.in_deadband = False
        self.out_rate_lim = False
        self.track_act = False

    # --- время ---
    def advance_ms(self, ms: int) -> None:
        self.now_ns += ms * NS_PER_MS

    def set_now_ns(self, ns: int) -> None:
        self.now_ns = ns

    # --- выходы ---
    @property
    def out(self) -> float:
        """rOut_pct."""
        return f32(self.lr_out)

    @property
    def p(self) -> float:
        return f32(self.lr_p)

    @property
    def i(self) -> float:
        return f32(self.lr_i)

    @property
    def d(self) -> float:
        return f32(self.lr_d)

    @property
    def err(self) -> float:
        return f32(self.lr_err)

    @property
    def sp(self) -> float:
        return f32(self.lr_sp)

    @property
    def dt_ms(self) -> float:
        return f32(self.lr_dt_calc * 1000.0)

    # --- хук ---
    def _on_mode_changed(self, old: Mode, new: Mode) -> None:
        if old == Mode.OOS:
            self.calc_init = True
        if new == Mode.AUTO:
            self.lr_i = self.lr_out - self.lr_p - self.lr_d

    def _set_mode(self, new: Mode) -> None:
        if new != self.mode:
            old = self.mode
            self.mode = new
            self._on_mode_changed(old, new)

    def call(self) -> None:
        """Один вызов ФБ: ветвления повторяют тело FB_PID строка в строку."""
        cfg = self.cfg
        pv = f32(self.pv)
        manual_out = f32(self.cmd_manual_out)
        track_value = f32(self.track_value)
        out_act = f32(self.out_act)
        # 2. PV и старт: выход — фактический выход механизма (17.5)
        self.pv_ok = self.pv_valid and is_finite_real(pv)
        if self.first_call:
            if cfg.use_out_act and is_finite_real(out_act):
                self.lr_out = out_act
            elif self.track and is_finite_real(track_value):
                self.lr_out = track_value
            elif is_finite_real(manual_out):
                self.lr_out = manual_out
        # 4. Режим: Auto при негодной PV отклоняется; затем ProcessMode
        if self.set_auto and not self.pv_ok:
            self.set_auto = False
        winner: Mode | None = None
        if self.set_oos:
            winner = Mode.OOS
        elif self.set_manual:
            winner = Mode.MANUAL
        elif self.set_auto:
            winner = Mode.AUTO
        self.set_auto = self.set_manual = self.set_oos = False
        if winner == Mode.OOS:
            self.oos_retained = True
        elif winner is not None:
            self.remote_mode = winner
            self.oos_retained = False
        self._set_mode(Mode.OOS if self.oos_retained else self.remote_mode)
        # 5. ShedToManual
        if self.mode == Mode.AUTO and not self.pv_ok and not self.track and cfg.pv_fail == PvFail.SHED_TO_MANUAL:
            self.remote_mode = Mode.MANUAL
            self._set_mode(Mode.MANUAL)
        # 6.1 Задание
        sp_track = self.mode == Mode.MANUAL and cfg.sp_track_pv and not self.sp_ext and self.pv_ok
        if self.sp_ext:
            sp_raw = f32(self.sp_ext_value)
        elif sp_track:
            sp_raw = pv
        else:
            sp_raw = f32(self.cmd_sp)
        self.sp_invalid = not is_finite_real(sp_raw)
        if not self.sp_invalid:
            self.lr_sp_target = limit(cfg.sp_min, sp_raw, cfg.sp_max)
            if self.sp_ext or sp_track:
                self.cmd_sp = sp_raw
        # 6.2 Нужен ли расчёт
        calc = False
        init_step = False
        self.dt_gap = False
        dt_s = 0.0
        if not self.pv_ok:
            self.calc_init = True
        elif self.mode != Mode.OOS:
            if self.calc_init or self.now_ns < self.lt_last_calc:
                calc = True
                init_step = True
                self.dt_gap = self.first_calc or not self.calc_init
            else:
                elapsed = self.now_ns - self.lt_last_calc
                if elapsed > cfg.t_dt_max_ms * NS_PER_MS:
                    calc = True
                    init_step = True
                    self.dt_gap = True
                elif elapsed > 0 and elapsed >= cfg.t_sample_ms * NS_PER_MS:
                    calc = True
                    dt_s = elapsed / NS_PER_S
        # 6.3 Шаг расчёта
        kp = cfg.kp
        td = cfg.td_s
        if calc:
            self.lt_last_calc = self.now_ns
            self.calc_init = False
            self.first_calc = False
            self.lr_dt_calc = dt_s
            if self.sp_init or sp_track:
                self.lr_sp = self.lr_sp_target
                self.sp_init = False
            else:
                self.lr_sp = rate_step(self.lr_sp, self.lr_sp_target, cfg.sp_rate, dt_s)
            sign = -1.0 if cfg.direct else 1.0
            scale = PCT_FULL / (cfg.pv_max - cfg.pv_min)
            e = sign * (self.lr_sp - pv) * scale
            db = cfg.deadband
            self.in_deadband = db > 0.0 and abs(e) <= db
            if abs(e) <= db:
                self.lr_err = 0.0
            elif e > 0.0:
                self.lr_err = e - db
            else:
                self.lr_err = e + db
            self.lr_p = kp * self.lr_err
            if td > 0.0 and not init_step:
                tf = td / cfg.dfilter_n
                self.lr_d = tf / (tf + dt_s) * self.lr_d - kp * td / (tf + dt_s) * sign * (pv - self.lr_pv_prev) * scale
            else:
                self.lr_d = 0.0
            self.lr_pv_prev = pv
            self.lr_v = self.lr_p + self.lr_i + self.lr_d
        # 6.4 Выход по старшинству
        out_min = cfg.out_min
        out_max = cfg.out_max
        self.track_act = False
        if self.mode == Mode.OOS:
            self.lr_i = self.lr_out - self.lr_p - self.lr_d
            self.out_rate_lim = False
        elif self.track:
            self.track_act = True
            if is_finite_real(track_value):
                self.lr_out = track_value
            self.lr_i = self.lr_out - self.lr_p - self.lr_d
            self.out_rate_lim = False
        elif self.mode == Mode.MANUAL:
            if is_finite_real(manual_out):
                self.lr_out = limit(out_min, manual_out, out_max)
            self.lr_i = self.lr_out - self.lr_p - self.lr_d
            self.out_rate_lim = False
        elif not self.pv_ok:
            if cfg.pv_fail == PvFail.SAFE_OUT:
                self.lr_out = cfg.safe_out
            self.out_rate_lim = False
        elif calc:
            if init_step:
                self.lr_i = self.lr_out - self.lr_p - self.lr_d
                self.out_rate_lim = False
            else:
                u_lim = limit(out_min, self.lr_v, out_max)
                self.lr_out = rate_step(self.lr_out, u_lim, cfg.out_rate, dt_s)
                self.out_rate_lim = self.lr_out != u_lim
                u_aw = out_act if cfg.use_out_act and is_finite_real(out_act) else self.lr_out
                ti = cfg.ti_s
                if ti > 0.0:
                    if cfg.tt_s > 0.0:
                        tt = cfg.tt_s
                    elif td > 0.0:
                        tt = math.sqrt(ti * td)
                    else:
                        tt = ti
                    self.lr_i = self.lr_i + kp * dt_s / ti * self.lr_err + min(dt_s / tt, 1.0) * (u_aw - self.lr_v)
        # 6.5 Слежение в Cmd
        if self.mode != Mode.MANUAL or self.track_act:
            self.cmd_manual_out = self.out
        self.first_call = False


class Fopdt:
    """FB_FopdtModel: шаг 0,1 с, запаздывание 40 шагов (4 с), выход rY — REAL."""

    DT_S = 0.1
    DELAY_STEPS = 40

    def __init__(self, gain: float = 2.0, t_s: float = 20.0) -> None:
        self.gain = f32(gain)
        self.t_s = f32(t_s)
        self.ring = [0.0] * self.DELAY_STEPS
        self.head = 0
        self.lr_y = 0.0
        self.u = 0.0

    @property
    def y(self) -> float:
        return f32(self.lr_y)

    def step(self) -> None:
        u_delayed = self.ring[self.head]
        self.ring[self.head] = f32(self.u)
        self.head += 1
        if self.head >= self.DELAY_STEPS:
            self.head = 0
        self.lr_y = self.lr_y + self.DT_S / self.t_s * (self.gain * u_delayed - self.lr_y)


# ---------------------------------------------------------------------------
# Сценарии: последовательность вызовов — как в одноимённом тесте FB_Pid_Test
# ---------------------------------------------------------------------------

Result = dict[str, float]


def _start(cfg: PidCfg, manual_out: float, sp: float, pv: float, remote_mode: Mode = Mode.MANUAL) -> PidSim:
    """Первый вызов в момент t0: Manual (или режим из Retain), PV годна."""
    sim = PidSim(cfg, remote_mode)
    sim.cmd_manual_out = manual_out
    sim.cmd_sp = sp
    sim.pv = pv
    sim.pv_valid = True
    sim.call()
    return sim


def _to_auto(sim: PidSim, step_ms: int = 100) -> None:
    sim.advance_ms(step_ms)
    sim.set_auto = True
    sim.call()


def _run(sim: PidSim, steps: int, step_ms: int = 100) -> None:
    for _ in range(steps):
        sim.advance_ms(step_ms)
        sim.call()


def scenario_p_only() -> Result:
    """Pid_POnly_ErrorStep_OutputEqualsKpTimesError: Kp = 2, без I и D, смещение 40 %."""
    sim = _start(PidCfg(kp=2.0, ti_s=0.0), manual_out=40.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    res = {"out_switch": sim.out}
    sim.pv = 45.0  # e = +5 %
    _run(sim, 1)
    res |= {"out_e5": sim.out, "p_e5": sim.p, "err_e5": sim.err}
    sim.pv = 53.0  # e = -3 %
    _run(sim, 1)
    res |= {"out_em3": sim.out}
    return res


def scenario_integral() -> Result:
    """Pid_Integral_ConstantError_RampRateKpOverTi: Kp = 2, Ti = 10 с, e = 4 % -> 0,8 %/с."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 46.0
    _run(sim, 1)
    out_1 = sim.out
    _run(sim, 50)
    out_51 = sim.out
    return {"out_first": out_1, "out_after_5s": out_51, "rate_pctps": (out_51 - out_1) / 5.0, "i_after_5s": sim.i}


def scenario_d_kick() -> Result:
    """Pid_DOnMeasurement_SetpointStep_NoDerivativeKick: Kp = 1, Td = 5 с, N = 10, без I."""
    sim = _start(PidCfg(kp=1.0, ti_s=0.0, td_s=5.0), manual_out=50.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.cmd_sp = 60.0  # ступень задания
    _run(sim, 1)
    res = {"out_sp_step": sim.out, "d_sp_step": sim.d}
    sim.pv = 52.0  # ступень PV
    _run(sim, 1)
    res |= {"d_pv_step": sim.d, "out_pv_step": sim.out}
    return res


def scenario_d_filter() -> Result:
    """Pid_DFilter_PvStep_DecaysWithTdOverN: Td = 5 с, N = 10 (Tf = 0,5 с), шаг 100 мс."""
    sim = _start(PidCfg(kp=1.0, ti_s=0.0, td_s=5.0), manual_out=50.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 52.0
    _run(sim, 1)
    d_1 = sim.d
    _run(sim, 5)  # ещё 0,5 с = Tf
    return {"d_step": d_1, "d_after_tf": sim.d, "ratio": sim.d / d_1}


def scenario_direct() -> Result:
    """Pid_DirectAction_InvertsSign: Kp = 2, PV на 10 % выше задания."""
    res: Result = {}
    for name, direct in (("reverse", False), ("direct", True)):
        sim = _start(PidCfg(kp=2.0, ti_s=0.0, direct=direct), manual_out=50.0, sp=50.0, pv=50.0)
        _to_auto(sim)
        sim.pv = 60.0
        _run(sim, 1)
        res |= {f"out_{name}": sim.out, f"err_{name}": sim.err}
    return res


def scenario_limits() -> Result:
    """Pid_OutputLimits_ClampAndFlags: Kp = 2, пределы 10…90 %."""
    cfg = PidCfg(kp=2.0, ti_s=0.0, out_min=10.0, out_max=90.0, safe_out=10.0)
    sim = _start(cfg, manual_out=50.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 20.0
    _run(sim, 1)
    res = {"out_high": sim.out}
    sim.pv = 80.0
    _run(sim, 1)
    res |= {"out_low": sim.out}
    return res


def scenario_aw_recovery() -> Result:
    """Pid_AntiWindup_LongSaturation_RecoversWithinTt: насыщение 60 с, затем смена знака ошибки.

    Kp = 1, Ti = 10 с, Tt = авто (= Ti = 10 с). Сравнение — тот же ФБ с Tt = 1·10⁶ с (обратного
    расчёта практически нет): выход остаётся на пределе дольше Tt.
    """
    res: Result = {}
    for name, tt in (("aw", 0.0), ("noaw", 1.0e6)):
        sim = _start(PidCfg(kp=1.0, ti_s=10.0, tt_s=tt), manual_out=50.0, sp=50.0, pv=50.0)
        _to_auto(sim)
        sim.pv = 30.0  # e = +20 %
        _run(sim, 600)
        res |= {f"out_sat_{name}": sim.out, f"i_sat_{name}": sim.i}
        sim.pv = 70.0  # e = -20 %
        _run(sim, 1)
        res |= {f"out_rev_{name}": sim.out}
        _run(sim, 99)  # Tt = 10 с после смены знака
        res |= {f"out_tt_{name}": sim.out}
    return res


def scenario_outact() -> Result:
    """Pid_AntiWindup_OutActFeedback_TracksExternalLimit: внешний минимум механизма 30 %.

    Kp = 1, Ti = 10 с, Tt = Ti. rOutAct_pct = MAX(30, выход ПИД прошлого вызова). PV выше
    задания на 10 % 60 с, затем ниже на 10 % 3 с. Сравнение — тот же ФБ без xUseOutAct.
    """
    res: Result = {}
    for name, use in (("act", True), ("noact", False)):
        sim = _start(PidCfg(kp=1.0, ti_s=10.0, use_out_act=use), manual_out=50.0, sp=50.0, pv=50.0)
        sim.out_act = max(30.0, sim.out)
        sim.advance_ms(100)
        sim.set_auto = True
        sim.call()
        sim.pv = 60.0
        for _ in range(600):
            sim.out_act = max(30.0, sim.out)
            sim.advance_ms(100)
            sim.call()
        res |= {f"out_hold_{name}": sim.out, f"i_hold_{name}": sim.i}
        sim.pv = 40.0
        for _ in range(30):
            sim.out_act = max(30.0, sim.out)
            sim.advance_ms(100)
            sim.call()
        res |= {f"out_rev_{name}": sim.out}
    return res


def scenario_rate_limit() -> Result:
    """Pid_OutputRateLimit_IntegratorBacksOff: Kp = 2, Ti = 10 с, скорость выхода 5 %/с."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0, out_rate=5.0), manual_out=40.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.cmd_sp = 60.0  # P: 0 -> 20 %
    _run(sim, 20)
    return {"out_2s": sim.out, "i_2s": sim.i, "i_plain_2s": f32(40.0 + 20 * 2.0 * 0.1 / 10.0 * 10.0)}


def scenario_manual_to_auto() -> Result:
    """Pid_ManualToAuto_Bumpless: Kp = 2, Ti = 10 с, Td = 1 с; e = 3 % уже в Manual."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0, td_s=1.0), manual_out=35.0, sp=50.0, pv=47.0)
    _run(sim, 10)
    res = {"i_manual": sim.i}
    _to_auto(sim)
    res |= {"out_switch": sim.out}
    _run(sim, 10)
    res |= {"out_1s": sim.out, "cmd_out_1s": f32(sim.cmd_manual_out)}
    return res


def scenario_track() -> Result:
    """Pid_Track_PresetsIntegrator_BumplessRelease: Auto, слежение за 25 %, Kp = 2, Ti = 10 с."""
    sim = PidSim(PidCfg(kp=2.0, ti_s=10.0, out_min=10.0, safe_out=10.0), remote_mode=Mode.AUTO)
    sim.cmd_sp = 50.0
    sim.pv = 47.0
    sim.pv_valid = True
    sim.track = True
    sim.track_value = 0.0
    sim.call()
    res = {"out_track0": sim.out}
    sim.track_value = 25.0
    _run(sim, 10)
    res |= {"out_track": sim.out, "i_track": sim.i}
    sim.track = False
    _run(sim, 1)
    res |= {"out_release": sim.out}
    _run(sim, 10)
    res |= {"out_release_1s": sim.out}
    return res


def scenario_real_dt() -> Result:
    """Pid_RealDt_SameResultFor10msAnd100msSteps: тот же интеграл за 5 с при шаге 10 и 100 мс."""
    res: Result = {}
    for name, step_ms, steps in (("10ms", 10, 500), ("100ms", 100, 50)):
        sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=30.0, sp=50.0, pv=50.0)
        _to_auto(sim, step_ms)
        sim.pv = 46.0
        _run(sim, steps, step_ms)
        res |= {f"i_{name}": sim.i, f"out_{name}": sim.out}
    return res


def scenario_sample() -> Result:
    """Pid_Sample_ComputesOnlyEveryTSample: tSample = 100 мс, вызовы каждые 10 мс."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0, t_sample_ms=100), manual_out=30.0, sp=50.0, pv=50.0)
    _run(sim, 10, 10)
    sim.advance_ms(10)
    sim.set_auto = True
    sim.call()
    sim.pv = 46.0
    changes = 0
    prev = sim.out
    for _ in range(30):
        sim.advance_ms(10)
        sim.call()
        if sim.out != prev:
            changes += 1
        prev = sim.out
    return {"changes": float(changes), "dt_ms": sim.dt_ms, "out_end": sim.out}


def scenario_dt_gap() -> Result:
    """Pid_DtGap_SkipsIntegration: разрыв 5 с > tDtMax = 2 с не интегрируется."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 46.0
    _run(sim, 10)
    out_before = sim.out
    sim.advance_ms(5000)
    sim.call()
    res = {"out_before": out_before, "out_gap": sim.out, "gap_flag": float(sim.dt_gap)}
    _run(sim, 1)
    res |= {"out_after": sim.out, "gap_flag_after": float(sim.dt_gap)}
    _run(sim, 1)
    res |= {"out_after2": sim.out}
    return res


def scenario_time_back() -> Result:
    """Pid_TimeBackwards_InitStepNoJump: время назад на 30 с — шаг инициализации без рывка."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 46.0
    _run(sim, 10)
    out_before = sim.out
    sim.set_now_ns(sim.now_ns - 30 * NS_PER_S)
    sim.call()
    res = {"out_before": out_before, "out_back": sim.out, "gap_flag": float(sim.dt_gap)}
    _run(sim, 1)
    res |= {"out_after": sim.out}
    _run(sim, 1)
    res |= {"out_after2": sim.out}
    return res


def scenario_deadband() -> Result:
    """Pid_Deadband_NoActionInsideBand: зона 1 %, Kp = 2, Ti = 10 с."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0, deadband=1.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 49.2  # e = 0,8 %: внутри зоны
    _run(sim, 20)
    res = {"out_inside": sim.out, "err_inside": sim.err}
    sim.pv = 48.5  # e = 1,5 %: e' = 0,5 %
    _run(sim, 1)
    res |= {"out_outside": sim.out, "err_outside": sim.err}
    return res


def scenario_pv_fail_hold() -> Result:
    """Pid_PvFail_HoldOutput_BumplessResume: Kp = 2, Ti = 10 с, реакция Hold."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 46.0
    _run(sim, 10)
    res = {"out_before": sim.out}
    sim.pv_valid = False
    _run(sim, 20)
    res |= {"out_fail": sim.out}
    sim.pv_valid = True
    sim.pv = 44.0  # e = 6 %
    _run(sim, 1)
    res |= {"out_resume": sim.out}
    _run(sim, 2)
    res |= {"out_resume_2": sim.out}
    return res


def scenario_safe_out() -> Result:
    """Pid_PvFail_SafeOutDrivesSafeOutput: реакция SafeOut, rSafeOut_pct = 15 %."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0, pv_fail=PvFail.SAFE_OUT, safe_out=15.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 46.0
    _run(sim, 10)
    sim.pv_valid = False
    _run(sim, 5)
    res = {"out_fail": sim.out}
    sim.pv_valid = True
    _run(sim, 1)
    res |= {"out_resume": sim.out}
    _run(sim, 2)
    res |= {"out_resume_2": sim.out}
    return res


def scenario_sp_ramp() -> Result:
    """Pid_SetpointRamp_RateLimited: рампа 2 ед./с, задание 40 -> 60."""
    sim = _start(PidCfg(kp=1.0, ti_s=30.0, sp_rate=2.0), manual_out=30.0, sp=40.0, pv=40.0)
    sim.cmd_sp = 60.0
    _run(sim, 50)
    res = {"sp_5s": sim.sp}
    _run(sim, 50)
    res |= {"sp_10s": sim.sp}
    return res


def scenario_oos() -> Result:
    """Pid_OutOfService_HoldsOutput: OutOfService удерживает выход, выход из него — без рывка."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=30.0, sp=50.0, pv=50.0)
    _to_auto(sim)
    sim.pv = 46.0
    _run(sim, 10)
    sim.advance_ms(100)
    sim.set_oos = True
    sim.call()
    res = {"out_oos": sim.out}
    sim.pv = 30.0
    _run(sim, 30)
    res |= {"out_oos_3s": sim.out}
    sim.advance_ms(100)
    sim.set_auto = True
    sim.call()
    res |= {"out_exit": sim.out}
    _run(sim, 2)
    res |= {"out_exit_2": sim.out}
    return res


def scenario_retain_auto() -> Result:
    """Pid_RetainAuto_RestoredOnRestart: старт в Auto из Retain, выход из rManualOut_pct = 42 %."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0), manual_out=42.0, sp=50.0, pv=46.0, remote_mode=Mode.AUTO)
    res = {"out_start": sim.out}
    _run(sim, 2)
    res |= {"out_2": sim.out}
    return res


def scenario_sp_track_pv() -> Result:
    """Pid_SpTrackPv_ManualSetpointFollowsPv: задание следует за PV в Manual, переход в Auto без рывка."""
    sim = _start(PidCfg(kp=2.0, ti_s=10.0, sp_track_pv=True), manual_out=30.0, sp=50.0, pv=47.5)
    _run(sim, 5)
    res = {"cmd_sp": f32(sim.cmd_sp)}
    _to_auto(sim)
    res |= {"out_switch": sim.out}
    _run(sim, 10)
    res |= {"out_1s": sim.out}
    return res


def _fopdt_loop(cfg: PidCfg, steps: int, sp: float, marks: tuple[int, ...]) -> Result:
    """Замкнутый контур ПИД + FOPDT: старт в Auto при y = 0, задание 0 -> sp на шаге 1.

    Порядок шага k (как в тесте): время + 100 мс; PV := y; вызов ПИД; u := выход; шаг модели.
    Перерегулирование — по максимуму y; время установления — первый момент, после которого y
    остаётся в полосе ±2 % задания; ``band_margin`` — расстояние y до границы полосы на последнем
    выходе из неё и на следующем шаге (запас против расхождения округления ST и Python);
    ``unsat_s`` — первый момент, когда выход ушёл с верхнего предела после насыщения.
    """
    sim = PidSim(cfg, remote_mode=Mode.AUTO)
    plant = Fopdt()
    sim.pv = plant.y
    sim.pv_valid = True
    sim.call()
    sim.cmd_sp = sp
    band = 0.02 * sp
    res: Result = {}
    peak = 0.0
    settle = 0.0
    devs: list[float] = []
    k_last = 0
    saturated = False
    unsat = 0.0
    for k in range(1, steps + 1):
        sim.advance_ms(100)
        sim.pv = plant.y
        sim.call()
        plant.u = sim.out
        plant.step()
        y = plant.y
        peak = max(peak, y)
        dev = abs(y - sp)
        devs.append(dev)
        if dev > band:
            settle = (k + 1) * 0.1
            k_last = k
        if sim.lr_out >= cfg.out_max:  # xSatHigh: LREAL-выход на пределе
            saturated = True
        elif saturated and unsat == 0.0:
            unsat = k * 0.1
        if k in marks:
            res |= {f"out_{k // 10}s": sim.out, f"pv_{k // 10}s": y}
    edge = devs[k_last - 1 : k_last + 1] if k_last > 0 else devs[:1]
    res |= {
        "peak": peak,
        "overshoot_pct": (peak - sp) / sp * PCT_FULL,
        "settle_s": f32(settle),
        "band_margin": min(abs(dev - band) for dev in edge),
        "unsat_s": f32(unsat),
    }
    return res


def _fopdt_cfg(out_max: float = 100.0, tt_s: float = 0.0) -> PidCfg:
    """ПИД контура с FOPDT: Kp = 1, Ti = 20 с, Td = 1 с (N = 10)."""
    return PidCfg(kp=1.0, ti_s=20.0, td_s=1.0, out_max=out_max, tt_s=tt_s)


def scenario_fopdt_step() -> Result:
    """Pid_Fopdt_ClosedLoop_MatchesPythonReference: K = 2, T = 20 с, L = 4 с; Kp = 1, Ti = 20 с, Td = 1 с."""
    return _fopdt_loop(_fopdt_cfg(), 1200, 40.0, (100, 300, 600, 1200))


def scenario_fopdt_sat() -> Result:
    """Pid_Fopdt_SaturatedStep_BackCalcLimitsOvershoot: тот же контур, предел выхода 30 %, 60 с.

    Сравнение — без обратного расчёта (Tt = 1·10⁶ с): интегратор накапливается за время
    насыщения, выход позже уходит с предела, перерегулирование больше.
    """
    res: Result = {}
    for name, tt in (("aw", 0.0), ("noaw", 1.0e6)):
        loop = _fopdt_loop(_fopdt_cfg(out_max=30.0, tt_s=tt), 600, 40.0, (600,))
        res |= {
            f"peak_{name}": loop["peak"],
            f"overshoot_{name}": loop["overshoot_pct"],
            f"pv_60s_{name}": loop["pv_60s"],
            f"unsat_{name}": loop["unsat_s"],
        }
    return res


def scenario_fopdt_open() -> Result:
    """FopdtModel_OpenLoopStep_MatchesPythonReference: u = 10 % с t = 0, K = 2, T = 20 с, L = 4 с."""
    plant = Fopdt()
    plant.u = 10.0
    res: Result = {}
    for k in range(1, 241):
        plant.step()
        if k in (40, 41, 240):
            res[f"y_{k}"] = plant.y
    return res


SCENARIOS: dict[str, Callable[[], Result]] = {
    "p_only": scenario_p_only,
    "integral": scenario_integral,
    "d_kick": scenario_d_kick,
    "d_filter": scenario_d_filter,
    "direct": scenario_direct,
    "limits": scenario_limits,
    "aw_recovery": scenario_aw_recovery,
    "outact": scenario_outact,
    "rate_limit": scenario_rate_limit,
    "manual_to_auto": scenario_manual_to_auto,
    "track": scenario_track,
    "real_dt": scenario_real_dt,
    "sample": scenario_sample,
    "dt_gap": scenario_dt_gap,
    "time_back": scenario_time_back,
    "deadband": scenario_deadband,
    "pv_fail_hold": scenario_pv_fail_hold,
    "safe_out": scenario_safe_out,
    "sp_ramp": scenario_sp_ramp,
    "oos": scenario_oos,
    "retain_auto": scenario_retain_auto,
    "sp_track_pv": scenario_sp_track_pv,
    "fopdt_step": scenario_fopdt_step,
    "fopdt_sat": scenario_fopdt_sat,
    "fopdt_open": scenario_fopdt_open,
}

_CACHE: dict[str, Result] = {}


def reference(name: str) -> Result:
    """Результаты сценария (с кэшем)."""
    if name not in _CACHE:
        _CACHE[name] = SCENARIOS[name]()
    return _CACHE[name]


def main() -> int:
    reconfigure = getattr(sys.stdout, "reconfigure", None)
    if reconfigure is not None:  # консоль Windows: вывод по-русски в UTF-8
        reconfigure(encoding="utf-8")
    for name in SCENARIOS:
        print(f"{name}:")
        for key, value in reference(name).items():
            print(f"  {key:20} {value:.6f}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
