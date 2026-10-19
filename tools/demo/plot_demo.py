"""Графики раздела «Демонстрация» README из CSV демонстрационного прогона (docs/media/data/).

    python tools/demo/plot_demo.py [--kit ПУТЬ_К_МЕДИАКИТУ]

Данные — только журналы прогона в CODESYS Control Win V3 (python tools/demo/run_demo.py): здесь
они не пересчитываются и не сглаживаются, только рисуются. Оформление (палитра, шрифты, тренды,
временные диаграммы) — общий медиакит портфолио (charts.py); путь к нему — --kit или переменная
MEDIA_KIT, по умолчанию ../_scripts/media рядом с репозиторием. Результат — пары PNG
docs/media/chart-<что>-dark.png и -light.png.
"""

from __future__ import annotations

import argparse
import csv
import importlib
import json
import os
import sys
from pathlib import Path
from types import ModuleType
from typing import Any

import numpy as np
from matplotlib.patches import Patch

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
DATA = REPO / "docs" / "media" / "data"
OUT = REPO / "docs" / "media"

# Значения перечислений библиотеки (src/DUTs) и биты wStatus (GVL_Const)
MOTOR_STOPPED, MOTOR_STARTING, MOTOR_RUNNING = 0, 1, 2
PID_STS_SAT_HIGH = 0x0001
PID_STS_SAT_LOW = 0x0002
PID_STS_TRACKING = 0x0040
SIG_NAMES = {0: "Good", 1: "UnderRange", 2: "OverRange", 3: "FailLow", 4: "FailHigh", 5: "ChannelFault", 6: "NotFinite"}
NE107_NAMES = {0: "Good", 1: "Maintenance", 2: "OutOfSpec", 3: "CheckFunction", 4: "Failure"}
ALM_NAMES = {0: "Normal", 1: "ActiveUnack", 2: "ActiveAck", 3: "RtnUnack", 4: "Shelved", 5: "Suppressed", 6: "OOS"}
EV_LOOP = {1: "пуск насоса", 2: "задание 2,5 → 1,5 м", 3: "приток 120 → 210 м³/ч"}
EV_ALARM = {1: "квитирование", 2: "shelve 15 с"}


def load_kit(path: str | None) -> ModuleType:
    kit = Path(path or os.environ.get("MEDIA_KIT") or REPO.parent / "_scripts" / "media")
    if not (kit / "charts.py").is_file():
        raise SystemExit(f"нет медиакита {kit} (charts.py): укажите --kit или MEDIA_KIT")
    sys.path.insert(0, str(kit))
    return importlib.import_module("charts")


def load(name: str) -> dict[str, np.ndarray]:
    with (DATA / name).open(encoding="utf-8") as handle:
        rows = list(csv.DictReader(handle))
    return {k: np.array([float(r[k]) for r in rows]) for k in rows[0]}


def segments(t: np.ndarray, labels: list[str]) -> list[tuple[float, float, str]]:
    """Отсчёты -> отрезки (t0, t1, метка) для временной диаграммы; конец — следующий отсчёт."""
    out: list[tuple[float, float, str]] = []
    start = 0
    for i in range(1, len(labels) + 1):
        if i == len(labels) or labels[i] != labels[start]:
            t1 = float(t[i]) if i < len(t) else float(t[-1] + (t[-1] - t[-2]))
            out.append((float(t[start]), t1, labels[start]))
            start = i
    return out


def run_info() -> dict[str, Any]:
    info: dict[str, Any] = json.loads((DATA / "demo-run.json").read_text(encoding="utf-8"))
    return info


def source_line(info: dict[str, Any]) -> str:
    day = str(info.get("app_started") or "")[:10]
    day = ".".join(reversed(day.split("-"))) if day else ""
    return f"данные прогона в CODESYS Control Win {info.get('codesys_version')} · plc-process-lib 1.0.0.0 · {day}"


def timeline(
    ax: Any,
    lanes: dict[str, list[tuple[float, float, str]]],
    colors: dict[str, str],
    c: dict[str, Any],
    hatched: set[str] | None = None,
    legend: list[tuple[str, str]] | None = None,
    height: float = 0.62,
) -> None:
    """Временная диаграмма со своими цветами и штриховкой (неквитированные состояния)."""
    names = list(lanes)
    for i, name in enumerate(names):
        y = len(names) - 1 - i
        for t0, t1, st in lanes[name]:
            ax.broken_barh(
                [(t0, t1 - t0)],
                (y - height / 2, height),
                facecolors=colors[st],
                edgecolor=c["bg"],
                linewidth=1.2,
                hatch="////" if hatched and st in hatched else None,
            )
    ax.set_yticks(range(len(names)), list(reversed(names)))
    ax.tick_params(axis="y", labelcolor=c["muted"], labelsize=10.5, length=0)
    ax.grid(False)
    ax.set_ylim(-0.6, len(names) - 0.4)
    ax.margins(x=0)
    if legend:
        handles = [
            Patch(facecolor=colors[k], label=lab, hatch="////" if hatched and k in hatched else None)
            for k, lab in legend
        ]
        # под подписью оси X: отступ в дюймах, а не в долях оси — дорожки бывают разной высоты
        height_in = ax.get_position().height * ax.figure.get_figheight()
        ax.legend(
            handles=handles,
            loc="upper left",
            bbox_to_anchor=(0, -0.62 / height_in),
            ncols=len(handles),
            handlelength=1.4,
            handleheight=0.9,
            columnspacing=1.3,
            fontsize=10,
        )


def hatch_color(c: dict[str, Any]) -> None:
    import matplotlib.pyplot as plt

    plt.rcParams["hatch.color"] = c["bg"]
    plt.rcParams["hatch.linewidth"] = 1.4


# ---------------------------------------------------------------------------
# A: контур уровня
# ---------------------------------------------------------------------------


def chart_loop(ch: ModuleType, theme: str, info: dict[str, Any]) -> list[Path]:
    d = load("demo-level-loop.csv")
    ev = load("demo-events.csv")
    t = d["t_s"]
    with ch.style(theme) as c:
        fig, axes = ch.figure(3, [2.3, 1.7, 0.62], size=(10, 7.4))
        ax, ax2, ax3 = axes
        st = d["pid_status"].astype(int)
        sat = (st & PID_STS_SAT_HIGH) != 0
        for a in (ax, ax2):
            a.fill_between(
                t,
                0,
                1,
                where=sat,
                transform=a.get_xaxis_transform(),
                color=c["accent"],
                alpha=0.10 if theme == "dark" else 0.08,
                lw=0,
                step="post",
            )
        ax.plot(t, d["sp_m"], color=c["sp"], lw=1.4, ls=(0, (6, 3)), drawstyle="steps-post", label="SP, задание")
        ax.plot(t, d["pv_m"], color=c["pv"], lw=2.0, label="PV, уровень LT")
        ax.set_ylabel("м", color=c["dim"])
        ax.set_ylim(1.2, 2.75)
        ax.legend(
            loc="upper right",
            bbox_to_anchor=(1, 0.86),
            ncols=2,
            frameon=True,
            facecolor=c["bg"],
            edgecolor="none",
            framealpha=0.9,
        )
        # выход регулятора, задание ПЧ, интегральная составляющая
        ax2.axhline(100, color=c["neutral"], lw=1.0, ls=(0, (1.5, 3)))
        ax2.axhline(20, color=c["neutral"], lw=1.0, ls=(0, (1.5, 3)))
        ax2.plot(t, d["speed_act_pct"], color=c["series"][2], lw=1.6, label="скорость ПЧ")
        ax2.plot(t, d["i_pct"], color=c["series"][3], lw=1.4, ls=(0, (4, 2)), label="I-составляющая")
        ax2.plot(t, d["out_pct"], color=c["series"][1], lw=2.0, label="выход ПИД")
        ax2.set_ylabel("%", color=c["dim"])
        ax2.set_ylim(-5, 112)
        ax2.legend(
            loc="lower right",
            bbox_to_anchor=(1, 0.02),
            ncols=3,
            frameon=True,
            facecolor=c["bg"],
            edgecolor="none",
            framealpha=0.9,
        )
        ax2.annotate(
            "100 %",
            xy=(1.0, 100),
            xycoords=("axes fraction", "data"),
            xytext=(6, 0),
            textcoords="offset points",
            va="center",
            fontsize=9.5,
            color=c["muted"],
            family=c["mono"],
        )
        ax2.annotate(
            "мин. ПЧ 20 %",
            xy=(1.0, 20),
            xycoords=("axes fraction", "data"),
            xytext=(6, 0),
            textcoords="offset points",
            va="center",
            fontsize=9.5,
            color=c["muted"],
            family=c["mono"],
        )
        if sat.any():
            i0 = int(np.argmax(sat))
            i1 = i0 + int(np.argmax(~sat[i0:])) if (~sat[i0:]).any() else len(t) - 1
            ax2.annotate(
                "выход 100 %:\nI ограничена",
                xy=((t[i0] + t[i1]) / 2 + 1.5, 72),
                ha="center",
                va="center",
                fontsize=10,
                color=c["text"],
                linespacing=1.3,
                bbox={"boxstyle": "round,pad=0.35,rounding_size=0.3", "fc": c["bg"], "ec": "none", "alpha": 0.85},
            )
        # состояния насоса и регулятора
        mot = d["motor_state"].astype(int)
        motor = ["stop" if m == MOTOR_STOPPED else "start" if m == MOTOR_STARTING else "run" for m in mot]
        pid = [
            "track" if s & PID_STS_TRACKING else "sat" if s & (PID_STS_SAT_HIGH | PID_STS_SAT_LOW) else "auto"
            for s in st
        ]
        sc = c["states"]
        colors = {
            "stop": sc["stop"],
            "start": sc["standby"],
            "run": sc["run"],
            "track": sc["standby"],
            "auto": sc["run"],
            "sat": c["accent"],
        }
        timeline(
            ax3,
            {"насос": segments(t, motor), "ПИД": segments(t, pid)},
            colors,
            c,
            legend=[("stop", "стоп"), ("run", "работа / авто"), ("track", "слежение"), ("sat", "насыщение")],
        )
        ax3.set_xlabel("время, с", color=c["dim"])
        ax3.set_xlim(0, float(t[-1]))
        loop_ev = [
            (float(tt), EV_LOOP[int(cd)])
            for tt, sc_, cd in zip(ev["t_s"], ev["scenario"], ev["code"], strict=True)
            if int(sc_) == 1
        ]
        ch.mark_events(axes, loop_ev, c)
        ch.header(fig, "Контур уровня: AI → ПИД → ПЧ", source_line(info), c)
        return list(ch.save(fig, OUT / f"chart-level-loop-{theme}"))


# ---------------------------------------------------------------------------
# B: NE 43
# ---------------------------------------------------------------------------


def chart_ne43(ch: ModuleType, theme: str, info: dict[str, Any]) -> list[Path]:
    d = load("demo-ne43.csv")
    t = d["t_s"]
    with ch.style(theme) as c:
        fig, axes = ch.figure(3, [2.0, 1.3, 1.0], size=(10, 7.0))
        ax, ax2, ax3 = axes
        soft = 0.16 if theme == "dark" else 0.12
        ax.axhspan(-1, 3.6, color=c["alarm"], alpha=soft, lw=0)
        ax.axhspan(3.6, 3.8, color=c["warn"], alpha=soft * 1.8, lw=0)
        ax.axhspan(20.5, 21.0, color=c["warn"], alpha=soft * 1.8, lw=0)
        ax.axhspan(21.0, 26, color=c["alarm"], alpha=soft, lw=0)
        for y in (3.6, 3.8, 20.5, 21.0):
            ax.axhline(y, color=c["warn"], lw=0.9, alpha=0.9)
        for y, txt in ((3.7, "3.6 | 3.8"), (20.75, "20.5 | 21.0")):  # метки поля с точкой, как H 4.0
            ax.annotate(
                txt,
                xy=(1.0, y),
                xycoords=("axes fraction", "data"),
                xytext=(8, 0),
                textcoords="offset points",
                va="center",
                fontsize=9.5,
                color=c["muted"],
                family=c["mono"],
            )
        ax.plot(t, d["in_ma"], color=c["pv"], lw=2.0)
        ax.set_ylabel("мА", color=c["dim"])
        ax.set_ylim(-1, 25.5)
        ax.set_yticks([0, 4, 8, 12, 16, 20, 24])
        for x, y, txt, ha in (
            (0.995, 1.6, "отказ ≤ 3,6 мА", "right"),
            (0.995, 7.0, "норма 3,8…20,5 мА", "right"),
            (0.012, 23.2, "отказ ≥ 21,0 мА", "left"),
        ):
            ax.annotate(
                txt, xy=(x, y), xycoords=("axes fraction", "data"), ha=ha, va="center", fontsize=9.5, color=c["muted"]
            )
        ax.annotate(
            "ток на входе FB_AnalogInput;\nзащитные полосы NE 43: 3,6…3,8 и 20,5…21,0 мА",
            xy=(0.012, 15.5),
            xycoords=("axes fraction", "data"),
            ha="left",
            va="center",
            fontsize=9.5,
            color=c["muted"],
            linespacing=1.35,
        )
        # значение и достоверность
        valid = d["valid"] > 0.5
        ax2.fill_between(
            t,
            0,
            1,
            where=~valid,
            transform=ax2.get_xaxis_transform(),
            color=c["neutral"],
            alpha=0.22,
            lw=0,
            step="post",
        )
        ax2.plot(t, d["value_m"], color=c["series"][1], lw=2.0, drawstyle="steps-post")
        ax2.set_ylabel("м", color=c["dim"])
        ax2.set_ylim(-0.3, 5.6)
        ax2.annotate(
            "rValue_eu (шкала 0…5 м); серым — xValid = FALSE",
            xy=(0.012, 0.93),
            xycoords="axes fraction",
            ha="left",
            va="top",
            fontsize=9.5,
            color=c["muted"],
        )
        # классификация
        sig = [SIG_NAMES[int(v)] for v in d["signal"]]
        ne = [NE107_NAMES[int(v)] for v in d["ne107"]]
        val = ["valid" if v else "invalid" for v in valid]
        sc = c["states"]
        colors = {
            "Good": sc["normal"],
            "UnderRange": c["warn"],
            "OverRange": c["warn"],
            "FailLow": c["alarm"],
            "FailHigh": c["alarm"],
            "ChannelFault": c["alarm"],
            "NotFinite": c["alarm"],
            "OutOfSpec": c["warn"],
            "Failure": c["alarm"],
            "CheckFunction": c["violet"] if "violet" in c else sc["maint"],
            "Maintenance": sc["maint"],
            "valid": sc["run"],
            "invalid": sc["stop"],
        }
        timeline(
            ax3,
            {"eSignal": segments(t, sig), "NE 107": segments(t, ne), "xValid": segments(t, val)},
            colors,
            c,
            legend=[
                ("Good", "норма"),
                ("UnderRange", "вне диапазона / S"),
                ("FailLow", "отказ / F"),
                ("valid", "xValid = TRUE"),
                ("invalid", "FALSE"),
            ],
        )
        ax3.set_xlabel("время, с", color=c["dim"])
        ax3.set_xlim(0, float(t[-1]))
        ch.header(fig, "NAMUR NE 43: ток 0 → 24 мА, подтверждение 2 с", source_line(info), c)
        return list(ch.save(fig, OUT / f"chart-ne43-{theme}"))


# ---------------------------------------------------------------------------
# C: тревога ISA-18.2
# ---------------------------------------------------------------------------


def chart_alarm(ch: ModuleType, theme: str, info: dict[str, Any]) -> list[Path]:
    d = load("demo-alarm.csv")
    ev = load("demo-events.csv")
    t = d["t_s"]
    with ch.style(theme) as c:
        hatch_color(c)
        fig, axes = ch.figure(2, [2.0, 0.95], size=(10, 5.6))
        ax, ax2 = axes
        ch.trend(ax, t, d["level_m"], c, limits={"H": 4.0}, label="уровень", unit="м", fmt="{:.1f}")
        ax.axhline(3.9, color=c["warn"], lw=0.8, ls=(0, (1, 3)), alpha=0.8)
        ax.annotate(
            "гист. 3.9",
            xy=(1.0, 3.9),
            xycoords=("axes fraction", "data"),
            xytext=(14, 0),
            textcoords="offset points",
            va="center",
            fontsize=9.5,
            color=c["muted"],
            family=c["mono"],
        )
        ax.set_ylim(3.3, 4.55)
        state = [ALM_NAMES[int(v)] for v in d["state"]]
        cond = ["on" if v > 0.5 else "off" for v in d["h"]]
        sc = c["states"]
        colors = {
            "Normal": sc["normal"],
            "ActiveUnack": c["warn"],
            "ActiveAck": c["warn"],
            "RtnUnack": sc["ack"],
            "Shelved": sc["maint"],
            "Suppressed": sc["standby"],
            "OOS": sc["standby"],
            "on": c["warn"],
            "off": sc["normal"],
        }
        timeline(
            ax2,
            {"условие xH": segments(t, cond), "тревога H": segments(t, state)},
            colors,
            c,
            hatched={"ActiveUnack", "RtnUnack"},
            legend=[
                ("Normal", "Normal"),
                ("ActiveUnack", "ActiveUnack"),
                ("ActiveAck", "ActiveAck"),
                ("RtnUnack", "RtnUnack"),
                ("Shelved", "Shelved"),
            ],
        )
        ax2.set_xlabel("время, с", color=c["dim"])
        ax2.set_xlim(0, float(t[-1]))
        events = [
            (float(tt), EV_ALARM[int(cd)])
            for tt, sc_, cd in zip(ev["t_s"], ev["scenario"], ev["code"], strict=True)
            if int(sc_) == 3
        ]
        ch.mark_events(axes, events, c)
        # истечение shelve — переход Shelved -> ActiveUnack в журнале; подпись внизу, между линиями событий
        for k in range(1, len(state)):
            if state[k - 1] == "Shelved" and state[k] != "Shelved":
                for a in axes:
                    a.axvline(float(t[k]), color=c["dim"], lw=1.0, ls=(0, (2, 3)), zorder=1)
                ax.annotate(
                    "срок shelve\nистёк",
                    xy=(float(t[k]), 3.72),
                    xytext=(-5, 0),
                    textcoords="offset points",
                    ha="right",
                    va="center",
                    fontsize=10,
                    color=c["muted"],
                    linespacing=1.25,
                )
        ch.header(fig, "Тревога ISA-18.2: уровень выше H 4,0 м", source_line(info), c)
        return list(ch.save(fig, OUT / f"chart-isa18-alarm-{theme}"))


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n", 1)[0] if __doc__ else None)
    parser.add_argument("--kit", help="каталог медиакита (charts.py)")
    parser.add_argument("--only", choices=("loop", "ne43", "alarm"), help="только один график")
    args = parser.parse_args(argv)
    ch = load_kit(args.kit)
    info = run_info()
    builders = {"loop": chart_loop, "ne43": chart_ne43, "alarm": chart_alarm}
    for key, build in builders.items():
        if args.only and key != args.only:
            continue
        for theme in ("dark", "light"):
            for path in build(ch, theme, info):
                print(f"[plot] {path.relative_to(REPO).as_posix()} ({path.stat().st_size // 1024} КБ)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
