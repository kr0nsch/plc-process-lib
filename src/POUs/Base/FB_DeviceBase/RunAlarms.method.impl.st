uiUsed := MIN(uiAlarmCount, GVL_Const.DEV_ALARMS_MAX);

// 1. Запросы: квитировать всё (xAck, xReset, AckAll(), Reset()), маски по слотам. Методы слотов
//    только ставят запрос — его выполняет вызов слота в шаге 2 этого же цикла
xAckAllNow := stCmd.xAck OR stCmd.xReset OR xAckAllReq OR xResetReq;
wBit := 1;
FOR uiLoop := 1 TO uiUsed DO
    uiSlot := uiLoop - 1;
    itfAlarm := afbAlarm[uiSlot];
    IF xAckAllNow OR (stCmd.wAckReq AND wBit) <> 0 THEN
        xAccepted := itfAlarm.Ack();
    END_IF
    // в OutOfService shelve не принимается (10.1); проверка по режиму устройства, а не по ответу
    // слота: в вызове входа в OutOfService слот ещё не в OutOfService и ответил бы TRUE, а его тело
    // запрос отклонит — результат команды был бы ложным Accepted
    IF (stCmd.wShelveReq AND wBit) <> 0 AND eMode <> E_DeviceMode.OutOfService THEN
        xAccepted := itfAlarm.Shelve(tDuration := T#0S);
        xShelveAny := xShelveAny OR xAccepted;
    END_IF
    IF (stCmd.wUnshelveReq AND wBit) <> 0 THEN
        xAccepted := itfAlarm.Unshelve();
    END_IF
    wBit := SHL(wBit, 1);
END_FOR
// результаты: «квитировать всё» (xAck и AckAll() вместе — одна команда) и каждая ненулевая маска;
// xReset и Reset() дают результат в шаге Reset устройства
IF stCmd.xAck OR xAckAllReq THEN
    SetCmdResult(eResult := E_CmdResult.Accepted);
END_IF
IF stCmd.wAckReq <> 0 THEN
    SetCmdResult(eResult := E_CmdResult.Accepted);
END_IF
IF stCmd.wShelveReq <> 0 THEN
    IF xShelveAny THEN
        SetCmdResult(eResult := E_CmdResult.Accepted);
    ELSE
        SetCmdResult(eResult := E_CmdResult.RejectedState);
    END_IF
END_IF
IF stCmd.wUnshelveReq <> 0 THEN
    SetCmdResult(eResult := E_CmdResult.Accepted);
END_IF
stCmd.xAck := FALSE;
stCmd.xReset := FALSE;
stCmd.wAckReq := 0;
stCmd.wShelveReq := 0;
stCmd.wUnshelveReq := 0;

// 2. Вызов слотов и 3. сводка. OutOfService устройства — OutOfService у всех слотов
wAlmActive := 0;
wAlmUnack := 0;
wAlmShelved := 0;
ePrioUnack := E_AlarmPriority.None;
wBit := 1;
FOR uiLoop := 1 TO uiUsed DO
    uiSlot := uiLoop - 1;
    CallAlarmSlot(xCond := axAlmCond[uiSlot], xSupp := axAlmSuppress[uiSlot], udiSlotId := udiIdBase + uiSlot,
                  rSlotValue := arAlmValue[uiSlot], stSlotCfg := astCfg[uiSlot], fbAlarm := afbAlarm[uiSlot]);
    itfAlarm := afbAlarm[uiSlot];
    IF itfAlarm.Active THEN
        wAlmActive := wAlmActive OR wBit;
    END_IF
    IF itfAlarm.Unacked THEN
        wAlmUnack := wAlmUnack OR wBit;
        ePrioUnack := MAX(ePrioUnack, itfAlarm.AlarmPriority);
    END_IF
    eSlotState := itfAlarm.State;
    IF eSlotState = E_AlarmState.Shelved OR eSlotState = E_AlarmState.SuppressedByDesign
       OR eSlotState = E_AlarmState.OutOfService
    THEN
        wAlmShelved := wAlmShelved OR wBit;
    END_IF
    wBit := SHL(wBit, 1);
END_FOR
