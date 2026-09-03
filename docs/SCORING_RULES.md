# SCORING_RULES.md — Canonical Scoring Specification

> This file is the scoring source of truth.

# 1. Counts

Per module:

```text
Pre-test  = 10 MC
Post-test = 10 MC
Practice  = 3 scored activities
```

Across 3 modules:

```text
30 Pre MC
30 Post MC
9 Practice activities
```

# 2. Pre-test

```text
pretestRaw = round((correct / total) × 100)
```

Store:
- raw;
- correct;
- incorrect;
- timestamp;
- attempt.

Pre-test contributes **0** directly to final.

# 3. Baseline

First-ever submitted Pre-test/module is preserved.

Example:

```text
Attempt 1 Pre = 40
baseline = 40

Attempt 2 Pre = 70
baseline remains 40
```

Baseline is not used for retry gain.

# 4. Practice Activity

Each activity max 10:

```text
activityScore = round((correctItems / totalItems) × 10)
```

Integer result.

For 4 items:

```text
0/4 → 0
1/4 → 3
2/4 → 5
3/4 → 8
4/4 → 10
```

# 5. Practice Total

```text
practiceTotal = a1 + a2 + a3
```

Range 0–30.

# 6. Sequence Partial Credit

Current concept:

```text
correctItems =
number of items currently in expected position
```

Then standard activity formula.

# 7. Matching Partial Credit

```text
correctItems =
count(source where selectedTarget == expectedTarget)
```

Then standard activity formula.

# 8. Post-test Raw

```text
posttestRaw = round((correct / total) × 100)
```

Range 0–100.

# 9. Post-test Weighted

General:

```text
posttestWeighted =
roundToOneDecimal((correct / total) × 70)
```

For 10 questions:

```text
posttestWeighted = correct × 7
```

Range 0–70.

# 10. Final Score

```text
finalScore = posttestWeighted + practiceTotal
```

Defensive:

```text
min(100, roundToOneDecimal(...))
```

# 11. Passing Threshold

Central:

```text
PASSING_THRESHOLD = 75
```

```text
passed = finalScore >= threshold
```

Status is provisional pending school confirmation, but implementation must be centralized.

# 12. Completion vs Passing

After valid Post-test finalization:

```text
completed = true
```

Examples:
- 83 → completed + passed
- 64 → completed + needs review

# 13. Learning Gain

Canonical:

```text
learningGain =
currentAttempt.posttestRaw
-
currentAttempt.pretestRaw
```

Attempt 1:
Pre 40, Post 70 → +30.

Attempt 2:
Pre 70, Post 80 → +10.

Even if baseline is 40, Attempt 2 gain is +10.

# 14. Latest

Final score of most recently completed attempt.

# 15. Best

Maximum final score among completed attempts.

# 16. History

Each completed attempt stores:
- ID;
- number;
- timestamp;
- Pre;
- Practice;
- Post raw;
- Post weighted;
- Final;
- Gain;
- Passed.

Do not retroactively recalculate old history against later content changes without explicit research requirement.

# 17. Worked Example

```text
Pre: 4/10 = 40

Practice:
8 + 9 + 10 = 27

Post:
8/10
Raw 80
Weighted 56

Final = 56 + 27 = 83
Gain = 80 - 40 = +40
Passed = true
```

# 18. Retry Example

Attempt 1:

```text
Pre 40
Practice 20
Post Raw 70
Post Weighted 49
Final 69
Gain +30
Passed false
Baseline 40
```

Attempt 2:

```text
Pre 70
Practice 25
Post Raw 80
Post Weighted 56
Final 81
Gain +10
Passed true
Baseline remains 40
```

History contains both.

# 19. Required Unit Tests

Quiz:
- 0/10
- 1/10
- 10/10
- unanswered draft not correct

Practice:
- 0/4=0
- 1/4=3
- 2/4=5
- 3/4=8
- 4/4=10
- max total 30

Post:
- 0/10=0 weighted
- 7/10=49
- 10/10=70

Final:
- max 100

Gain:
- current-attempt comparison
- negative gain allowed

Retry:
- baseline/history preserved
- latest/best correct

Idempotency:
- finalizing same attempt twice creates one history row.
