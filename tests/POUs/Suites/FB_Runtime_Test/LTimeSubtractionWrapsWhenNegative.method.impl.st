coUnit.TEST('Runtime_LTimeSubtraction_WrapsWhenNegative');

ltD := ltA - ltB;
AssertTrue(Condition := ltD > LTIME#100000D, Message := 'a - b with a < b wraps to a huge value');
AssertEquals_LTIME(Expected := ltA, Actual := ltD + ltB, Message := 'modular arithmetic: (a - b) + b = a');

coUnit.TEST_FINISHED();
