coUnit.TEST('ControlValve_FbNaN_EventAndStsFinite');

GVL_Lib.itfAlarmSink := fbSink;
stCfg.xFbUsed := TRUE;
stRetain.eRemoteMode := E_DeviceMode.Auto;
fbCv.rPosSpAuto_pct := 30.0;
fbCv.rPosFb_pct := 30.0;
fbCv.xPosFbValid := TRUE;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
uBits.dwValue := 16#7FC00000;
fbCv.rPosFb_pct := uBits.rValue;
fbTime.Advance(tStep := T#100MS);
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stEv := fbSink.Last;
GVL_Lib.itfAlarmSink := 0;
AssertEquals_UDINT(Expected := 1, Actual := stEv.udiId, Message := 'FbFailure event (slot 1)');
// AssertEquals_REAL пропускает NaN (ABS(NaN) > Delta = FALSE): конечность проверяется отдельно
AssertTrue(Condition := F_IsFinite(rIn := stEv.rValue), Message := 'event value finite');
AssertTrue(Condition := F_IsFinite(rIn := fbCv.stSts.rPosFb_pct) AND F_IsFinite(rIn := fbCv.stSts.rDeviation_pct)
                        AND F_IsFinite(rIn := fbCv.rOut_pct),
           Message := 'Sts and output finite');
AssertEquals_REAL(Expected := 0.0, Actual := fbCv.stSts.rPosFb_pct, Delta := 0.0,
                  Message := 'unknown feedback shown as 0');
AssertEquals_REAL(Expected := 30.0, Actual := fbCv.rOut_pct, Delta := 1.0E-4, Message := 'output kept');

coUnit.TEST_FINISHED();
