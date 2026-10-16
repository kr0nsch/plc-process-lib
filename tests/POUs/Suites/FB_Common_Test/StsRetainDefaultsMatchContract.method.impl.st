coUnit.TEST('Common_StsRetainDefaults_MatchContract');

AssertTrue(Condition := stDev.eMode = E_DeviceMode.Manual, Message := 'Sts mode defaults to Manual');
AssertTrue(Condition := stDev.eNe107 = E_Ne107Status.CheckFunction, Message := 'Sts NE 107 defaults to CheckFunction');
AssertTrue(Condition := stDev.eCmdResult = E_CmdResult.None, Message := 'Sts command result None');
AssertTrue(Condition := stDev.ePrioUnack = E_AlarmPriority.None, Message := 'Sts unacked priority None');
AssertTrue(Condition := stDev.eDevType = E_DeviceType.None, Message := 'Sts device type None before the first call');
AssertTrue(Condition := stMot.stCommon.eNe107 = E_Ne107Status.CheckFunction,
           Message := 'nested common header keeps its defaults');
AssertTrue(Condition := stMot.eState = E_MotorState.Stopped, Message := 'motor state Stopped');
AssertTrue(Condition := stRetain.eRemoteMode = E_DeviceMode.Manual, Message := 'Retain remote mode Manual');
AssertFalse(Condition := stRetain.xOutOfService, Message := 'Retain not out of service');

coUnit.TEST_FINISHED();
