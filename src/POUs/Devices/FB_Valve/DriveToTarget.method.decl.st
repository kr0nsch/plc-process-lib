// Шаг 6.7: переходы движения к цели. Motorized: смена направления в ходе — через Reversing, стоп —
// Intermediate; соленоид: смена цели — сразу другое направление; муфта в ходе — TorqueTrip.
// Шаг тела FB_Valve; внутренний: PROTECTED (правило L5 контракта), имя зарезервировано для наследников
METHOD PROTECTED DriveToTarget
