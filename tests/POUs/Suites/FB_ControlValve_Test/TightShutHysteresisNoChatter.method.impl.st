coUnit.TEST('ControlValve_TightShutHysteresis_NoChatter');

stCfg.rTightShut_pct := 2.0;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 2.02;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 2.02, Actual := fbCv.rOut_pct, Delta := 1.0E-4,
                  Message := 'above threshold: no tight shut');
rPrev := fbCv.rOut_pct;
FOR iStep := 1 TO 10 DO
    fbTime.Advance(tStep := T#100MS);
    IF (iStep MOD 2) = 1 THEN
        fbCv.rPosSpAuto_pct := 1.98;
    ELSE
        fbCv.rPosSpAuto_pct := 2.02;
    END_IF
    fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    IF ABS(fbCv.rOut_pct - rPrev) > 1.0 THEN
        iJumps := iJumps + 1;
    END_IF
    rPrev := fbCv.rOut_pct;
END_FOR
AssertEquals_INT(Expected := 1, Actual := iJumps, Message := 'one jump into tight shut, no chatter');
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'held in tight shut');
fbCv.rPosSpAuto_pct := 2.99;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.rOut_pct, Delta := 0.0, Message := 'still tight shut at 2.99 pct');
fbCv.rPosSpAuto_pct := 3.0;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_REAL(Expected := 3.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4,
                  Message := 'released at threshold + hysteresis');
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wStatus AND GVL_Const.CV_STS_TIGHT_SHUT,
                  Message := 'TIGHT_SHUT bit cleared');

coUnit.TEST_FINISHED();
