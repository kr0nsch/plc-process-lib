coUnit.TEST('Device_AlarmSlotArrays_MatchDevAlarmsMax');

AssertEquals_UDINT(Expected := TO_UDINT(SIZEOF(fbAlm)) * GVL_Const.DEV_ALARMS_MAX,
                   Actual := TO_UDINT(SIZEOF(fbDev.afbAlarm)), Message := 'afbAlarm has DEV_ALARMS_MAX slots');
AssertEquals_UDINT(Expected := GVL_Const.DEV_ALARMS_MAX, Actual := TO_UDINT(SIZEOF(fbDev.axAlmCond)),
                   Message := 'axAlmCond has DEV_ALARMS_MAX elements');
AssertEquals_UDINT(Expected := GVL_Const.DEV_ALARMS_MAX, Actual := TO_UDINT(SIZEOF(fbDev.axAlmSuppress)),
                   Message := 'axAlmSuppress has DEV_ALARMS_MAX elements');
AssertEquals_UDINT(Expected := 4 * GVL_Const.DEV_ALARMS_MAX, Actual := TO_UDINT(SIZEOF(fbDev.arAlmValue)),
                   Message := 'arAlmValue has DEV_ALARMS_MAX REAL elements');

coUnit.TEST_FINISHED();
