coUnit.TEST('Valve_ActTime_AccumulatesInRetain');

stCfg.tTravel := T#120S;
stRetain.udiOpTime_s := 7190;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.xOpen := TRUE;
// t0: выход включён
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbVlv.xZsc := FALSE;
FOR iStep := 1 TO 125 DO                                                // 12,5 с
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
stCmd.xStop := TRUE;
// без шага времени
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий valve_act_time: 12 с, в накопителе 0,5 с
AssertEquals_UDINT(Expected := 7202, Actual := stRetain.udiOpTime_s, Message := 'total run time 7190 + 12 s');
AssertEquals_UDINT(Expected := 12, Actual := stRetain.udiOpTimeMaint_s, Message := 'run time since maintenance 12 s');
// источник: tools/reference/valve_reference.py, сценарий valve_act_time: hours of 7190 + 12 s
AssertEquals_REAL(Expected := 2.0005555, Actual := fbVlv.stSts.rActTime_h, Delta := 1.0E-6,
                  Message := 'run time in hours');
FOR iStep := 1 TO 20 DO
    fbTime.Advance(tStep := T#100MS);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
END_FOR
AssertEquals_UDINT(Expected := 7202, Actual := stRetain.udiOpTime_s, Message := 'no accumulation at rest');
stCmd.xOpen := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
fbTime.Advance(tStep := T#1M);
// один шаг 60 с
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
// источник: tools/reference/valve_reference.py, сценарий valve_act_time: one 60 s step = 10 s (0,5 + 10 с)
AssertEquals_UDINT(Expected := 7212, Actual := stRetain.udiOpTime_s, Message := 'large step bounded by DT_ACCUM_MAX');

coUnit.TEST_FINISHED();
