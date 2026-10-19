IF GVL_DemoLog.uiEvN < GVL_DemoConst.EVENT_LOG_N THEN
    GVL_DemoLog.arEvT_s[GVL_DemoLog.uiEvN] := LREAL_TO_REAL(lrT_s);
    GVL_DemoLog.aiEvScenario[GVL_DemoLog.uiEvN] := iScenario;
    GVL_DemoLog.aiEvCode[GVL_DemoLog.uiEvN] := iCode;
    GVL_DemoLog.uiEvN := GVL_DemoLog.uiEvN + 1;
    F_DemoEvent := TRUE;
END_IF
