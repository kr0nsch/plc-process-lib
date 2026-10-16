IF NOT F_IsFinite(rIn := stCfgIn.rGain) OR stCfgIn.rGain <= 0.0 THEN
    wErr := wErr OR CFG_GAIN;
END_IF
IF NOT CheckAlarmCfg(astCfg := stCfgIn.astAlarm) THEN
    wErr := wErr OR CFG_ALARM;
END_IF
CheckConfig := wErr;
