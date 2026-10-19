IF NOT xInit THEN
    xInit := TRUE;
    stLevelCfg.rRangeHi_eu := LEVEL_SPAN_M;
    stLevelCfg.astLimit[PL.E_AiAlarm.H].xEnable := TRUE;
    stLevelCfg.astLimit[PL.E_AiAlarm.H].rSetpoint_eu := H_SP_M;
    stLevelCfg.astLimit[PL.E_AiAlarm.H].rHyst_eu := H_HYST_M;
    stLevelCfg.astLimit[PL.E_AiAlarm.H].tOnDelay := H_ON_DELAY;
    stLevelCfg.astAlarm[PL.E_AiAlarm.H].ePriority := PL.E_AlarmPriority.Medium;
    stLevelCfg.astAlarm[PL.E_AiAlarm.H].tShelveMax := SHELVE_MAX;
END_IF
IF xDone THEN
    RETURN;
END_IF

// Уровень по профилю -> ток 4–20 мА
rLevel_m := PROFILE_L_M[PROFILE_LAST];
FOR uiSeg := 1 TO PROFILE_LAST DO
    IF lrT_s < PROFILE_T_S[uiSeg] THEN
        rLevel_m := F_DemoInterp(lrT0_s := PROFILE_T_S[uiSeg - 1], rV0 := PROFILE_L_M[uiSeg - 1],
                                 lrT1_s := PROFILE_T_S[uiSeg], rV1 := PROFILE_L_M[uiSeg], lrT_s := lrT_s);
        EXIT;
    END_IF
END_FOR

// Действия оператора — командами stCmd, как кнопками HMI (импульс снимает сам ФБ)
IF uiAct <= ACT_LAST THEN
    IF lrT_s >= ACT_T_S[uiAct] THEN
        IF ACT_CODE[uiAct] = EV_SHELVE THEN
            stLevelCmd.stCommon.wShelveReq := SLOT_H_MASK;
        ELSE
            stLevelCmd.stCommon.xAck := TRUE;
        END_IF
        F_DemoEvent(lrT_s := lrT_s, iScenario := SCENARIO, iCode := ACT_CODE[uiAct]);
        uiAct := uiAct + 1;
    END_IF
END_IF

fbLevel(rIn := MA_LO + MA_SPAN * rLevel_m / LEVEL_SPAN_M, stCmd := stLevelCmd, stCfg := stLevelCfg);

itfAlmH := fbLevel.GetAlarm(uiIndex := PL.E_AiAlarm.H);
IF itfAlmH <> 0 THEN
    iState := TO_INT(itfAlmH.State);
END_IF

// Журнал с периодом ALM_LOG_PERIOD_S
IF lrT_s >= lrNextLog_s AND GVL_DemoLog.uiAlmN < GVL_DemoConst.ALM_LOG_N THEN
    uiIdx := GVL_DemoLog.uiAlmN;
    GVL_DemoLog.arAlmT_s[uiIdx] := LREAL_TO_REAL(lrT_s);
    GVL_DemoLog.arAlmLevel_m[uiIdx] := fbLevel.rValue_eu;
    GVL_DemoLog.axAlmH[uiIdx] := fbLevel.xH;
    GVL_DemoLog.aiAlmState[uiIdx] := iState;
    GVL_DemoLog.awAlmUnack[uiIdx] := fbLevel.stSts.stCommon.wAlmUnack;
    GVL_DemoLog.awAlmShelved[uiIdx] := fbLevel.stSts.stCommon.wAlmShelved;
    GVL_DemoLog.uiAlmN := uiIdx + 1;
    lrNextLog_s := lrNextLog_s + GVL_DemoConst.ALM_LOG_PERIOD_S;
END_IF
xDone := lrT_s >= GVL_DemoConst.ALM_DURATION_S;
