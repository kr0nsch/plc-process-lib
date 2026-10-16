// Инвариант: xQOpen AND xQClose никогда не TRUE. 600 циклов по 0,1 с с моделью хода (30 шагов от ZSC до
// ZSO): команды открыть, закрыть, стоп с разными периодами, переходы в Auto с переменным запросом,
// блокировки и пропадающее разрешение на открытие. Проверяется и то, что сценарий открывал, закрывал и
// реверсировал (тест не пустой).
METHOD PRIVATE NeverBothOutputs
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv     : FB_Valve;          // арматура под тестом
    stCmd     : ST_ValveCmd;       // команды HMI
    stRetain  : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg     : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep     : INT;               // шаг цикла
    iPos      : INT;               // положение модели, шаги 0…30
    xEverBoth : BOOL;              // оба выхода хоть раз
    xSawOpen  : BOOL;              // открывала
    xSawClose : BOOL;              // закрывала
    xSawRev   : BOOL;              // реверсировала
END_VAR
