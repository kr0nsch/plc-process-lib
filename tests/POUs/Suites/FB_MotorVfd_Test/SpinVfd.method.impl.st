FOR uiLoop := 1 TO uiN DO
    fbT.Advance(tStep := tDt);
    fbV(itfTime := fbT, stCmd := stC, stRetain := stR, stCfg := stF);
END_FOR
