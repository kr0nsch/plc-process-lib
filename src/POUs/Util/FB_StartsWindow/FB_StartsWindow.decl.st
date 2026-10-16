// Назначение: пуски за скользящий час (лимит пусков двигателя). Кольцо отметок LTIME,
//             упорядоченных по времени: самая старая — в начале, самая новая — в конце.
//             Отметки старше окна и «из будущего» (время назад) удаляются. Окно не
//             энергонезависимо: после перезапуска ПЛК оно пустое (A-03).
// Автор:      <ИМЯ ФАМИЛИЯ>
// Версия:     0.1.0
// Документ:   docs/fb/FB_StartsWindow.md
FUNCTION_BLOCK FB_StartsWindow
VAR
    // Кольцо отметок пусков. Граница — число 29 = GVL_Const.STARTS_WINDOW_MAX - 1: iec_checker 0.4
    // не разбирает константы в границах массивов (docs/STATIC_ANALYSIS.md). Индексы считаются по
    // STARTS_WINDOW_MAX, совпадение с массивом проверяет тест Util_StartsWindow_RingCapacity_MatchesConst
    // lint:allow STL007 массив a<префикс элемента> (имя по контракту), см. docs/STATIC_ANALYSIS.md
    altStart : ARRAY[0..29] OF LTIME;
    uiNext   : UINT;      // индекс следующей записи
    uiUsed   : UINT;      // занято записей, 0..STARTS_WINDOW_MAX
END_VAR
