# FB_StartsWindow — пуски за скользящий час

Окно отметок пусков для лимита «не больше N пусков в час» (`FB_Motor`, `uiMaxStartsPerHour`).
Ёмкость — `GVL_Const.STARTS_WINDOW_MAX` = 30 отметок, длина окна — `GVL_Const.STARTS_WINDOW` = 1 ч.
Окно не энергонезависимо: после перезапуска ПЛК оно пустое (A-03), от частых пусков после
перезапуска защищает тепловая защита двигателя.

Исходник: `src/POUs/Util/FB_StartsWindow/`. Контракт: раздел 8.2.

| Метод | Сигнатура | Действие |
|---|---|---|
| `Register` | `Register(ltNow : LTIME)` | добавить отметку пуска; при заполнении кольца затирается самая старая |
| `Count` | `Count(ltNow : LTIME) : UINT` | число отметок `t` с `t <= ltNow` и `ltNow - t < STARTS_WINDOW` |
| `TimeToFree` | `TimeToFree(ltNow : LTIME; uiMax : UINT) : LTIME` | `LTIME#0S`, если `uiMax = 0` или `Count < uiMax`; иначе — через сколько `Count` станет меньше `uiMax` |
| `Clear` | `Clear()` | очистить |

Тела у ФБ нет. Время — аргумент методов: вызывающий берёт его из своего источника (`ltNow`
устройства).

## Поведение

- Отметки в кольце упорядочены по времени: самая старая — в начале. Это держится и при «времени
  назад»: `Register` сначала удаляет отметки новее регистрируемой.
- `Count` удаляет отметки «из будущего» (время назад) и старше окна — последние больше никогда не
  сосчитаются. Граница: отметка ровно часовой давности уже не считается.
- `TimeToFree` при `Count >= uiMax`: должна истечь отметка номер `Count - uiMax` от самой старой
  (с нуля); ответ — `STARTS_WINDOW - (ltNow - t)`, всегда больше нуля. Разность отметок
  вычисляется только при `ltNow >= t` (LTIME без знака, L7 контракта).
- Граница массива `altStart` записана числом `29` (= `STARTS_WINDOW_MAX - 1`), а не константой:
  iec_checker 0.4 не разбирает константы в границах массивов. Индексы считаются по константе,
  совпадение проверяет тест `Util_StartsWindow_RingCapacity_MatchesConst` (F-07 в
  [ASSUMPTIONS.md](../ASSUMPTIONS.md)).

## Пример

```st
// пуск двигателя: отметка в окне, проверка лимита
IF xEnteredStarting THEN
    fbStarts.Register(ltNow := ltNow);
END_IF
uiStartsLastHour := fbStarts.Count(ltNow := ltNow);
ltWait := fbStarts.TimeToFree(ltNow := ltNow, uiMax := stCfgLkg.uiMaxStartsPerHour);
```

## Тесты (`FB_Util_Test`)

`Util_StartsWindow_CountsOnlyLastHour`, `Util_StartsWindow_TimeToFree_ReportsRemaining`,
`Util_StartsWindow_ExactlyOneHourOld_NotCounted`, `Util_StartsWindow_RingFull_OverwritesOldest`,
`Util_StartsWindow_RingCapacity_MatchesConst`, `Util_StartsWindow_TimeBackwards_DropsFutureStamps`,
`Util_StartsWindow_Clear_Empties`. Эталоны — `tools/reference/common.py`, сценарий `starts_window`.
