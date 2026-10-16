// Модель FOPDT без регулятора: ступень входа 10 % с t = 0; первые 40 шагов (L = 4 с) выход 0,
// на 41-м шаге 0,1 = dt/T·K·u, через 24 с — по эталону (около 20·(1 - e^-1)).
METHOD PRIVATE OpenLoopStepMatchesPythonReference
VAR
    fbPlant : FB_FopdtModel;   // модель объекта (K = 2, T = 20 с по умолчанию)
    iStep   : INT;             // шаг модели (0,1 с)
    rY40    : REAL;            // выход после 40 и 41 шага
    rY41    : REAL;
END_VAR
