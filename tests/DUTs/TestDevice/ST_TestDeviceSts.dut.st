// Назначение: состояние тестового устройства FB_TestDevice: общий заголовок и значение по LKG.
//             Только для тестов.
// Автор:      kr0nsch
// Версия:     0.1.0
// Документ:   docs/TESTING.md, раздел «Тестовое устройство»
{attribute 'qualified_only'}
TYPE ST_TestDeviceSts :
STRUCT
    stCommon : ST_DeviceSts;   // общий заголовок
    rOut_eu  : REAL;           // значение по конфигурации LKG: rGain * 10
END_STRUCT
END_TYPE
