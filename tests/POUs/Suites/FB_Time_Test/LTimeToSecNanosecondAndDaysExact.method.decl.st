// F_LTimeToSec: 1 нс — 1e-9 с (разрешение LTIME); 100 сут — 8 640 000 с: 8,64e15 нс меньше 2^53,
// LREAL представляет их точно. Источник: tools/reference/common.py, сценарий ltime_to_sec.
METHOD PRIVATE LTimeToSecNanosecondAndDaysExact
