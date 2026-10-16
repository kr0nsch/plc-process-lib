// Назначение: общий заголовок состояния — первое поле stCommon каждой ST_<Dev>Sts.
//             Все 14 полей 16-битные: 28 байт, 14 регистров Modbus подряд. Раскладка
//             нормативна (тест Common_SizeOfSts_MatchesRegisterMap).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/ARCHITECTURE.md, раздел «Общие типы»
{attribute 'qualified_only'}
TYPE ST_DeviceSts :
STRUCT
    wStatus     : WORD;              // биты 0–7 по типу устройства, 8–15 общие (DEV_STS_*)
    wFault      : WORD;              // причины отказа (карта по типу)
    wWarning    : WORD;              // предупреждения (карта по типу)
    wCfgErr     : WORD;              // непройденные проверки Cfg (карта по типу)
    eMode       : E_DeviceMode := E_DeviceMode.Manual;
    eNe107      : E_Ne107Status := E_Ne107Status.CheckFunction;   // до первого вызова — «не проверено»
    eCmdResult  : E_CmdResult := E_CmdResult.None;
    uiCmdSeq    : UINT;              // +1 на каждую обработанную команду (по кругу)
    wAlmActive  : WORD;              // бит i: условие тревоги слота i активно (после задержек)
    wAlmUnack   : WORD;              // бит i: тревога слота i не квитирована
    wAlmShelved : WORD;              // бит i: слот в Shelved, SuppressedByDesign или OutOfService
    ePrioUnack  : E_AlarmPriority := E_AlarmPriority.None;   // наивысший приоритет среди неквитированных
    eDevType    : E_DeviceType := E_DeviceType.None;         // тип устройства
    wReserve    : WORD;              // резерв; держит размер кратным 4 байтам
END_STRUCT
END_TYPE
