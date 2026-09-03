# Learning Screen Implementation

## Phase 5 scope

The JSON-backed learning flow is available through these routes:

```text
/module/:moduleId
→ /objectives
→ /pretest
→ /theory
→ /vocabulary
→ /reading/:readingId
→ /practice
→ /posttest
→ /result
```

Overview, objectives, theory, vocabulary, and reading are implemented in this
phase. Pre-test, practice, post-test, and result routes are deliberate gateway
screens only; they create no answer, score, progress, or persistence state.

## Content rendering

All learning content is loaded from the existing typed local JSON repository.
No academic passage, objective, theory, vocabulary, or glossary definition is
duplicated inside a feature widget.

## Audio lifecycle

`LearningAudioController` owns one `just_audio` player for the active learning
screen scope. Starting a reading, vocabulary, or glossary asset replaces the
previous asset, so overlapping tracks cannot play. Leaving a learning screen
stops the active player. Audio failures become a non-blocking error state and
never use a network or TTS fallback.

## Glossary strategy

Each reading uses only its associated formal JSON glossary. A deterministic,
case-insensitive phrase matcher sorts terms longest-first and renders the
matched occurrence as a dedicated tappable span. This supports multi-word
terms and keeps non-formal words, including `Genuine`, `Enter`, `Change`, and
`Hand over`, outside the glossary interaction.

## Phase 5 limitations

- Device speaker output and airplane-mode playback still require physical
  Android QA.
- Assessment, scoring, practice interaction, and Drift attempt lifecycle are
  intentionally deferred to later phases.
