coUnit.TEST('Common_AlarmSlots_FitDeviceCounts');

AssertEquals_UINT(Expected := GVL_Const.AI_ALARM_COUNT, Actual := TO_UINT(E_AiAlarm.OutOfRange) + 1,
                  Message := 'AI slots HH..OutOfRange');
AssertEquals_UINT(Expected := GVL_Const.DI_ALARM_COUNT, Actual := TO_UINT(E_DiAlarm.Failure) + 1,
                  Message := 'DI slots State..Failure');
AssertEquals_UINT(Expected := GVL_Const.MOT_ALARM_COUNT, Actual := TO_UINT(E_MotorAlarm.SpeedDeviation) + 1,
                  Message := 'motor slots FailToStart..SpeedDeviation');
AssertEquals_UINT(Expected := GVL_Const.VLV_ALARM_COUNT, Actual := TO_UINT(E_ValveAlarm.InterlockAct) + 1,
                  Message := 'valve slots FailToOpen..InterlockAct');
AssertEquals_UINT(Expected := GVL_Const.CV_ALARM_COUNT, Actual := TO_UINT(E_CvAlarm.InterlockAct) + 1,
                  Message := 'CV slots Deviation..InterlockAct');
AssertEquals_UINT(Expected := GVL_Const.PID_ALARM_COUNT, Actual := TO_UINT(E_PidAlarm.PvInvalid) + 1,
                  Message := 'PID slots PvInvalid');
AssertTrue(Condition := GVL_Const.MOT_ALARM_COUNT <= GVL_Const.DEV_ALARMS_MAX
                        AND GVL_Const.VLV_ALARM_COUNT <= GVL_Const.DEV_ALARMS_MAX
                        AND GVL_Const.AI_ALARM_COUNT <= GVL_Const.DEV_ALARMS_MAX,
           Message := 'slot counts fit the 8 base slots');

coUnit.TEST_FINISHED();
