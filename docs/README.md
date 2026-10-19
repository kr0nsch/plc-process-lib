# Документация plc-process-lib

Начните с [USAGE.md](USAGE.md), если нужно подключить библиотеку к своему проекту, и с документа нужного ФБ в
[fb/](fb/), если нужно разобраться в конкретном устройстве. Обзор проекта — [README](../README.md).

| Документ | О чём |
|---|---|
| [USAGE.md](USAGE.md) | руководство: установка, объявление и вызов устройств, журнал тревог, связь с HMI/SCADA и Modbus, частые ошибки |
| [fb/](fb/) | по документу на ФБ: входы и выходы, команды, параметры, режимы, состояния, карты битов и регистров, пример вызова, тесты; [fb/_TEMPLATE.md](fb/_TEMPLATE.md) — шаблон такого документа |
| [API.md](API.md) | нормативный контракт API 1.0.0: имена, типы, поведение, раскладка регистров, порядок тела устройства, список тестов |
| [ARCHITECTURE.md](ARCHITECTURE.md) | обзор `src/`: состав, иерархия классов, общие типы, энергонезависимые данные, тревоги, константы, контуры проверок |
| [DECISIONS.md](DECISIONS.md) | рассмотренные варианты API и факты проверочных компиляций |
| [ASSUMPTIONS.md](ASSUMPTIONS.md) | допущения и решения реализации, открытые вопросы и правила наладки |
| [MANUAL_STEPS.md](MANUAL_STEPS.md) | шаги в консоли и IDE: CODESYS, coUnit, рантайм, сборка библиотеки, Persistent Variables, релиз |
| [TEST_REPORT.md](TEST_REPORT.md) | последний прогон тестов в CODESYS, что проверяет каждый тест, мутации, находки ревью |
| [STATIC_ANALYSIS.md](STATIC_ANALYSIS.md) | линтер, iec_checker, RuSTy: итоги и разбор находок |
| [TESTING.md](TESTING.md) | соглашения тестов coUnit |
| [STYLE_GUIDE.md](STYLE_GUIDE.md), [LAYOUT.md](LAYOUT.md) | стиль ST и раскладка исходников по файлам |
| [CONSUMERS.md](CONSUMERS.md) | что изменить в проектах на библиотеке после выпуска 1.0.0 |
| [BUILD_ERRORS.md](BUILD_ERRORS.md) | журнал сообщений сборки из IDE для разбора |
| [alarm_templates.csv](alarm_templates.csv) | шаблоны текстов тревог для HMI и SCADA |
| [media/](media/) | баннер, GIF и графики README; [media/data/](media/data/) — данные демо-прогона |
