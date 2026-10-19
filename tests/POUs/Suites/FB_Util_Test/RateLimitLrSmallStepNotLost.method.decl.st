// F_RateLimitLr: состояние в LREAL — 1000 шагов по 1 мс со скоростью 0,003 ед./с от 70,0 дают 70,003 (в REAL
// приращение 3·10⁻⁶ меньше половины шага REAL рядом с 70 и терялось бы); спад — так же; цель достигается точно.
METHOD PRIVATE RateLimitLrSmallStepNotLost
VAR
    lrUp   : LREAL;          // рост: состояние рампы
    lrDown : LREAL;          // спад: состояние рампы
    iStep  : INT;            // шаг цикла
END_VAR
