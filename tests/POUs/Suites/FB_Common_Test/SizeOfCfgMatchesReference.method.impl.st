coUnit.TEST('Common_SizeOfCfg_MatchesReference');

AssertEquals_UDINT(Expected := 264, Actual := SIZEOF(stAi), Message := 'ST_AnalogInputCfg: 264 bytes');
AssertEquals_UDINT(Expected := 152, Actual := SIZEOF(stDi), Message := 'ST_DigitalInputCfg: 152 bytes');
AssertEquals_UDINT(Expected := 216, Actual := SIZEOF(stMot), Message := 'ST_MotorCfg: 216 bytes');
AssertEquals_UDINT(Expected := 32, Actual := SIZEOF(stVfd), Message := 'ST_VfdCfg: 32 bytes');
AssertEquals_UDINT(Expected := 168, Actual := SIZEOF(stVlv), Message := 'ST_ValveCfg: 168 bytes');
AssertEquals_UDINT(Expected := 176, Actual := SIZEOF(stCv), Message := 'ST_ControlValveCfg: 176 bytes');
AssertEquals_UDINT(Expected := 212, Actual := SIZEOF(stPid), Message := 'ST_PidCfg: 212 bytes');

coUnit.TEST_FINISHED();
