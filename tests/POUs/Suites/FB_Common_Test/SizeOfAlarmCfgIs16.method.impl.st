coUnit.TEST('Common_SizeOfAlarmCfg_Is16');

AssertEquals_UDINT(Expected := 16, Actual := SIZEOF(stAlm), Message := 'ST_AlarmCfg must be 16 bytes');
AssertEquals_UDINT(Expected := 20, Actual := SIZEOF(stLim), Message := 'ST_AiLimitCfg must be 20 bytes');

coUnit.TEST_FINISHED();
