coUnit.TEST('Delay_Preset_ForcesOutputWithoutDelay');

fbDelay(xIn := FALSE, tOnDelay := T#5S, tOffDelay := T#5S, itfTime := fbTime);
fbDelay.Preset(xValue := TRUE);
AssertTrue(Condition := fbDelay.xOut, Message := 'Preset(TRUE) must set the output without the on-delay');
fbDelay(xIn := TRUE, tOnDelay := T#5S, tOffDelay := T#5S, itfTime := fbTime);
AssertTrue(Condition := fbDelay.xOut, Message := 'output stays on: input equals output');
AssertFalse(Condition := fbDelay.xTimingOn, Message := 'nothing to time after Preset');
fbDelay.Preset(xValue := FALSE);
AssertFalse(Condition := fbDelay.xOut, Message := 'Preset(FALSE) must clear the output without the off-delay');

coUnit.TEST_FINISHED();
