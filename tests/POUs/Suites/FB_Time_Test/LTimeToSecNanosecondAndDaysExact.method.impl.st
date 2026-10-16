coUnit.TEST('Time_LTimeToSec_NanosecondAndDays_Exact');

AssertEquals_LREAL(Expected := LREAL#1.0E-9, Actual := F_LTimeToSec(ltIn := LTIME#1NS),
                   Delta := LREAL#1.0E-18, Message := 'LTIME#1NS must be 1e-9 s');
AssertEquals_LREAL(Expected := LREAL#8640000.0, Actual := F_LTimeToSec(ltIn := LTIME#100D),
                   Delta := LREAL#1.0E-6, Message := 'LTIME#100D must be 8640000 s');

coUnit.TEST_FINISHED();
