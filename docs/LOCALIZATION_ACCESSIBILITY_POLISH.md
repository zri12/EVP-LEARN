# Phase 10 — Localization, Accessibility & UI Polish

Phase 10 is the pre-device quality pass for the accepted Phase 1–9 Flutter
baseline. It changes only system UI presentation and analyzer hygiene; academic
content, scoring, persistence schema, attempt lifecycle, and navigation
contracts remain unchanged.

## Localization

- Supported locales remain Indonesian (`id`, default) and English (`en`).
- The selected locale continues to be persisted through the existing
  `LocaleController`/SharedPreferences path.
- System messages, progress semantics, audio actions, glossary actions, and
  recovery states use ARB strings in both locales.
- Academic English terms, passages, question banks, answer options, and
  practice labels remain source-driven and are not automatically translated.
- Dates continue to use `intl` with the active locale; scores and counts remain
  numeric and deterministic.

## Accessibility and responsive polish

- Root navigation, module/progress/history cards, assessment controls, native
  practice matching targets, sequence items, glossary links, and audio controls
  expose meaningful semantics.
- Audio labels distinguish play, replay, and pause states and provide tooltips.
- Status components retain text and icon/shape cues; color is not the only
  indicator.
- Interactive controls retain approximately 44–48 logical pixel touch targets.
- Existing 360/390/412 responsive widget coverage remains in place. Text is
  allowed to wrap naturally; no global text-scale restriction was added.

## Analyzer and API cleanup

- All 24 baseline informational diagnostics were removed with narrow source
  fixes (curly-brace style and unnecessary wildcard bindings).
- Assessment options now use Flutter's supported `RadioGroup` API while
  retaining answer identity, answer retention, disabled-complete behavior, and
  existing accessibility semantics.
- No global lint suppression or deprecated API suppression was added.

## Verification boundary

Automated analyzer, test, and debug-build gates are recorded in the Phase 10
handoff. Physical Android checks remain deferred to Phase 11: full-flow device
QA, real drag/reorder, speaker playback, airplane mode, system back, and OEM
launcher review.
