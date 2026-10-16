coUnit.TEST('Alarm_PriorityNone_NeverActivates');

stCfg.ePriority := E_AlarmPriority.None;
GVL_Lib.itfAlarmSink := fbSink;
FOR iStep := 1 TO 10 DO
    fbAlm(xIn := TRUE, stCfg := stCfg, itfTime := fbTime);
    xEver := xEver OR fbAlm.xActive OR fbAlm.xUnacked OR fbAlm.xInList OR fbAlm.xShelved
             OR fbAlm.eState <> E_AlarmState.Normal;
    fbTime.Advance(tStep := T#1S);
END_FOR
GVL_Lib.itfAlarmSink := 0;
xRet := fbAlm.Shelve(tDuration := T#0S) OR fbAlm.Ack();
AssertFalse(Condition := xEver, Message := 'disabled alarm: Normal, all outputs FALSE');
AssertEquals_UDINT(Expected := 0, Actual := fbAlm.udiSeq, Message := 'udiSeq unchanged');
AssertEquals_UINT(Expected := 0, Actual := fbSink.Count, Message := 'no events');
AssertFalse(Condition := xRet, Message := 'Shelve and Ack return FALSE');

coUnit.TEST_FINISHED();
