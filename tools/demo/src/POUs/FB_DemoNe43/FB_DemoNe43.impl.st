IF NOT xInit THEN
    xInit := TRUE;
    stAiCfg.rRangeHi_eu := LEVEL_SPAN_M;   // остальное — умолчания: MilliAmp, tFailDelay 2 с, HoldLast
END_IF
IF xDone THEN
    RETURN;
END_IF

// Ток по профилю
rIn_mA := PROFILE_I_MA[PROFILE_LAST];
FOR uiSeg := 1 TO PROFILE_LAST DO
    IF lrT_s < PROFILE_T_S[uiSeg] THEN
        rIn_mA := F_DemoInterp(lrT0_s := PROFILE_T_S[uiSeg - 1], rV0 := PROFILE_I_MA[uiSeg - 1],
                               lrT1_s := PROFILE_T_S[uiSeg], rV1 := PROFILE_I_MA[uiSeg], lrT_s := lrT_s);
        EXIT;
    END_IF
END_FOR

fbAi(rIn := rIn_mA, stCmd := stAiCmd, stCfg := stAiCfg);

// Журнал с периодом NE43_LOG_PERIOD_S
IF lrT_s >= lrNextLog_s AND GVL_DemoLog.uiNe43N < GVL_DemoConst.NE43_LOG_N THEN
    uiIdx := GVL_DemoLog.uiNe43N;
    GVL_DemoLog.arNe43T_s[uiIdx] := LREAL_TO_REAL(lrT_s);
    GVL_DemoLog.arNe43In_mA[uiIdx] := rIn_mA;
    GVL_DemoLog.arNe43Value_m[uiIdx] := fbAi.rValue_eu;
    GVL_DemoLog.axNe43Valid[uiIdx] := fbAi.xValid;
    GVL_DemoLog.aiNe43Signal[uiIdx] := TO_INT(fbAi.stSts.eSignal);
    GVL_DemoLog.aiNe43Ne107[uiIdx] := TO_INT(fbAi.stSts.stCommon.eNe107);
    GVL_DemoLog.awNe43Sts[uiIdx] := fbAi.stSts.stCommon.wStatus;
    GVL_DemoLog.awNe43AlmActive[uiIdx] := fbAi.stSts.stCommon.wAlmActive;
    GVL_DemoLog.uiNe43N := uiIdx + 1;
    lrNextLog_s := lrNextLog_s + GVL_DemoConst.NE43_LOG_PERIOD_S;
END_IF
xDone := lrT_s >= GVL_DemoConst.NE43_DURATION_S;
