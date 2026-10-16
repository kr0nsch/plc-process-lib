coUnit.TEST('Common_SizeOfDeviceRetain_Is36');

AssertEquals_UDINT(Expected := 36, Actual := SIZEOF(stRetain), Message := 'ST_DeviceRetain must be 36 bytes');

coUnit.TEST_FINISHED();
