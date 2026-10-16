coUnit.TEST('Common_CfgDefaults_MatchContract');

// ST_AlarmCfg
AssertTrue(Condition := stAlm.ePriority = E_AlarmPriority.Medium, Message := 'alarm priority defaults to Medium');
AssertEquals_TIME(Expected := T#8H, Actual := stAlm.tShelveMax, Message := 'alarm tShelveMax defaults to 8 h');
// ST_AnalogInputCfg
AssertTrue(Condition := stAi.eInput = E_AiInputType.MilliAmp, Message := 'AI input defaults to MilliAmp');
AssertEquals_REAL(Expected := 100.0, Actual := stAi.rRangeHi_eu, Delta := 0.0, Message := 'AI range high 100');
AssertEquals_TIME(Expected := T#2S, Actual := stAi.tFailDelay, Message := 'AI tFailDelay 2 s');
AssertEquals_TIME(Expected := T#8H, Actual := stAi.tSubstMax, Message := 'AI tSubstMax 8 h');
AssertTrue(Condition := stAi.eFailValue = E_AiFailValue.HoldLast, Message := 'AI fail value HoldLast');
stLim := stAi.astLimit[E_AiAlarm.LL];
AssertFalse(Condition := stLim.xEnable, Message := 'AI limits disabled by default');
stSlot := stAi.astAlarm[E_AiAlarm.HH];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.High, Message := 'AI HH High');
stSlot := stAi.astAlarm[E_AiAlarm.H];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Low, Message := 'AI H Low');
stSlot := stAi.astAlarm[E_AiAlarm.L];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Low, Message := 'AI L Low');
stSlot := stAi.astAlarm[E_AiAlarm.LL];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.High, Message := 'AI LL High');
stSlot := stAi.astAlarm[E_AiAlarm.Failure];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'AI Failure Medium');
stSlot := stAi.astAlarm[E_AiAlarm.OutOfRange];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Low,
           Message := 'AI OutOfRange Low');
stSlot := stAi.astAlarm[7];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.None, Message := 'AI unused slot 7 None');
stSlot := stAi.astAlarm[E_AiAlarm.HH];
AssertEquals_TIME(Expected := T#8H, Actual := stSlot.tShelveMax,
                  Message := 'element initializer keeps the ST_AlarmCfg defaults');
// ST_DigitalInputCfg
AssertTrue(Condition := stDi.xAlarmOnTrue, Message := 'DI alarm on TRUE by default');
AssertTrue(Condition := stDi.eFailValue = E_DiFailValue.HoldLast, Message := 'DI fail value HoldLast');
AssertEquals_TIME(Expected := T#8H, Actual := stDi.tSubstMax, Message := 'DI tSubstMax 8 h');
stSlot := stDi.astAlarm[E_DiAlarm.State];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.None, Message := 'DI State None');
stSlot := stDi.astAlarm[E_DiAlarm.Failure];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'DI Failure Medium');
// ST_MotorCfg, ST_VfdCfg
AssertTrue(Condition := stMot.xFbUsed, Message := 'motor feedback used by default');
AssertEquals_TIME(Expected := T#5S, Actual := stMot.tFbStart, Message := 'motor tFbStart 5 s');
AssertEquals_TIME(Expected := T#5S, Actual := stMot.tFbStop, Message := 'motor tFbStop 5 s');
AssertEquals_TIME(Expected := T#500MS, Actual := stMot.tFbLossFilter, Message := 'motor tFbLossFilter 500 ms');
AssertEquals_TIME(Expected := T#200MS, Actual := stMot.tExtFaultFilter, Message := 'motor tExtFaultFilter 200 ms');
AssertEquals_TIME(Expected := T#3S, Actual := stMot.tResetWindow, Message := 'motor tResetWindow 3 s');
AssertEquals_TIME(Expected := T#1S, Actual := stMot.tResetPulse, Message := 'motor tResetPulse 1 s');
AssertEquals_WORD(Expected := 16#FFFF, Actual := stMot.wInterlockMask, Message := 'motor interlock mask all bits');
AssertEquals_WORD(Expected := 16#FFFF, Actual := stMot.wPermitMask, Message := 'motor permit mask all bits');
stSlot := stMot.astAlarm[E_MotorAlarm.FailToStart];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'motor FailToStart Medium');
stSlot := stMot.astAlarm[E_MotorAlarm.FailToStop];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.High,
           Message := 'motor FailToStop High');
stSlot := stMot.astAlarm[E_MotorAlarm.UncommandedRun];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.High,
           Message := 'motor UncommandedRun High');
stSlot := stMot.astAlarm[E_MotorAlarm.InterlockTrip];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.None,
           Message := 'motor InterlockTrip None');
stSlot := stMot.astAlarm[E_MotorAlarm.CommLoss];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'motor CommLoss Medium');
stSlot := stMot.astAlarm[E_MotorAlarm.SpeedDeviation];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Low,
           Message := 'motor SpeedDeviation Low');
AssertEquals_REAL(Expected := 100.0, Actual := stMot.stVfd.rSpeedMax_pct, Delta := 0.0,
                  Message := 'VFD max speed 100 %');
AssertTrue(Condition := stMot.stVfd.xFbFromComm AND stMot.stVfd.xCommLossIsFault,
           Message := 'VFD feedback from comm, comm loss is fault');
AssertEquals_TIME(Expected := T#3S, Actual := stMot.stVfd.tCommLoss, Message := 'VFD tCommLoss 3 s');
AssertEquals_REAL(Expected := 10.0, Actual := stMot.stVfd.rSpeedDev_pct, Delta := 0.0, Message := 'VFD speed dev 10 %');
AssertEquals_TIME(Expected := T#10S, Actual := stMot.stVfd.tSpeedDev, Message := 'VFD tSpeedDev 10 s');
// ST_ValveCfg
AssertTrue(Condition := stVlv.eType = E_ValveType.Motorized, Message := 'valve type Motorized');
AssertTrue(Condition := stVlv.xZsoUsed AND stVlv.xZscUsed, Message := 'valve limit switches used');
AssertEquals_TIME(Expected := T#60S, Actual := stVlv.tTravel, Message := 'valve tTravel 60 s');
AssertEquals_TIME(Expected := T#500MS, Actual := stVlv.tLimitFilter, Message := 'valve tLimitFilter 500 ms');
AssertEquals_TIME(Expected := T#1S, Actual := stVlv.tReverse, Message := 'valve tReverse 1 s');
AssertEquals_TIME(Expected := T#3S, Actual := stVlv.tResetWindow, Message := 'valve tResetWindow 3 s');
AssertTrue(Condition := stVlv.eSafePos = E_ValveSafePos.Closed, Message := 'valve safe position Closed');
AssertEquals_WORD(Expected := 16#FFFF, Actual := stVlv.wInterlockMask, Message := 'valve interlock mask');
AssertEquals_WORD(Expected := 16#FFFF, Actual := stVlv.wPermitOpenMask, Message := 'valve permit open mask');
AssertEquals_WORD(Expected := 16#FFFF, Actual := stVlv.wPermitCloseMask, Message := 'valve permit close mask');
stSlot := stVlv.astAlarm[E_ValveAlarm.ExtFault];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'valve ExtFault Medium');
stSlot := stVlv.astAlarm[E_ValveAlarm.InterlockAct];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.None,
           Message := 'valve InterlockAct None');
// ST_ControlValveCfg
AssertEquals_REAL(Expected := 100.0, Actual := stCv.rOutMax_pct, Delta := 0.0, Message := 'CV out max 100 %');
AssertEquals_REAL(Expected := 5.0, Actual := stCv.rDevMax_pct, Delta := 0.0, Message := 'CV deviation 5 %');
AssertEquals_TIME(Expected := T#30S, Actual := stCv.tDev, Message := 'CV tDev 30 s');
AssertTrue(Condition := stCv.eFaultAction = E_CvFaultAction.Hold, Message := 'CV fault action Hold');
AssertEquals_WORD(Expected := 16#FFFF, Actual := stCv.wInterlockMask, Message := 'CV interlock mask');
stSlot := stCv.astAlarm[E_CvAlarm.Deviation];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Low, Message := 'CV Deviation Low');
stSlot := stCv.astAlarm[E_CvAlarm.PositionerFault];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'CV PositionerFault Medium');
stSlot := stCv.astAlarm[E_CvAlarm.InterlockAct];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.None,
           Message := 'CV InterlockAct None');
// ST_PidCfg
AssertTrue(Condition := stPid.eAction = E_PidAction.Reverse, Message := 'PID action Reverse');
AssertEquals_REAL(Expected := 1.0, Actual := stPid.rKp, Delta := 0.0, Message := 'PID Kp 1');
AssertEquals_REAL(Expected := 30.0, Actual := stPid.rTi_s, Delta := 0.0, Message := 'PID Ti 30 s');
AssertEquals_REAL(Expected := 10.0, Actual := stPid.rDFilterN, Delta := 0.0, Message := 'PID D filter N 10');
AssertEquals_REAL(Expected := 100.0, Actual := stPid.rPvMax_eu, Delta := 0.0, Message := 'PID PV max 100');
AssertEquals_REAL(Expected := 100.0, Actual := stPid.rOutMax_pct, Delta := 0.0, Message := 'PID out max 100 %');
AssertEquals_TIME(Expected := T#2S, Actual := stPid.tDtMax, Message := 'PID tDtMax 2 s');
AssertTrue(Condition := stPid.ePvFailAction = E_PidPvFailAction.Hold, Message := 'PID PV fail action Hold');
stSlot := stPid.astAlarm[E_PidAlarm.PvInvalid];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.Medium,
           Message := 'PID PvInvalid Medium');
stSlot := stPid.astAlarm[1];
AssertTrue(Condition := stSlot.ePriority = E_AlarmPriority.None, Message := 'PID unused slot 1 None');

coUnit.TEST_FINISHED();
