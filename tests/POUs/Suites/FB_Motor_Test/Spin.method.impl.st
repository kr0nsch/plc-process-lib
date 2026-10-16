FOR uiLoop := 1 TO uiN DO
    fbT.Advance(tStep := tDt);
    fbM(itfTime := fbT, stCmd := stC, stRetain := stR, stCfg := stF);
END_FOR
