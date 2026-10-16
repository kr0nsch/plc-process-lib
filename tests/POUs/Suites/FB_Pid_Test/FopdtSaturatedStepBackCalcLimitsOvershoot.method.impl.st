coUnit.TEST('Pid_Fopdt_SaturatedStep_BackCalcLimitsOvershoot');
// источник: tools/reference/pid.py, сценарий fopdt_sat
stCfgAw.rKp := 1.0;
stCfgAw.rTi_s := 20.0;
stCfgAw.rTd_s := 1.0;
stCfgAw.rOutMax_pct := 30.0;
stCfgNoAw := stCfgAw;
stCfgNoAw.rTt_s := 1.0E6;
stRetAw.eRemoteMode := E_DeviceMode.Auto;
stRetNoAw.eRemoteMode := E_DeviceMode.Auto;
fbPidAw.rPv_eu := fbPlantAw.rY;
fbPidAw.xPvValid := TRUE;
fbPidNoAw.rPv_eu := fbPlantNo.rY;
fbPidNoAw.xPvValid := TRUE;
fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);          // t0: Auto
fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
stCmdAw.rSp_eu := 40.0;                                                                         // ступень
stCmdNoAw.rSp_eu := 40.0;
FOR iStep := 1 TO 600 DO                                                                        // 60 с
    fbTime.Advance(tStep := T#100MS);
    fbPidAw.rPv_eu := fbPlantAw.rY;
    fbPidNoAw.rPv_eu := fbPlantNo.rY;
    fbPidAw(itfTime := fbTime, stCmd := stCmdAw, stRetain := stRetAw, stCfg := stCfgAw);
    fbPidNoAw(itfTime := fbTime, stCmd := stCmdNoAw, stRetain := stRetNoAw, stCfg := stCfgNoAw);
    fbPlantAw.rU_pct := fbPidAw.rOut_pct;
    fbPlantAw.Step();
    fbPlantNo.rU_pct := fbPidNoAw.rOut_pct;
    fbPlantNo.Step();
    rPeakAw := MAX(rPeakAw, fbPlantAw.rY);
    rPeakNoAw := MAX(rPeakNoAw, fbPlantNo.rY);
    IF fbPidAw.xSatHigh THEN
        xSatAw := TRUE;
    ELSIF xSatAw AND rUnsatAw = 0.0 THEN
        rUnsatAw := INT_TO_REAL(iStep) * 0.1;
    END_IF
    IF fbPidNoAw.xSatHigh THEN
        xSatNoAw := TRUE;
    ELSIF xSatNoAw AND rUnsatNoAw = 0.0 THEN
        rUnsatNoAw := INT_TO_REAL(iStep) * 0.1;
    END_IF
END_FOR
// ref: fopdt_sat.peak_aw
AssertEquals_REAL(Expected := 39.466667, Actual := rPeakAw, Delta := 1.0E-3, Message := 'back-calculation: peak');
// ref: fopdt_sat.peak_noaw
AssertEquals_REAL(Expected := 43.642101, Actual := rPeakNoAw, Delta := 1.0E-3, Message := 'windup: peak');
// ref: fopdt_sat.pv_60s_noaw
AssertEquals_REAL(Expected := 41.619171, Actual := fbPlantNo.rY, Delta := 1.0E-3, Message := 'windup: PV at 60 s');
// ref: fopdt_sat.unsat_aw
AssertEquals_REAL(Expected := 8.4, Actual := rUnsatAw, Delta := 0.05, Message := 'back-calculation: leaves limit');
// ref: fopdt_sat.unsat_noaw
AssertEquals_REAL(Expected := 20.8, Actual := rUnsatNoAw, Delta := 0.05, Message := 'windup: leaves limit later');
AssertTrue(Condition := rPeakAw <= 40.0, Message := 'no overshoot with back-calculation');
AssertTrue(Condition := rPeakNoAw > 42.0, Message := 'overshoot without back-calculation');
coUnit.TEST_FINISHED();
