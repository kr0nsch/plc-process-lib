# -*- coding: utf-8 -*-
"""Шаг demo демонстрационного прогона — скрипт CODESYS Scripting (IronPython 2.7).

Запуск — только через tools/demo/run_demo.py: задание из трёх шагов в одном процессе CODESYS —
import (tools/demo/src/ на библиотеке plc-process-lib 1.0.0.0), build и demo. Шаги import и
build — общие скрипты tools/codesys/, шаг demo — этот файл:

1. вход в CODESYS Control Win V3 и загрузка приложения — те же функции, что у шага test
   (tools/codesys/run_tests.py: setup_gateway, login);
2. oa.start(); опрос GVL_DemoLog.xAllDone до таймаута (сценарии идут в реальном времени);
3. чтение журналов GVL_DemoLog (read_values пачками) и запись step["results"] (JSON);
4. oa.stop(); oa.logout().

Пути к tools/codesys и к этому каталогу передаются в задании (codesys_tools, demo_tools): так
скрипт находит cds_common и run_tests без допущений о текущем каталоге CODESYS.
"""
from __future__ import absolute_import, print_function, unicode_literals

import io
import json
import os
import sys
import time


def _bootstrap():
    # type: () -> None
    path = os.environ.get('CDS_JOB')
    if not path or not os.path.isfile(path):
        return
    with io.open(path, 'r', encoding='utf-8') as handle:
        job = json.loads(handle.read())
    for key in ('codesys_tools', 'demo_tools'):
        folder = job.get(key)
        if folder and folder not in sys.path:
            sys.path.insert(0, folder)


_bootstrap()

import cds_common as C  # noqa: E402
import run_tests as RT  # noqa: E402

GVL = 'GVL_DemoLog'
CHUNK = 200

# Журналы: имя серии -> (счётчик, массив); счётчик общий для серий сценария
SERIES = [
    ('loop', 'uiLoopN', [
        ('t_s', 'arLoopT_s'), ('level_m', 'arLoopLevel_m'), ('pv_m', 'arLoopPv_m'), ('sp_m', 'arLoopSp_m'),
        ('out_pct', 'arLoopOut_pct'), ('p_pct', 'arLoopP_pct'), ('i_pct', 'arLoopI_pct'),
        ('speed_ref_pct', 'arLoopRef_pct'), ('speed_act_pct', 'arLoopAct_pct'), ('qin_m3h', 'arLoopQin_m3h'),
        ('qout_m3h', 'arLoopQout_m3h'), ('motor_state', 'aiLoopMotor'), ('pid_status', 'awLoopPidSts'),
    ]),
    ('ne43', 'uiNe43N', [
        ('t_s', 'arNe43T_s'), ('in_ma', 'arNe43In_mA'), ('value_m', 'arNe43Value_m'), ('valid', 'axNe43Valid'),
        ('signal', 'aiNe43Signal'), ('ne107', 'aiNe43Ne107'), ('status', 'awNe43Sts'),
        ('alm_active', 'awNe43AlmActive'),
    ]),
    ('alarm', 'uiAlmN', [
        ('t_s', 'arAlmT_s'), ('level_m', 'arAlmLevel_m'), ('h', 'axAlmH'), ('state', 'aiAlmState'),
        ('unack', 'awAlmUnack'), ('shelved', 'awAlmShelved'),
    ]),
    ('events', 'uiEvN', [
        ('t_s', 'arEvT_s'), ('scenario', 'aiEvScenario'), ('code', 'aiEvCode'),
    ]),
]


def read_many(reader, exprs):
    # type: (Any, List[str]) -> List[Any]
    out = []  # type: List[Any]
    for k in range(0, len(exprs), CHUNK):
        out.extend(reader.values(exprs[k:k + CHUNK]))
    return out


def run(ctx, step):
    # type: (C.Context, Dict[str, Any]) -> Dict[str, Any]
    log = C.Log(step.get('log'))
    se = C.api()
    oa = None
    data = {
        'schema': 1,
        'started': time.strftime('%Y-%m-%dT%H:%M:%S'),
        'project': step.get('project'),
        'finished': False,
    }  # type: Dict[str, Any]
    data.update(step.get('meta') or {})
    try:
        timeout_s = float(step.get('timeout_s') or 300)
        creds = RT.read_credentials(step['credentials'])
        proj, _ = ctx.open_project(step['project'], create=False, log=log)
        app = C.application(proj)
        dev = C.find_device(proj)
        if dev is None:
            raise C.StepError('в проекте нет устройства')
        target = RT.setup_gateway(dev, step.get('runtime') or {}, log)
        log.info('вход в рантайм и загрузка приложения')
        oa = RT.login(app, dev, creds, target, log)
        log.info('приложение загружено, состояние %s' % C._text(oa.application_state))
        reader = RT.Reader(oa, log)
        oa.start()
        started = time.time()
        data['app_started'] = time.strftime('%Y-%m-%dT%H:%M:%S')
        finished = False
        while time.time() - started < timeout_s:
            se.system.delay(1000)
            if reader.value(GVL + '.xAllDone') is True:
                finished = True
                break
        data['finished'] = finished
        data['wait_s'] = round(time.time() - started, 1)
        log.info('сценарии %s за %s с' % ('завершены' if finished else 'НЕ завершены', data['wait_s']))
        series = {}  # type: Dict[str, Any]
        for name, counter, columns in SERIES:
            n = reader.value('%s.%s' % (GVL, counter))
            if not isinstance(n, int):
                raise C.StepError('не прочитан счётчик %s.%s: %r' % (GVL, counter, n))
            table = {}  # type: Dict[str, List[Any]]
            for col, arr in columns:
                exprs = ['%s.%s[%d]' % (GVL, arr, i) for i in range(n)]
                table[col] = read_many(reader, exprs)
            series[name] = {'n': n, 'columns': [c for c, _ in columns], 'data': table}
            log.info('журнал %s: %d отсчётов' % (name, n))
        data['series'] = series
        data['ok'] = finished
        out = {'ok': finished, 'finished': finished, 'results': step.get('results'),
               'counts': dict((k, v['n']) for k, v in series.items())}
        if not finished:
            out['error'] = 'сценарии не завершились за %s с (GVL_DemoLog.xAllDone)' % timeout_s
        return out
    except Exception as exc:
        data['ok'] = False
        data['error'] = C._text(exc)
        log.error('%s' % exc)
        raise
    finally:
        if oa is not None:
            try:
                oa.stop()
                log.info('приложение остановлено')
            except Exception as exc:
                log.warn('stop: %s' % exc)
            try:
                oa.logout()
                log.info('выход из рантайма')
            except Exception as exc:
                log.warn('logout: %s' % exc)
        data['ended'] = time.strftime('%Y-%m-%dT%H:%M:%S')
        if step.get('results'):
            try:
                C.write_json(step['results'], data)
            except Exception:
                pass
        log.close()


MYPY = False
if MYPY:  # pragma: no cover
    from typing import Any, Dict, List  # noqa: F401


if __name__ == '__main__':
    C.ACTION_MODULES['demo'] = 'demo_capture'
    C.run_main('demo')
