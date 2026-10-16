coUnit.TEST('Runtime_MethodCallWithoutThis_DispatchesVirtually');

AssertEquals_UINT(Expected := 2, Actual := fbDerived.CallViaThis(), Message := 'THIS^ call runs the derived override');
AssertEquals_UINT(Expected := 2, Actual := fbDerived.CallPlain(),
                  Message := 'call without THIS^ runs the derived override');
AssertEquals_UINT(Expected := 1, Actual := fbBase.CallViaThis(),
                  Message := 'base instance runs the base implementation');
AssertEquals_UINT(Expected := 1, Actual := fbBase.CallPlain(), Message := 'base instance, call without THIS^');

coUnit.TEST_FINISHED();
