"""Демонстрационный прогон ФБ plc-process-lib в CODESYS Control Win V3 и выгрузка журналов в CSV.

    python tools/demo/run_demo.py              # импорт, сборка, прогон (~2,5 мин реального времени), CSV
    python tools/demo/run_demo.py --csv-only   # только пересобрать CSV из tools/demo/build/demo-results.json

Приложение — tools/demo/src/ (раскладка ST как у src/), библиотека — установленная
plc-process-lib 1.0.0.0 (python tools/codesys/cds.py library --compiled --install). Настройки —
tools/demo/config.json; корень «репозитория» для cds — tools/demo, поэтому проект и журналы CODESYS
лежат в tools/demo/build/ (вне git). Блокировки и рантайм — общие с cds.py: прогон ждёт, если
рантайм занят тестами другого репозитория.

Результат — CSV в docs/media/data/ (по сценарию на файл) и demo-run.json с условиями прогона;
графики README строит tools/demo/plot_demo.py.
"""

from __future__ import annotations

import argparse
import csv
import datetime as dt
import json
import os
import sys
from pathlib import Path
from typing import Any

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
sys.path.insert(0, str(REPO / "tools" / "codesys"))

from cdshost import cli  # noqa: E402

RESULTS = HERE / "build" / "demo-results.json"
DATA_DIR = REPO / "docs" / "media" / "data"
CSV_NAMES = {
    "loop": "demo-level-loop.csv",
    "ne43": "demo-ne43.csv",
    "alarm": "demo-alarm.csv",
    "events": "demo-events.csv",
}
DEMO_TIMEOUT_S = 300.0
META_KEYS = ("codesys_version", "profile", "device", "runtime", "library", "task")
RUN_KEYS = ("started", "app_started", "ended", "wait_s", "commit")


def make_settings() -> cli.Settings:
    os.environ["CDS_CONFIG"] = str(HERE / "config.json")
    return cli.make_settings(repo_root=HERE)


def demo_step(settings: cli.Settings, project: Path) -> dict[str, Any]:
    """Шаг demo: то же подключение к рантайму, что у шага test (cli.test_step), без настроек coUnit."""
    return {
        "action": "demo",
        "project": str(project),
        "credentials": str(settings.path("runtime.credentials")),
        "runtime": {
            "gateway_name": str(settings.value("runtime.gateway.name")),
            "gateway_host": str(settings.value("runtime.gateway.host")),
            "gateway_port": int(settings.number("runtime.gateway.port")),
            "device_address": str(settings.value("runtime.device_address")),
            "device_port": int(settings.number("runtime.port")),
        },
        "timeout_s": DEMO_TIMEOUT_S,
        "meta": {
            "codesys_version": str(settings.value("codesys.version")),
            "profile": settings.profile,
            "device": settings.device_label(),
            "runtime": str(settings.value("runtime.title")),
            "library": settings.library_spec("plc-process-lib").get("label"),
            "task": "MainTask 10 мс, PRG_Demo",
        },
        "log": str(HERE / "build" / "demo.log"),
        "results": str(RESULTS),
    }


def run_demo(settings: cli.Settings) -> int:
    project = settings.project_path(False)
    runtime: dict[str, Any] = {}

    def run() -> dict[str, Any]:
        with cli.repo_lock(settings, "demo"), cli.runtime_lock(settings, "demo plc-process-lib"):
            RESULTS.unlink(missing_ok=True)
            runtime.update(cli.ensure_runtime(settings))
            job = {
                "codesys_tools": str(REPO / "tools" / "codesys"),
                "demo_tools": str(HERE),
                "steps": [
                    cli.import_step(settings, False, project, clean=True),
                    cli.build_step(settings, project),
                    demo_step(settings, project),
                ],
            }
            timeout = settings.number("codesys.timeout_s") + DEMO_TIMEOUT_S
            return cli.run_codesys(settings, str(HERE / "demo_capture.py"), job, "demo", timeout_s=timeout)

    result = cli.run_with_deps(settings, run, True)
    cli.annotate_build(settings, result)
    code = cli._finish(result)
    if RESULTS.exists():
        data = json.loads(RESULTS.read_text(encoding="utf-8"))
        data["commit"] = cli._git_commit(REPO)  # с суффиксом -dirty, если рабочая копия изменена
        data["runtime_process"] = runtime
        RESULTS.write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    return code


def write_csv(results: Path = RESULTS, out_dir: Path = DATA_DIR) -> list[Path]:
    """Журналы из JSON шага demo -> CSV (UTF-8, LF) и demo-run.json с условиями прогона."""
    data = json.loads(results.read_text(encoding="utf-8"))
    if not data.get("finished"):
        raise SystemExit(f"{results}: прогон не завершён — CSV не пишутся")
    out_dir.mkdir(parents=True, exist_ok=True)
    written: list[Path] = []
    for name, table in data["series"].items():
        cols: list[str] = table["columns"]
        rows = zip(*(table["data"][c] for c in cols), strict=True)
        path = out_dir / CSV_NAMES[name]
        with path.open("w", encoding="utf-8", newline="") as handle:
            writer = csv.writer(handle, lineterminator="\n")
            writer.writerow(cols)
            for row in rows:
                writer.writerow([_cell(v) for v in row])
        written.append(path)
    meta = {k: data.get(k) for k in META_KEYS + RUN_KEYS}
    meta["counts"] = {k: v["n"] for k, v in data["series"].items()}
    meta["exported"] = dt.datetime.now().isoformat(timespec="seconds")
    meta["source"] = "python tools/demo/run_demo.py (tools/demo/src/PRG_Demo, журналы GVL_DemoLog)"
    meta_path = out_dir / "demo-run.json"
    meta_path.write_text(json.dumps(meta, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n")
    written.append(meta_path)
    return written


def _cell(value: Any) -> str:
    if isinstance(value, bool):
        return "1" if value else "0"
    if isinstance(value, float):
        return f"{value:.6g}"
    return str(value)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n", 1)[0] if __doc__ else None)
    parser.add_argument("--csv-only", action="store_true", help="только CSV из прошлого прогона")
    args = parser.parse_args(argv)
    code = 0
    if not args.csv_only:
        code = run_demo(make_settings())
    if code == 0:
        for path in write_csv():
            print(f"[demo] {path.relative_to(REPO).as_posix()}")
    return code


if __name__ == "__main__":
    sys.exit(main())
