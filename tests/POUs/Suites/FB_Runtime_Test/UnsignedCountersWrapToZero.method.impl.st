coUnit.TEST('Runtime_UnsignedCounters_WrapToZero');

uiCnt := uiCnt + 1;
udiCnt := udiCnt + 1;
AssertEquals_UINT(Expected := 0, Actual := uiCnt, Message := 'UINT 65535 + 1 = 0');
AssertEquals_UDINT(Expected := 0, Actual := udiCnt, Message := 'UDINT 4294967295 + 1 = 0');

coUnit.TEST_FINISHED();
