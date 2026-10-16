astEvent[uiNext] := stEvent;
uiNext := (uiNext + 1) MOD EVENTS_MAX;
uiCount := SEL(uiCount < GVL_Const.UINT_MAX, uiCount, uiCount + 1);   // счётчик не переполняется
OnAlarmEvent := TRUE;
