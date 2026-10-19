FOR uiLoop := 1 TO uiN DO
    fbT.Advance(tStep := tDt);
    xLeadAuto := fbVfd.SpeedAutoActive;
    rLeadRef := fbVfd.SpeedRef;
    fbAi(itfTime := fbT, rIn := rLevel_mA, stCmd := stAiCmd, stCfg := stAiCfg);
    fbPid(itfTime := fbT, rPv_eu := fbAi.rValue_eu, xPvValid := fbAi.xValid, xTrack := NOT xLeadAuto,
          rTrack_pct := rLeadRef, rOutAct_pct := rLeadRef, stCmd := stPidCmd, stRetain := stPidRet, stCfg := stPidCfg);
    fbVfd.rSpeedSpAuto_pct := fbPid.rOut_pct;
    fbVfd(itfTime := fbT, stCmd := stVfdCmd, stRetain := stVfdRet, stCfg := stVfdCfg);
    fbVfd.xVfdRunning := fbVfd.xQRun;
    fbVfd.rSpeedAct_pct := SEL(fbVfd.xQRun, 0.0, fbVfd.rSpeedRef_pct);
END_FOR
