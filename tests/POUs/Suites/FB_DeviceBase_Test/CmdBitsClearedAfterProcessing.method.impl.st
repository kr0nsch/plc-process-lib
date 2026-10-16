coUnit.TEST('Device_CmdBits_ClearedAfterProcessing');

fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
stCmd.stCommon.xSetAuto := TRUE;
stCmd.stCommon.xSetManual := TRUE;
stCmd.stCommon.xSetOos := TRUE;
stCmd.stCommon.xReset := TRUE;
stCmd.stCommon.xAck := TRUE;
stCmd.stCommon.wAckReq := 16#FFFF;
stCmd.stCommon.wShelveReq := 16#FFFF;
stCmd.stCommon.wUnshelveReq := 16#FFFF;
stCmd.xStart := TRUE;
stCmd.xStop := TRUE;
fbDev(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertFalse(Condition := stCmd.stCommon.xSetAuto OR stCmd.stCommon.xSetManual OR stCmd.stCommon.xSetOos,
            Message := 'mode pulses cleared');
AssertFalse(Condition := stCmd.stCommon.xReset OR stCmd.stCommon.xAck, Message := 'reset and ack pulses cleared');
AssertFalse(Condition := stCmd.xStart OR stCmd.xStop, Message := 'device pulses cleared');
AssertEquals_WORD(Expected := 0, Actual := stCmd.stCommon.wAckReq, Message := 'ack mask cleared');
AssertEquals_WORD(Expected := 0, Actual := stCmd.stCommon.wShelveReq, Message := 'shelve mask cleared');
AssertEquals_WORD(Expected := 0, Actual := stCmd.stCommon.wUnshelveReq, Message := 'unshelve mask cleared');

coUnit.TEST_FINISHED();
