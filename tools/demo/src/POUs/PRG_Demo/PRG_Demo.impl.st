ltNow := fbClock.Now();
IF NOT xStarted THEN
    xStarted := TRUE;
    ltStart := ltNow;
    ltPrev := ltNow;
END_IF
lrT_s := PL.F_LTimeToSec(ltIn := ltNow - ltStart);
lrDt_s := PL.F_LTimeToSec(ltIn := ltNow - ltPrev);
ltPrev := ltNow;

fbLoop(lrT_s := lrT_s, lrDt_s := lrDt_s);
fbNe43(lrT_s := lrT_s);
fbAlarm(lrT_s := lrT_s);
GVL_DemoLog.xAllDone := fbLoop.xDone AND fbNe43.xDone AND fbAlarm.xDone;
