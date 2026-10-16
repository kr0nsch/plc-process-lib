// Назначение: межсемейные тесты устройств библиотеки (F-26): все семь типов на настоящих ФБ —
//             FB_AnalogInput, FB_DigitalInput, FB_Motor, FB_MotorVfd, FB_Valve, FB_ControlValve,
//             FB_PID. Умолчания Cfg проходят CheckConfig, тип устройства в stSts.stCommon.eDevType,
//             число слотов тревог через I_Device. Время — только FB_FakeTime.
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Межсемейные тесты»
FUNCTION_BLOCK FB_Integration_Test EXTENDS coUnit.FB_TestSuite
