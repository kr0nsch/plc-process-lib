// Каждая проверка CheckConfig ставит свой бит wCfgErr (карта 11.5): тип входа вне перечисления, шкала, порядок уставок,
// уставка вне шкалы, гистерезис (< 0 и >= диапазона), отсечка (вне 0…20 %), значение отказа (вне перечисления и NaN),
// приоритет тревоги вне перечисления, шкала отсчётов Raw. Один экземпляр: wCfgErr — результат проверки этого вызова.
METHOD PRIVATE CfgErrBitsMatchContractMap
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    stBad  : ST_AnalogInputCfg;   // испорченная копия
    uEnum  : U_AiDiTestEnum;      // значение вне строгого перечисления
    uPrio  : U_TestEnumInt;       // приоритет вне перечисления
    uBits  : U_RealBits;          // NaN по битам
END_VAR
