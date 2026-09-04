# LOCALIZATION.md — Indonesian / English UI

## 1. Supported Locales

```text
id  Indonesian — default
en  English
```

Fresh install default:
Indonesian.

Persist locale.

## 2. What Is Localized

Localize system UI:
- navigation;
- buttons;
- headers;
- descriptions;
- status;
- assessment instructions;
- feedback;
- result labels;
- progress labels;
- profile field labels;
- accessibility semantics.

Do not automatically translate canonical academic English.

## 3. Academic Content Rule

Remain English:
- reading titles/passages;
- target English vocabulary;
- canonical English examples;
- academic structures where source presents them in English.

Indonesian meanings remain as source data.

Where prototype intentionally uses bilingual educational wording, preserve pedagogy.

## 4. Flutter Implementation

Use ARB:

```text
lib/l10n/app_id.arb
lib/l10n/app_en.arb
```

Use Flutter localization generation.

Do not maintain giant duplicated manual maps in widgets.

## 5. Semantic Keys

Examples:

```text
navHome
navModules
navProgress
navProfile
startModule
continueModule
reviewModule
startPretest
startPosttest
reviewAndSubmit
submitAnswers
learningObjectives
learningMaterial
vocabularyPreview
reading
interactivePractice
finalScore
latestScore
bestScore
passed
needsReview
```

Avoid visual-position names like `blueText1`.

## 6. Module Labels

Indonesian:
`Modul 01`

English:
`Module 01`

The web prototype had some mixed hardcoded “Module” text in Indonesian mode. Flutter should normalize correctly.

## 7. Profile

Profile values are data, not UI translation:
- researcher;
- university;
- research title.

Field labels are localized.

Do not invent a translated research title.

## 8. Locale Persistence

On change:
1. update app locale;
2. persist;
3. re-render;
4. preserve progress.

Restart keeps locale.

## 9. Audio and Locale

Pronunciation/reading audio remains English academic audio.

Do not swap by system locale unless approved separate audio exists.

## 10. Date Formatting

Use `intl` for attempt dates.

Store timestamps locale-independently.

## 11. Accessibility Labels

Localize:
- play/pause;
- close;
- back;
- move up/down;
- drag instructions;
- selected state;
- progress semantics.

Phase 10 also localizes play/replay/pause pronunciation and reading-audio
actions, glossary definition hints, drag/drop and reorder hints, unavailable
states, and the progress percentage announcement.

## 12. Validation

Tests:
- default Indonesian;
- switch English;
- persist after restart;
- all four bottom-nav labels;
- result labels;
- academic reading unchanged.
