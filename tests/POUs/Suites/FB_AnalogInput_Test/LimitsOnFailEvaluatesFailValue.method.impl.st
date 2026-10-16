coUnit.TEST('AnalogInput_LimitsOnFail_EvaluatesFailValue');

stCfg.eFailValue := E_AiFailValue.Substitute;
stCfg.rFailValue_eu := 95.0;
stCfg.xLimitsOnFail := TRUE;
stCfg.tFailDelay := T#1S;
SetLimit(stCfgAi := stCfg, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 90.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 12.0, stCmd := stCmd, stCfg := stCfg);   // t0: 50
AssertFalse(Condition := fbAi.xHH, Message := 'no HH at 50');
FOR iStep := 1 TO 11 DO   // обрыв с t0 + 0,1 с, t0 + 1,1 с
    fbTime.Advance(tStep := T#100MS);
    fbAi(itfTime := fbTime, rIn := 0.0, stCmd := stCmd, stCfg := stCfg);
END_FOR
AssertTrue(Condition := fbAi.Fault, Message := 'failure confirmed');
AssertEquals_REAL(Expected := 95.0, Actual := fbAi.rValue_eu, Delta := 0.0, Message := 'fail value');
AssertTrue(Condition := fbAi.xHH, Message := 'HH evaluated on fail value');
itfAlm := fbAi.GetAlarm(uiIndex := E_AiAlarm.HH);
AssertTrue(Condition := itfAlm.State = E_AlarmState.ActiveUnack, Message := 'HH alarm not suppressed');

coUnit.TEST_FINISHED();
