// Интерфейсные ссылки до присваивания — 0 (так их проверяют ФБ: itfTime <> 0); цепочка EXTENDS
// I_MotorVfd → I_Motor → I_Device → I_AlarmSource допускает приведение вверх.
METHOD PRIVATE InterfaceRefsDefaultToNull
VAR
    itfTime     : I_TimeSource;
    itfAlarm    : I_Alarm;
    itfSource   : I_AlarmSource;
    itfDevice   : I_Device;
    itfMotor    : I_Motor;
    itfMotorVfd : I_MotorVfd;
    itfSink     : I_AlarmSink;
END_VAR
