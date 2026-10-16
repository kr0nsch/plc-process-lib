// 0. Источник времени до BeginCycle: вложенный FB_Delay ниже вызывается раньше BeginCycle (как
//    fbVfdCommLoss у FB_MotorVfd, контракт 14.2); первый вызов — сразу с подменным временем
ResolveTime();
uiBodyCalls := uiBodyCalls + 1;
IF xFirstCall THEN
    uiAlarmCount := MIN(uiAlarmSlots, GVL_Const.DEV_ALARMS_MAX);
    eDevType := eTypeSel;
    xManualIsCheck := xInputLike;
    IF xInputLike THEN
        stModeMem.eRemoteMode := E_DeviceMode.Auto;
    ELSE
        stModeMem.eRemoteMode := E_DeviceMode.Manual;
    END_IF
END_IF
fbRunDelay(xIn := xAutoRun, tOnDelay := stCfgLkg.tRunDelay, itfTime := itfTimeAct);

// 1. Время
BeginCycle();
ltDtSeen := ltDt;

// 2. Конфигурация (LKG)
IF AcceptCfg(wErr := CheckConfig(stCfgIn := stCfg)) THEN
    stCfgLkg := stCfg;
END_IF

// 3. Reset: снимает зафиксированный отказ, если причина ушла
xResetNow := xResetReq OR stCmd.stCommon.xReset;
IF xResetNow THEN
    IF xFaultCause OR xFaultAdd THEN
        SetCmdResult(eResult := E_CmdResult.RejectedFault);
    ELSE
        xFaultLatched := FALSE;
        SetCmdResult(eResult := E_CmdResult.Accepted);
    END_IF
END_IF

// 4. Режим (AI/DI-подобное устройство — память режима stModeMem вместо stRetain)
IF xInputLike THEN
    eRes := ProcessMode(xLocalSel := xLocal, xLocalSupported := xLocalSupported, xOosAllowed := NOT xMoving,
                        stCmd := stCmd.stCommon, stRetain := stModeMem);
ELSE
    eRes := ProcessMode(xLocalSel := xLocal, xLocalSupported := xLocalSupported, xOosAllowed := NOT xMoving,
                        stCmd := stCmd.stCommon, stRetain := stRetain);
END_IF
IF eRes <> E_CmdResult.None THEN
    SetCmdResult(eResult := eRes);
END_IF

// 5. Команды устройства: xStop старше xStart; логика переводит в Manual (SwitchRemoteMode)
IF stCmd.xStop THEN
    IF eMode = E_DeviceMode.Auto OR eMode = E_DeviceMode.Manual THEN
        IF xInputLike THEN
            SwitchRemoteMode(eNew := E_DeviceMode.Manual, stRetain := stModeMem);
        ELSE
            SwitchRemoteMode(eNew := E_DeviceMode.Manual, stRetain := stRetain);
        END_IF
        xManualRun := FALSE;
        SetCmdResult(eResult := E_CmdResult.Accepted);
    ELSE
        SetCmdResult(eResult := E_CmdResult.RejectedMode);
    END_IF
ELSIF stCmd.xStart THEN
    IF eMode <> E_DeviceMode.Manual THEN
        SetCmdResult(eResult := E_CmdResult.RejectedMode);
    ELSIF NOT xCfgEverOk THEN
        SetCmdResult(eResult := E_CmdResult.RejectedCfg);
    ELSIF xFaultLatched OR xFaultCause OR xFaultAdd THEN
        SetCmdResult(eResult := E_CmdResult.RejectedFault);
    ELSE
        xManualRun := TRUE;
        SetCmdResult(eResult := E_CmdResult.Accepted);
    END_IF
END_IF
stCmd.xStart := FALSE;
stCmd.xStop := FALSE;
IF xShedToManual THEN
    IF xInputLike THEN
        SwitchRemoteMode(eNew := E_DeviceMode.Manual, stRetain := stModeMem);
    ELSE
        SwitchRemoteMode(eNew := E_DeviceMode.Manual, stRetain := stRetain);
    END_IF
END_IF

// 6. Логика по LKG. Отказ фиксируется вне OutOfService; безопасный выход — FALSE без корректной
//    Cfg и при отказе (ручная защёлка снимается)
IF (xFaultCause OR xFaultAdd) AND eMode <> E_DeviceMode.OutOfService THEN
    xFaultLatched := TRUE;
END_IF
IF NOT xCfgEverOk OR xFaultLatched THEN
    xOutput := FALSE;
    xManualRun := FALSE;
ELSIF eMode = E_DeviceMode.Auto THEN
    xOutput := fbRunDelay.xOut;
ELSIF eMode = E_DeviceMode.Manual THEN
    xOutput := xManualRun;
ELSE
    xOutput := FALSE;
END_IF
IF xCfgEverOk THEN
    rOut_eu := stCfgLkg.rGain * GAIN_SCALE;
ELSE
    rOut_eu := 0.0;
END_IF

// 7. Тревоги
FOR uiLoop := 1 TO GVL_Const.DEV_ALARMS_MAX DO
    uiSlot := uiLoop - 1;
    axAlmCond[uiSlot] := axCondIn[uiSlot];
    axAlmSuppress[uiSlot] := axSuppressIn[uiSlot];
    arAlmValue[uiSlot] := rValueIn;
END_FOR
RunAlarms(udiIdBase := stCfgLkg.udiAlarmIdBase, stCmd := stCmd.stCommon, astCfg := stCfgLkg.astAlarm);

// 8. Состояние
stSts.rOut_eu := rOut_eu;
IF xFaultLatched THEN
    eDevSt := E_Ne107Status.Failure;
ELSE
    eDevSt := eDevStatusIn;
END_IF
FinishCycle(eDevStatus := eDevSt,
            xAvailableDev := (eMode = E_DeviceMode.Auto) AND NOT xFaultLatched,
            wLow := SEL(xOutput, 0, STS_OUTPUT) OR SEL(xFaultLatched, 0, STS_FAULT),
            wFaultBits := SEL(xFaultLatched, 0, FLT_LATCH),
            wWarnBits := wWarnIn,
            stCommon := stSts.stCommon);
