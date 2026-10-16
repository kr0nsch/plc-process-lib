IF uiBack < MIN(uiCount, EVENTS_MAX) THEN
    GetEvent := astEvent[(uiNext + EVENTS_MAX - 1 - uiBack) MOD EVENTS_MAX];
ELSE
    GetEvent := stNone;
END_IF
