IF lrT_s <= lrT0_s THEN
    F_DemoInterp := rV0;
ELSIF lrT_s >= lrT1_s OR lrT1_s <= lrT0_s THEN
    F_DemoInterp := rV1;
ELSE
    F_DemoInterp := LREAL_TO_REAL(REAL_TO_LREAL(rV0)
                    + REAL_TO_LREAL(rV1 - rV0) * (lrT_s - lrT0_s) / (lrT1_s - lrT0_s));
END_IF
