// Счётчики «по кругу» (uiCmdSeq, udiSeq): UINT 65535 + 1 и UDINT 4294967295 + 1 дают 0 без
// исключения на Control Win V3.
METHOD PRIVATE UnsignedCountersWrapToZero
VAR
    uiCnt  : UINT := 65535;         // счётчик UINT на пределе
    udiCnt : UDINT := 4294967295;   // счётчик UDINT на пределе
END_VAR
