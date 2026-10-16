IF NOT xCfgEverOk THEN
    // безопасное значение: корректной Cfg ещё не было
    xValue := FALSE;
    xValid := FALSE;
ELSIF eMode = E_DeviceMode.OutOfService THEN
    // значение удерживается
    xValid := FALSE;
ELSIF eMode = E_DeviceMode.Manual THEN
    xValue := xSubst;
    xValid := TRUE;
ELSIF xChannelFault THEN
    IF stCfgLkg.eFailValue = E_DiFailValue.ForceFalse THEN
        xValue := FALSE;
    ELSIF stCfgLkg.eFailValue = E_DiFailValue.ForceTrue THEN
        xValue := TRUE;
    ELSE
        xValue := xGood;
    END_IF
    xValid := FALSE;
ELSE
    xValue := xGood;
    xValid := TRUE;
END_IF
