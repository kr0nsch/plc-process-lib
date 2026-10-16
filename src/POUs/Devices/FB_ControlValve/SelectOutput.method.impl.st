xSafe := FALSE;
xRamping := FALSE;
xLimMin := FALSE;
xLimMax := FALSE;
xSpInvalid := FALSE;
IF NOT xCfgEverOk THEN
    // корректной Cfg не было: положение безопасности из поданной Cfg, в 0…100; NaN — 0
    rSafe_pct := rCfgSafePos_pct;
    IF F_IsFinite(rIn := rSafe_pct) THEN
        rRamp_pct := LIMIT(0.0, rSafe_pct, GVL_Const.PCT_FULL);
    ELSE
        rRamp_pct := 0.0;
    END_IF
    xSafe := TRUE;
    rSpAct := rRamp_pct;
ELSIF eMode = E_DeviceMode.OutOfService THEN
    rSpAct := rRamp_pct;
ELSIF eMode = E_DeviceMode.Local THEN
    // позиционер на месте: выход следит за ОС (возврат без рывка), без ОС — удержание
    IF xFbOk THEN
        rRamp_pct := rPosFb_pct;
    END_IF
    rSpAct := rRamp_pct;
ELSIF xIlkAct OR (xFaultAny AND stCfgLkg.eFaultAction = E_CvFaultAction.SafePos) THEN
    // блокировка и отказ с SafePos: мимо пределов и рампы — безопасность важнее плавности
    rRamp_pct := stCfgLkg.rSafePos_pct;
    xSafe := TRUE;
    rSpAct := rRamp_pct;
ELSIF xFaultAny THEN
    rSpAct := rRamp_pct;
ELSE
    IF eMode = E_DeviceMode.Auto THEN
        rSpRaw := rPosSpAuto_pct;
    ELSE
        rSpRaw := rManSp_pct;
    END_IF
    IF F_IsFinite(rIn := rSpRaw) THEN
        rSpAct := LIMIT(stCfgLkg.rOutMin_pct, rSpRaw, stCfgLkg.rOutMax_pct);
        xLimMin := rSpRaw < stCfgLkg.rOutMin_pct;
        xLimMax := rSpRaw > stCfgLkg.rOutMax_pct;
        IF lrDt_s > 0.0 THEN
            rRamp_pct := F_RateLimit(rCurrent := rRamp_pct, rTarget := rSpAct,
                                     rRateUp_ups := stCfgLkg.rRateUp_pctps,
                                     rRateDown_ups := stCfgLkg.rRateDown_pctps, lrDt_s := lrDt_s);
        ELSIF (rSpAct > rRamp_pct AND stCfgLkg.rRateUp_pctps <= 0.0)
              OR (rSpAct < rRamp_pct AND stCfgLkg.rRateDown_pctps <= 0.0)
        THEN
            // шага времени нет (первый вызов, время назад), а скорость не ограничена — сразу к заданию
            rRamp_pct := rSpAct;
        END_IF
        xRamping := rRamp_pct <> rSpAct;
    ELSE
        // NaN из Modbus/ПИД: удержание и предупреждение
        xSpInvalid := TRUE;
        rSpAct := rRamp_pct;
    END_IF
END_IF
