coUnit.TEST('Time_TimeToSec_MaxTime_NoOverflow');

AssertEquals_LREAL(Expected := LREAL#4294967.295, Actual := F_TimeToSec(tIn := T#49D17H2M47S295MS),
                   Delta := LREAL#1.0E-6, Message := 'maximum TIME must convert without overflow');

coUnit.TEST_FINISHED();
