// Помощник: uiN вызовов двигателя, перед каждым — шаг подменного времени tDt (T#0S — тот же момент).
// Входы двигателя тест пишет по имени экземпляра до вызова помощника; ассертов внутри нет
METHOD PRIVATE Spin
VAR_IN_OUT
    fbM : FB_Motor;          // двигатель
    fbT : FB_FakeTime;       // подменное время
    stC : ST_MotorCmd;       // команды
    stR : ST_DeviceRetain;   // энергонезависимые данные
END_VAR
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT — параметр, а не константа, см. docs/STATIC_ANALYSIS.md
    stF : ST_MotorCfg;       // конфигурация
END_VAR
VAR_INPUT
    uiN : UINT;              // число вызовов
    tDt : TIME;              // шаг времени перед каждым вызовом
END_VAR
VAR
    uiLoop : UINT;           // номер вызова
END_VAR
