coUnit.TEST('Common_InterfaceRefs_DefaultToNull');

AssertTrue(Condition := itfTime = 0 AND itfAlarm = 0 AND itfSource = 0 AND itfDevice = 0,
           Message := 'unassigned interface references are 0');
AssertTrue(Condition := itfMotor = 0 AND itfMotorVfd = 0 AND itfSink = 0,
           Message := 'unassigned device and sink references are 0');
itfMotor := itfMotorVfd;
itfDevice := itfMotor;
itfSource := itfDevice;
AssertTrue(Condition := itfSource = 0, Message := 'upcast of a null reference stays 0');
AssertTrue(Condition := GVL_Lib.itfAlarmSink = 0, Message := 'library sink is 0 unless a test assigns it');

coUnit.TEST_FINISHED();
