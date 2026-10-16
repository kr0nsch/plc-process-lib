// Проверка конфигурации: биты wCfgErr тестового устройства. Только считает, ничего не меняет
METHOD PROTECTED CheckConfig : WORD
VAR_IN_OUT CONSTANT
    // lint:allow STL007 VAR_IN_OUT CONSTANT — параметр, а не константа, см. docs/STATIC_ANALYSIS.md
    stCfgIn : ST_TestDeviceCfg;   // проверяемая конфигурация
END_VAR
VAR
    wErr : WORD;                  // непройденные проверки
END_VAR
