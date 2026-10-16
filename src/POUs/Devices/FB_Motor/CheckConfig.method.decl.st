// Проверка конфигурации двигателя: биты 0–3 wCfgErr (13.9). Только считает, ничего не меняет.
// FB_MotorVfd переопределяет: SUPER^.CheckConfig OR биты ПЧ 8–11
METHOD PROTECTED CheckConfig : WORD
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT — параметр, а не константа, см. docs/STATIC_ANALYSIS.md
    stCfgIn : ST_MotorCfg;   // проверяемая конфигурация
END_VAR
VAR
    wErr : WORD;             // непройденные проверки
END_VAR
