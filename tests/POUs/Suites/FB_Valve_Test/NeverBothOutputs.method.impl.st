coUnit.TEST('Valve_NeverBothOutputs');

stCfg.tTravel := T#5S;
stCfg.tReverse := T#300MS;
fbVlv.xZsc := TRUE;
fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
FOR iStep := 1 TO 600 DO
    fbTime.Advance(tStep := T#100MS);
    IF fbVlv.xQOpen THEN
        iPos := iPos + 1;
    END_IF
    IF fbVlv.xQClose THEN
        iPos := iPos - 1;
    END_IF
    iPos := LIMIT(0, iPos, 30);
    fbVlv.xZso := iPos >= 30;
    fbVlv.xZsc := iPos <= 0;
    stCmd.xOpen := iStep MOD 11 = 0;
    stCmd.xClose := iStep MOD 7 = 0;
    stCmd.xStop := iStep MOD 23 = 0;
    stCmd.stCommon.xSetAuto := iStep MOD 97 = 0;
    fbVlv.xAutoOpen := (iStep / 13) MOD 2 = 0;
    fbVlv.wInterlock := SEL((iStep / 40) MOD 4 = 3, 16#0000, 16#0001);
    fbVlv.wPermitOpen := SEL((iStep / 60) MOD 3 = 1, 16#FFFF, 16#0000);
    fbVlv(itfTime := fbTime, stCmd := stCmd, stRetain := stRetain, stCfg := stCfg);
    xEverBoth := xEverBoth OR (fbVlv.xQOpen AND fbVlv.xQClose);
    xSawOpen := xSawOpen OR fbVlv.xQOpen;
    xSawClose := xSawClose OR fbVlv.xQClose;
    xSawRev := xSawRev OR fbVlv.stSts.eState = E_ValveState.Reversing;
END_FOR
AssertFalse(Condition := xEverBoth, Message := 'never both contactors');
AssertTrue(Condition := xSawOpen, Message := 'scenario opened');
AssertTrue(Condition := xSawClose, Message := 'scenario closed');
AssertTrue(Condition := xSawRev, Message := 'scenario reversed');

coUnit.TEST_FINISHED();
