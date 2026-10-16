// NaN на входе (например, ошибка обмена REAL): NotFinite, значение удерживается до подтверждения (tFailDelay 1 с),
// затем Failure и бит AI_FLT_NOT_FINITE; +Inf и 1E31 (больше REAL_SANE_MAX) — тоже NotFinite. После возврата значение
// конечно и равно новому: NaN не попал в фильтр.
METHOD PRIVATE NaNInputTreatedAsFailure
VAR
    fbTime : FB_FakeTime;         // подменное время
    fbAi   : FB_AnalogInput;      // ФБ под тестом
    stCmd  : ST_AnalogInputCmd;   // команды
    stCfg  : ST_AnalogInputCfg;   // конфигурация
    iStep  : INT;                 // шаг цикла
    uBits  : U_RealBits;          // NaN и Inf по битам IEEE 754
END_VAR
