coUnit.TEST('Time_TimeToSec_1500ms_Returns1p5');

AssertEquals_LREAL(Expected := LREAL#1.5, Actual := F_TimeToSec(tIn := T#1500MS),
                   Delta := LREAL#1.0E-12, Message := 'T#1500MS must be 1.5 s');

coUnit.TEST_FINISHED();
