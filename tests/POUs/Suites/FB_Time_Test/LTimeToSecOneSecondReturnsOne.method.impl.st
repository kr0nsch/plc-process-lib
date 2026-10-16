coUnit.TEST('Time_LTimeToSec_OneSecond_ReturnsOne');

AssertEquals_LREAL(Expected := LREAL#1.0, Actual := F_LTimeToSec(ltIn := LTIME#1S),
                   Delta := LREAL#1.0E-12, Message := 'LTIME#1S must be 1.0 s');
AssertEquals_LREAL(Expected := LREAL#0.001, Actual := F_LTimeToSec(ltIn := LTIME#1MS),
                   Delta := LREAL#1.0E-15, Message := 'LTIME#1MS must be 0.001 s');

coUnit.TEST_FINISHED();
