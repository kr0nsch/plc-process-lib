rUDelayed := arDelay[uiHead];
arDelay[uiHead] := rU_pct;
uiHead := uiHead + 1;
IF uiHead >= RING_SIZE THEN
    uiHead := 0;
END_IF
lrY := lrY + DT_S / REAL_TO_LREAL(rT_s) * (REAL_TO_LREAL(rGain) * REAL_TO_LREAL(rUDelayed) - lrY);
rY := LREAL_TO_REAL(lrY);
