coUnit.TEST('Util_StartsWindow_RingCapacity_MatchesConst');

AssertEquals_UDINT(Expected := GVL_Const.STARTS_WINDOW_MAX, Actual := SIZEOF(fbWin.altStart) / SIZEOF(ltOne),
                   Message := 'ring capacity must equal STARTS_WINDOW_MAX');

coUnit.TEST_FINISHED();
