coUnit.TEST('Common_SizeOfSts_MatchesRegisterMap');

AssertEquals_UDINT(Expected := 28, Actual := SIZEOF(stDev), Message := 'ST_DeviceSts: 28 bytes, 14 registers');
AssertEquals_UDINT(Expected := 44, Actual := SIZEOF(stAi), Message := 'ST_AnalogInputSts: 44 bytes, 22 registers');
AssertEquals_UDINT(Expected := 30, Actual := SIZEOF(stDi), Message := 'ST_DigitalInputSts: 30 bytes, 15 registers');
AssertEquals_UDINT(Expected := 68, Actual := SIZEOF(stMot), Message := 'ST_MotorSts: 68 bytes, 34 registers');
AssertEquals_UDINT(Expected := 52, Actual := SIZEOF(stVlv), Message := 'ST_ValveSts: 52 bytes, 26 registers');
AssertEquals_UDINT(Expected := 52, Actual := SIZEOF(stCv), Message := 'ST_ControlValveSts: 52 bytes, 26 registers');
AssertEquals_UDINT(Expected := 64, Actual := SIZEOF(stPid), Message := 'ST_PidSts: 64 bytes, 32 registers');

coUnit.TEST_FINISHED();
