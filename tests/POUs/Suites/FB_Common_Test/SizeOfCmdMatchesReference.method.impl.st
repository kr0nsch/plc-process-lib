coUnit.TEST('Common_SizeOfCmd_MatchesReference');

AssertEquals_UDINT(Expected := 12, Actual := SIZEOF(stDev), Message := 'ST_DeviceCmd: 12 bytes');
AssertEquals_UDINT(Expected := 16, Actual := SIZEOF(stAi), Message := 'ST_AnalogInputCmd: 16 bytes');
AssertEquals_UDINT(Expected := 14, Actual := SIZEOF(stDi), Message := 'ST_DigitalInputCmd: 14 bytes');
AssertEquals_UDINT(Expected := 20, Actual := SIZEOF(stMot), Message := 'ST_MotorCmd: 20 bytes');
AssertEquals_UDINT(Expected := 16, Actual := SIZEOF(stVlv), Message := 'ST_ValveCmd: 16 bytes');
AssertEquals_UDINT(Expected := 16, Actual := SIZEOF(stCv), Message := 'ST_ControlValveCmd: 16 bytes');
AssertEquals_UDINT(Expected := 20, Actual := SIZEOF(stPid), Message := 'ST_PidCmd: 20 bytes');

coUnit.TEST_FINISHED();
