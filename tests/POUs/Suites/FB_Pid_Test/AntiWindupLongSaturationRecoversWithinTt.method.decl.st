// Anti-windup обратным расчётом (Kp = 1, Ti = 10 с, Tt = авто = Ti): 60 с на верхнем пределе при
// ошибке +20 %, затем ошибка -20 %. С обратным расчётом интегратор ограничен (v ≈ 100 + Tt·Kp·e/Ti)
// и выход уходит с предела сразу; для сравнения тот же ФБ с Tt = 1·10^6 с (обратного расчёта
// практически нет) остаётся на пределе и через Tt после смены знака.
METHOD PRIVATE AntiWindupLongSaturationRecoversWithinTt
VAR
    fbTime    : FB_FakeTime;       // подменное время, старт 1 ч
    fbPidAw   : FB_PID;            // ФБ под тестом: Tt = авто
    fbPidNoAw : FB_PID;            // сравнение: Tt = 1e6 с
    stCmdAw   : ST_PidCmd;         // команды
    stCmdNoAw : ST_PidCmd;
    stRetAw   : ST_DeviceRetain;   // режим: старт в Manual
    stRetNoAw : ST_DeviceRetain;
    stCfgAw   : ST_PidCfg;         // конфигурация
    stCfgNoAw : ST_PidCfg;
    iStep     : INT;               // шаг цикла
    rOutSatAw : REAL;              // выход в конце насыщения
    rISatAw   : REAL;              // интегратор в конце насыщения
    rISatNoAw : REAL;
    rOutRevAw : REAL;              // выход в первом шаге после смены знака ошибки
    rOutRevNo : REAL;
END_VAR
