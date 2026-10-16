// Local (позиционер на месте): выход сразу следует ОС 37 % без рампы, задание Manual тоже; ОС
// недостоверна — удержание и CV_WRN_FB_INVALID; ОС 42 % — 42 %. Возврат в Manual — без рывка.
METHOD PRIVATE LocalTracksFeedback
VAR
    fbTime   : FB_FakeTime;          // подменное время, старт 1 ч
    fbCv     : FB_ControlValve;      // клапан под тестом
    stCmd    : ST_ControlValveCmd;   // команды HMI
    stRetain : ST_DeviceRetain;      // режим Manual по умолчанию
    stCfg    : ST_ControlValveCfg;   // конфигурация (умолчания: 0…100 %, без рампы)
END_VAR
