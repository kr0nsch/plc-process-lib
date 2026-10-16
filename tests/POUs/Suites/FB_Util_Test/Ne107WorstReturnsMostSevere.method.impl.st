coUnit.TEST('Util_Ne107Worst_ReturnsMostSevere');

AssertTrue(Condition := F_Ne107Worst(eA := E_Ne107Status.Good, eB := E_Ne107Status.Failure)
                       = E_Ne107Status.Failure, Message := 'Good + Failure = Failure');
AssertTrue(Condition := F_Ne107Worst(eA := E_Ne107Status.Failure, eB := E_Ne107Status.Good)
                       = E_Ne107Status.Failure, Message := 'Failure + Good = Failure');
AssertTrue(Condition := F_Ne107Worst(eA := E_Ne107Status.CheckFunction, eB := E_Ne107Status.Failure)
                       = E_Ne107Status.Failure, Message := 'CheckFunction + Failure = Failure');
AssertTrue(Condition := F_Ne107Worst(eA := E_Ne107Status.CheckFunction, eB := E_Ne107Status.OutOfSpecification)
                       = E_Ne107Status.CheckFunction, Message := 'CheckFunction + OutOfSpecification = C');
AssertTrue(Condition := F_Ne107Worst(eA := E_Ne107Status.MaintenanceRequired, eB := E_Ne107Status.OutOfSpecification)
                       = E_Ne107Status.OutOfSpecification, Message := 'Maintenance + OutOfSpecification = S');
AssertTrue(Condition := F_Ne107Worst(eA := E_Ne107Status.MaintenanceRequired, eB := E_Ne107Status.Good)
                       = E_Ne107Status.MaintenanceRequired, Message := 'Maintenance + Good = M');

coUnit.TEST_FINISHED();
