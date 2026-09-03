# Practice Engine Implementation — Phase 7

Phase 7 implements the nine existing JSON Practice activities as one generic,
native Flutter flow. Practice state is held by `PracticeSessionController` in
Riverpod memory; no Practice result is written to Drift.

## Activity engine

- Matching stores `sourceId → targetId` pairings and evaluates against the
  JSON `answerMappings`, never against display labels.
- `pair(sourceId, targetId)` is shared by tap-to-match and native
  `LongPressDraggable`/`DragTarget` interaction. A target is one-to-one;
  re-pairing removes the previous source/target conflict deterministically.
- Matching is responsive and stacked for narrow phones. Tap fallback remains
  available when drag is inconvenient. A Check action creates the immutable
  activity result; Reset only clears an unsubmitted activity.
- Sequence activities use `ReorderableListView`, stable item IDs, and the JSON
  `expectedOrder`. The deterministic initial presentation order is retained;
  if it ever equals the answer order, it is rotated to avoid a trivial task.
- Correctness is revealed only after Check. Feedback uses text and icons, not
  color alone.

## Scoring and summary

Every activity delegates to the Phase 6 `PracticeActivityScore` contract:
`round(correctItems / totalItems × 10)`. Exactly three frozen activity results
produce `PracticeScoreSummary` `/30`; independent per-activity rounding is
preserved.

## Current-attempt flow

`CurrentAttemptController` coordinates one module's Pre-test, Practice summary,
and Post-test results in memory. Post-test production routing is guarded until
Practice is complete. Final Result consumes a domain `FinalScoreCalculation`
from the same module/current attempt and cannot fabricate missing values.

Normal flow is:

```text
Reading → Practice 1 → Practice 2 → Practice 3 → Summary
→ Post-test → Final Result
```

## Phase boundary and QA

Phase 7 deliberately does not add Drift writes, retry/history/latest/best,
or persisted module progress. If the Android process is killed, this current
attempt can be lost until Phase 8 persistence is implemented. Automated widget
tests cover tap pairing, reset/check, sequence rendering, responsive widths,
and current-attempt guards. Physical touch drag QA remains device-dependent and
must be run on a real Android device/emulator before release.
