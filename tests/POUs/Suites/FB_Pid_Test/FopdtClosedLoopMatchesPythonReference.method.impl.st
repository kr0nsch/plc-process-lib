coUnit.TEST('Pid_Fopdt_ClosedLoop_MatchesPythonReference');
// источник: tools/reference/pid.py, сценарий fopdt_step
stCfg.rKp := 1.0;
stCfg.rTi_s := 20.0;
stCfg.rTd_s := 1.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
stCmd.rSp_eu := 0.0;
fbPid.rPv_eu := fbPlant.rY;
fbPid.xPvValid := TRUE;
fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);       // t0: Auto, y = 0
stCmd.rSp_eu := 40.0;                                                                  // ступень задания
FOR iStep := 1 TO 1200 DO                                                              // 120 с
    fbTime.Advance(tStep := T#100MS);
    fbPid.rPv_eu := fbPlant.rY;
    fbPid(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    fbPlant.rU_pct := fbPid.rOut_pct;
    fbPlant.Step();
    rPeak := MAX(rPeak, fbPlant.rY);
    IF ABS(fbPlant.rY - 40.0) > 0.8 THEN                                               // вне полосы ±2 %
        rSettle_s := INT_TO_REAL(iStep + 1) * 0.1;
    END_IF
    IF iStep = 100 THEN
        rOut10 := fbPid.rOut_pct;
        rPv10 := fbPlant.rY;
    ELSIF iStep = 300 THEN
        rOut30 := fbPid.rOut_pct;
        rPv30 := fbPlant.rY;
    ELSIF iStep = 600 THEN
        rOut60 := fbPid.rOut_pct;
        rPv60 := fbPlant.rY;
    ELSIF iStep = 1200 THEN
        rOut120 := fbPid.rOut_pct;
        rPv120 := fbPlant.rY;
    END_IF
END_FOR
// ref: fopdt_step.out_10s
AssertEquals_REAL(Expected := 31.212418, Actual := rOut10, Delta := 1.0E-3, Message := 'out at 10 s');
// ref: fopdt_step.pv_10s
AssertEquals_REAL(Expected := 22.549984, Actual := rPv10, Delta := 1.0E-3, Message := 'PV at 10 s');
// ref: fopdt_step.out_30s
AssertEquals_REAL(Expected := 20.687187, Actual := rOut30, Delta := 1.0E-3, Message := 'out at 30 s');
// ref: fopdt_step.pv_30s
AssertEquals_REAL(Expected := 40.311687, Actual := rPv30, Delta := 1.0E-3, Message := 'PV at 30 s');
// ref: fopdt_step.out_60s
AssertEquals_REAL(Expected := 19.997665, Actual := rOut60, Delta := 1.0E-3, Message := 'out at 60 s');
// ref: fopdt_step.pv_60s
AssertEquals_REAL(Expected := 40.32325, Actual := rPv60, Delta := 1.0E-3, Message := 'PV at 60 s');
// ref: fopdt_step.out_120s
AssertEquals_REAL(Expected := 19.999441, Actual := rOut120, Delta := 1.0E-3, Message := 'out at 120 s');
// ref: fopdt_step.pv_120s
AssertEquals_REAL(Expected := 40.012321, Actual := rPv120, Delta := 1.0E-3, Message := 'PV at 120 s');
// ref: fopdt_step.peak
AssertEquals_REAL(Expected := 40.668068, Actual := rPeak, Delta := 1.0E-3, Message := 'peak PV');
// ref: fopdt_step.overshoot_pct
AssertEquals_REAL(Expected := 1.67017, Actual := (rPeak - 40.0) / 40.0 * 100.0, Delta := 1.0E-2,
                  Message := 'overshoot %');
// ref: fopdt_step.settle_s
AssertEquals_REAL(Expected := 24.3, Actual := rSettle_s, Delta := 0.05, Message := 'settling time, 2 % band');
coUnit.TEST_FINISHED();
