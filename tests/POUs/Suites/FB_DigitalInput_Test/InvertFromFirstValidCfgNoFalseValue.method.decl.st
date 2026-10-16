// Корректная Cfg появилась не в первом вызове (на старте Cfg была испорчена, наладчик исправил её с HMI): задержки
// предустанавливаются по сигналу с инверсией из этой Cfg, а не по сигналу без инверсии, который считался по
// умолчаниям Cfg. Поплавок «сухой ход», НЗ-контакт (xInvert), задержки 2 с: A — контакт замкнут (норма) — значение
// FALSE сразу, без ложного «сухого хода» на tOffDelay; B — контакт разомкнут (сработал) — TRUE сразу, без пропуска
// срабатывания на tOnDelay.
METHOD PRIVATE InvertFromFirstValidCfgNoFalseValue
VAR
    fbTime : FB_FakeTime;          // подменное время
    fbDiA  : FB_DigitalInput;      // контакт замкнут
    fbDiB  : FB_DigitalInput;      // контакт разомкнут
    stCmdA : ST_DigitalInputCmd;   // команды A
    stCmdB : ST_DigitalInputCmd;   // команды B
    stCfg  : ST_DigitalInputCfg;   // конфигурация
    uEnum  : U_AiDiTestEnum;       // значение вне строгого перечисления
END_VAR
