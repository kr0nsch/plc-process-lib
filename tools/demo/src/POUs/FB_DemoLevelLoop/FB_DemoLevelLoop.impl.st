IF NOT xInit THEN
    xInit := TRUE;
    stLtCfg.rRangeHi_eu := LEVEL_SPAN_M;
    stLicCfg.eAction := PL.E_PidAction.Direct;          // уровень выше задания -> насос быстрее
    stLicCfg.rKp := PID_KP;
    stLicCfg.rTi_s := PID_TI_S;
    stLicCfg.rPvMax_eu := LEVEL_SPAN_M;
    stLicCfg.rSpMax_eu := LEVEL_SPAN_M;
    stLicCfg.xUseOutAct := TRUE;                        // обратный расчёт по фактическому заданию ПЧ
    stLicRet.eRemoteMode := PL.E_DeviceMode.Auto;
    stLicCmd.rSp_eu := SP0_M;
    stPumpCfg.stVfd.rSpeedMin_pct := SPEED_MIN_PCT;
    stPumpRet.eRemoteMode := PL.E_DeviceMode.Auto;
    lrLevel_m := LEVEL0_M;
END_IF
IF xDone THEN
    RETURN;
END_IF

// Сценарий: пуск насоса, ступень задания, ступень притока
IF lrT_s >= T_START_S AND NOT xStartDone THEN
    xStartDone := TRUE;
    fbPump.xAutoRun := TRUE;
    F_DemoEvent(lrT_s := lrT_s, iScenario := SCENARIO, iCode := EV_START);
END_IF
IF lrT_s >= T_SP_STEP_S AND NOT xSpDone THEN
    xSpDone := TRUE;
    stLicCmd.rSp_eu := SP1_M;
    F_DemoEvent(lrT_s := lrT_s, iScenario := SCENARIO, iCode := EV_SP_STEP);
END_IF
IF lrT_s >= T_SURGE_S AND NOT xSurgeDone THEN
    xSurgeDone := TRUE;
    F_DemoEvent(lrT_s := lrT_s, iScenario := SCENARIO, iCode := EV_SURGE);
END_IF
rQin_m3h := SEL(xSurgeDone, Q_IN_BASE_M3H, Q_IN_SURGE_M3H);

// Датчик уровня: уровень модели -> ток 4–20 мА
rLevel_mA := MA_LO + MA_SPAN * LREAL_TO_REAL(lrLevel_m) / LEVEL_SPAN_M;

// Контур по примеру 17.3 контракта: насос (прошлый вызов) -> AI -> ПИД -> задание ПЧ -> ПЧ.
// Пока насос не в Auto-работе, ПИД следит за заданием ПЧ: пуск и переходы режимов без рывка
xLeadAuto := fbPump.SpeedAutoActive;
rLeadRef_pct := fbPump.SpeedRef;
fbLt(rIn := rLevel_mA, stCmd := stLtCmd, stCfg := stLtCfg);
fbLic(rPv_eu := fbLt.rValue_eu, xPvValid := fbLt.xValid, xTrack := NOT xLeadAuto, rTrack_pct := rLeadRef_pct,
      rOutAct_pct := rLeadRef_pct, stCmd := stLicCmd, stRetain := stLicRet, stCfg := stLicCfg);
fbPump.rSpeedSpAuto_pct := fbLic.rOut_pct;
fbPump(stCmd := stPumpCmd, stRetain := stPumpRet, stCfg := stPumpCfg);

// Модель ПЧ: работает по команде, скорость идёт к заданию с рампой привода
rSpeedAct_pct := PL.F_RateLimit(rCurrent := rSpeedAct_pct,
                                rTarget := SEL(fbPump.xQRun, 0.0, fbPump.rSpeedRef_pct),
                                rRateUp_ups := VFD_RAMP_PCTPS, rRateDown_ups := VFD_RAMP_PCTPS,
                                lrDt_s := lrDt_s);
fbPump.xVfdRunning := fbPump.xQRun;
fbPump.rSpeedAct_pct := rSpeedAct_pct;

// Модель ёмкости: баланс объёма
rQout_m3h := Q_PUMP_MAX_M3H * rSpeedAct_pct / PCT_FULL;
lrLevel_m := lrLevel_m + REAL_TO_LREAL(rQin_m3h - rQout_m3h) / S_PER_H / AREA_M2 * lrDt_s;
lrLevel_m := LIMIT(0.0, lrLevel_m, REAL_TO_LREAL(LEVEL_SPAN_M));

// Журнал с периодом LOOP_LOG_PERIOD_S
IF lrT_s >= lrNextLog_s AND GVL_DemoLog.uiLoopN < GVL_DemoConst.LOOP_LOG_N THEN
    uiIdx := GVL_DemoLog.uiLoopN;
    GVL_DemoLog.arLoopT_s[uiIdx] := LREAL_TO_REAL(lrT_s);
    GVL_DemoLog.arLoopLevel_m[uiIdx] := LREAL_TO_REAL(lrLevel_m);
    GVL_DemoLog.arLoopPv_m[uiIdx] := fbLt.rValue_eu;
    GVL_DemoLog.arLoopSp_m[uiIdx] := fbLic.stSts.rSp_eu;
    GVL_DemoLog.arLoopOut_pct[uiIdx] := fbLic.rOut_pct;
    GVL_DemoLog.arLoopP_pct[uiIdx] := fbLic.stSts.rP_pct;
    GVL_DemoLog.arLoopI_pct[uiIdx] := fbLic.stSts.rI_pct;
    GVL_DemoLog.arLoopRef_pct[uiIdx] := fbPump.rSpeedRef_pct;
    GVL_DemoLog.arLoopAct_pct[uiIdx] := rSpeedAct_pct;
    GVL_DemoLog.arLoopQin_m3h[uiIdx] := rQin_m3h;
    GVL_DemoLog.arLoopQout_m3h[uiIdx] := rQout_m3h;
    GVL_DemoLog.aiLoopMotor[uiIdx] := TO_INT(fbPump.stSts.eState);
    GVL_DemoLog.awLoopPidSts[uiIdx] := fbLic.stSts.stCommon.wStatus;
    GVL_DemoLog.uiLoopN := uiIdx + 1;
    lrNextLog_s := lrNextLog_s + GVL_DemoConst.LOOP_LOG_PERIOD_S;
END_IF
xDone := lrT_s >= GVL_DemoConst.LOOP_DURATION_S;
