// Контур уровня КНС по примеру 17.3 контракта: LT (AI 4–20 мА, 0..10 м) -> LIC (ПИД Direct, Kp 2, Ti 20 с,
// xUseOutAct) -> ведущий насос (ПЧ, rSpeedMin 30 %); xTrack := NOT SpeedAutoActive, rTrack = rOutAct = SpeedRef с
// прошлого цикла. (1) Насос стоит в Auto — ПИД следит, выход = заданию ПЧ (0 %), Available = FALSE. (2) Пуск:
// Starting — ПИД ещё следит (30 % — предустановка ПЧ); Running — слежение снято, выход ПИД без рывка (30 %).
// (3) Уровень 4,8 м ниже задания 5 м 10 мин: ПИД просит меньше минимума, задание ПЧ держится на 30 %, выход ПИД по
// обратному расчёту от rOutAct не уходит в 0: 30 + P = 30 - 2·2 = 26 %. (4) Уровень 5,2 м — задание ПЧ сразу 34 %
// (30 + P), без задержки на «раскрутку» интегратора.
METHOD PRIVATE AiPidVfdTracksBumplessNoWindup
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbAi     : FB_AnalogInput;       // LT: уровень 4–20 мА, 0..10 м
    stAiCmd  : ST_AnalogInputCmd;    // его команды
    stAiCfg  : ST_AnalogInputCfg;    // его Cfg
    fbPid    : FB_PID;               // LIC: регулятор уровня
    stPidCmd : ST_PidCmd;            // его команды
    stPidRet : ST_DeviceRetain;      // его режим
    stPidCfg : ST_PidCfg;            // его Cfg
    fbVfd    : FB_MotorVfd;          // ведущий насос с ПЧ
    stVfdCmd : ST_MotorCmd;          // его команды
    stVfdRet : ST_DeviceRetain;      // его режим и счётчики
    stVfdCfg : ST_MotorCfg;          // его Cfg
END_VAR
