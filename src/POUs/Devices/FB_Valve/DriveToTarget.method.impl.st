// 6.7 Движение к цели. Motorized: смена направления в ходе — через Reversing; стоп — Intermediate.
//     Соленоид: смена цели в ходе — сразу другое направление, стопа нет
xMayOpen := xIlkAct OR wPermMissOpen = 0;
xMayClose := xIlkAct OR wPermMissClose = 0;
xEnterMove := FALSE;
IF xDrive THEN
    IF eState = E_ValveState.Opening THEN
        IF xAtOpen THEN
            eState := E_ValveState.Open;
        ELSIF xTrqOpen THEN
            xFltTorque := TRUE;                // момент раньше концевика: заклинивание
            eState := E_ValveState.Fault;
        ELSIF eTarget = E_ValveState.Closed THEN
            IF xMotorized THEN
                eState := E_ValveState.Reversing;
            ELSIF xMayClose THEN
                eState := E_ValveState.Closing;
                xEnterMove := TRUE;
            END_IF
        ELSIF eTarget = E_ValveState.Intermediate AND xMotorized THEN
            eState := E_ValveState.Intermediate;
        END_IF
    ELSIF eState = E_ValveState.Closing THEN
        IF xAtClose OR (stCfgLkg.xCloseOnTorque AND xTrqClose) THEN
            eState := E_ValveState.Closed;     // по ZSC или «по моменту» (клиновая задвижка)
        ELSIF xTrqClose THEN
            xFltTorque := TRUE;
            eState := E_ValveState.Fault;
        ELSIF eTarget = E_ValveState.Open THEN
            IF xMotorized THEN
                eState := E_ValveState.Reversing;
            ELSIF xMayOpen THEN
                eState := E_ValveState.Opening;
                xEnterMove := TRUE;
            END_IF
        ELSIF eTarget = E_ValveState.Intermediate AND xMotorized THEN
            eState := E_ValveState.Intermediate;
        END_IF
    ELSIF eState = E_ValveState.Reversing THEN
        IF eTarget = E_ValveState.Intermediate THEN
            eState := E_ValveState.Intermediate;
        END_IF
    ELSIF eTarget = E_ValveState.Open AND eState <> E_ValveState.Open AND xMayOpen THEN
        eState := E_ValveState.Opening;
        xEnterMove := TRUE;
    ELSIF eTarget = E_ValveState.Closed AND eState <> E_ValveState.Closed AND xMayClose THEN
        eState := E_ValveState.Closing;
        xEnterMove := TRUE;
    END_IF
END_IF
