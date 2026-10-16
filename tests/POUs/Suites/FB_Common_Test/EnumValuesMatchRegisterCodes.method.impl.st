coUnit.TEST('Common_EnumValues_MatchRegisterCodes');

AssertEquals_INT(Expected := 1, Actual := TO_INT(E_DeviceMode.Auto), Message := 'E_DeviceMode.Auto = 1');
AssertEquals_INT(Expected := 4, Actual := TO_INT(E_DeviceMode.OutOfService),
                 Message := 'E_DeviceMode.OutOfService = 4');
AssertEquals_INT(Expected := 7, Actual := TO_INT(E_DeviceType.Pid), Message := 'E_DeviceType.Pid = 7');
AssertEquals_INT(Expected := 4, Actual := TO_INT(E_Ne107Status.Failure), Message := 'E_Ne107Status.Failure = 4');
AssertEquals_INT(Expected := 10, Actual := TO_INT(E_CmdResult.SubstExpired),
                 Message := 'E_CmdResult.SubstExpired = 10');
AssertEquals_INT(Expected := 6, Actual := TO_INT(E_AlarmState.OutOfService),
                 Message := 'E_AlarmState.OutOfService = 6');
AssertEquals_INT(Expected := 4, Actual := TO_INT(E_AlarmPriority.Critical), Message := 'E_AlarmPriority.Critical = 4');
AssertEquals_INT(Expected := 10, Actual := TO_INT(E_AlarmEventReason.OosOff),
                 Message := 'E_AlarmEventReason.OosOff = 10');
AssertEquals_INT(Expected := 6, Actual := TO_INT(E_AiSignalState.NotFinite),
                 Message := 'E_AiSignalState.NotFinite = 6');
AssertEquals_INT(Expected := 4, Actual := TO_INT(E_AiInputType.Raw), Message := 'E_AiInputType.Raw = 4');
AssertEquals_INT(Expected := 4, Actual := TO_INT(E_MotorState.Fault), Message := 'E_MotorState.Fault = 4');
AssertEquals_INT(Expected := 7, Actual := TO_INT(E_ValveState.Fault), Message := 'E_ValveState.Fault = 7');
AssertEquals_INT(Expected := 2, Actual := TO_INT(E_ValveType.Motorized), Message := 'E_ValveType.Motorized = 2');
AssertEquals_INT(Expected := 2, Actual := TO_INT(E_PidPvFailAction.ShedToManual),
                 Message := 'E_PidPvFailAction.ShedToManual = 2');

coUnit.TEST_FINISHED();
