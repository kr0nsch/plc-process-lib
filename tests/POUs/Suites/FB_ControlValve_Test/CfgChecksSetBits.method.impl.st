coUnit.TEST('ControlValve_CfgChecks_SetBits');

stCfg.rOutMin_pct := -1.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_LIMITS, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'min < 0');
stCfg.rOutMin_pct := 0.0;
stCfg.rOutMax_pct := 101.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_LIMITS, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'max > 100');
stCfg.rOutMin_pct := 60.0;
stCfg.rOutMax_pct := 60.0;
stCfg.rTightShut_pct := 0.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_LIMITS, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'min >= max');
stCfg.rOutMin_pct := 0.0;
stCfg.rOutMax_pct := 100.0;
stCfg.rRateDown_pctps := -0.5;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_RATE, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'rate < 0');
uBits.dwValue := 16#7FC00000;
stCfg.rRateDown_pctps := 0.0;
stCfg.rRateUp_pctps := uBits.rValue;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_RATE, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'rate NaN');
stCfg.rRateUp_pctps := 0.0;
stCfg.rSafePos_pct := 100.5;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_SAFE_POS, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'safe > 100');
stCfg.rSafePos_pct := 0.0;
stCfg.rDevMax_pct := 0.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'deviation not checked without feedback');
stCfg.xFbUsed := TRUE;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_DEVIATION, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'tolerance 0 with feedback');
stCfg.rDevMax_pct := 5.0;
stCfg.tDev := T#0S;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_DEVIATION, Actual := fbCv.stSts.stCommon.wCfgErr, Message := 'tDev 0');
stCfg.tDev := T#30S;
stCfg.rTightShut_pct := -1.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_TIGHT_SHUT, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'tight < 0');
stCfg.rTightShut_pct := 100.0;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_TIGHT_SHUT, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'tight >= max');
stCfg.rTightShut_pct := 0.0;
uBad.iValue := 3;
stCfg.eFaultAction := uBad.eFaultAction;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_FAULT_ACTION, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'fault action out of enum');
stCfg.eFaultAction := E_CvFaultAction.Hold;
uBad.iValue := 9;
stSlot := stCfg.astAlarm[1];
stSlot.ePriority := uBad.ePriority;
stCfg.astAlarm[1] := stSlot;
fbCv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
AssertEquals_WORD(Expected := GVL_Const.CV_CFG_ALARM, Actual := fbCv.stSts.stCommon.wCfgErr,
                  Message := 'alarm priority');

coUnit.TEST_FINISHED();
