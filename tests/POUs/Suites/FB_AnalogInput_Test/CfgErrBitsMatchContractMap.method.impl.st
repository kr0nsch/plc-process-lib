coUnit.TEST('AnalogInput_CfgErrBits_MatchContractMap');

stCfg.eInput := E_AiInputType.Eng;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'valid base Cfg');
stBad := stCfg;
uEnum.iValue := 7;
stBad.eInput := uEnum.eInput;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_INPUT_TYPE, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'input type');
stBad := stCfg;
stBad.rRangeLo_eu := 100.0;
stBad.rRangeHi_eu := 0.0;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_RANGE, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'range');
stBad := stCfg;
SetLimit(stCfgAi := stBad, uiIdx := E_AiAlarm.H, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
SetLimit(stCfgAi := stBad, uiIdx := E_AiAlarm.HH, xEnable := TRUE, rSp_eu := 80.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_LIMIT_ORDER, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'order: HH = H is not strictly greater');
stBad := stCfg;
SetLimit(stCfgAi := stBad, uiIdx := E_AiAlarm.LL, xEnable := TRUE, rSp_eu := -1.0, rHyst_eu := 1.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_LIMIT_OUT_OF_RANGE, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'limit out of range');
stBad := stCfg;
SetLimit(stCfgAi := stBad, uiIdx := E_AiAlarm.L, xEnable := TRUE, rSp_eu := 20.0, rHyst_eu := -0.5, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_HYST, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'negative hyst');
SetLimit(stCfgAi := stBad, uiIdx := E_AiAlarm.L, xEnable := TRUE, rSp_eu := 20.0, rHyst_eu := 100.0, tOnDly := T#0S,
         tOffDly := T#0S);
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_HYST, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'hyst >= span');
stBad := stCfg;
stBad.rLowCut_pct := 25.0;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_LOW_CUT, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'low cut > 20');
stBad.rLowCut_pct := -1.0;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_LOW_CUT, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'low cut < 0');
stBad.rLowCut_pct := GVL_Const.AI_LOWCUT_MAX_PCT;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'low cut at the limit is valid');
stBad := stCfg;
uEnum.iValue := 5;
stBad.eFailValue := uEnum.eAiFailValue;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_FAIL_VALUE, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'fail value out of enum');
stBad := stCfg;
uBits.dwValue := 16#7FC00000;
stBad.rFailValue_eu := uBits.rValue;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_FAIL_VALUE, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'fail value NaN');
stBad := stCfg;
uPrio.iValue := 9;
SetAlarmPriority(stCfgAi := stBad, uiSlot := E_AiAlarm.L, ePriority := uPrio.ePriority);
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_ALARM, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'alarm priority');
stBad := stCfg;
stBad.eInput := E_AiInputType.Raw;
stBad.rRawLo_cnt := 100.0;
stBad.rRawHi_cnt := 100.0;
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stBad);
AssertEquals_WORD(Expected := GVL_Const.AI_CFG_RAW_RANGE, Actual := fbAi.stSts.stCommon.wCfgErr,
                  Message := 'raw range');
fbAi(itfTime := fbTime, rIn := 50.0, stCmd := stCmd, stCfg := stCfg);
AssertEquals_WORD(Expected := 0, Actual := fbAi.stSts.stCommon.wCfgErr, Message := 'valid Cfg again');

coUnit.TEST_FINISHED();
