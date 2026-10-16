// Цикл — вход в Open, если прошлое крайнее положение не Open: открыть (1), закрыть (1), открыть (2) —
// stRetain и stSts. Неполный ход Open -> стоп -> снова Open циклом не считается. xResetMaint обнуляет
// счётчик «с ТО», полный не трогает. Перед каждой сменой направления арматура стоит 1 с: встречный ход
// начинается не раньше tReverse после снятия выхода (тест Valve_ReverseAfterEndStop_WaitsReversePause).
METHOD PRIVATE CyclesCountedOnOpen
VAR
    fbTime   : FB_FakeTime;       // подменное время, старт 1 ч
    fbVlv    : FB_Valve;          // арматура под тестом
    stCmd    : ST_ValveCmd;       // команды HMI
    stRetain : ST_DeviceRetain;   // режим Manual по умолчанию, счётчики
    stCfg    : ST_ValveCfg;       // конфигурация (умолчания: Motorized, ZSO и ZSC)
    iStep    : INT;               // шаг цикла
END_VAR
