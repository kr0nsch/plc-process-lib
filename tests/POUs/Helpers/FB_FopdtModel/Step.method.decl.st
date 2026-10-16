// Один шаг модели dt = 0,1 с: из кольца берётся вход 40 шагов назад, на его место пишется rU_pct
METHOD PUBLIC Step
VAR
    rUDelayed : REAL;   // u[k - 40]
END_VAR
