Revise and improve the EXISTING UI/UX of this Android English learning application.

IMPORTANT:
Do NOT redesign the application from scratch unless an existing part clearly violates the specifications.

First, carefully inspect the current generated UI/UX and read all attached project specification files, especially:

1. PRD.md
2. DESIGN.md
3. the attached detailed project/design prompt specification

Treat these files as the source of truth.

PRD.md defines:
- product scope
- features
- module flow
- assessment behavior
- scoring
- progress
- offline behavior
- features that are out of scope

DESIGN.md defines:
- visual direction
- colors
- typography
- spacing
- component system
- layout
- navigation
- interaction
- motion
- responsiveness
- design constraints

DO NOT modify the product scope.
DO NOT add features outside the Rp3.5 million project scope.
DO NOT change the assessment/scoring logic.
DO NOT remove existing required features.
DO NOT invent academic content.

The goal of this revision is to make the existing UI/UX:

- more modern
- cleaner
- more polished
- more consistent
- easier for Grade X Indonesian vocational-school students to use
- more appropriate for an English learning application
- bilingual at the interface level
- highly readable
- mobile-friendly
- visually professional enough for thesis presentation and real educational use

==================================================
REVISION PRIORITIES
==================================================

Apply revisions according to these priorities:

P1 — MANDATORY
1. Bilingual UI: Bahasa Indonesia + English
2. Bahasa Indonesia must be the default interface language
3. Core English-learning material must remain in English
4. Add a simple language selector
5. Ensure module flow exactly follows PRD.md
6. Ensure result/scoring follows 70/30 rules correctly
7. Ensure Pre-test/Post-test comparison is mathematically correct
8. Remove or avoid all out-of-scope features

P2 — UX
9. Proper fresh-user and returning-user Home states
10. Bottom navigation with exactly 3 items
11. Improve Reading experience
12. Glossary must use bottom sheet
13. Make quiz options more mobile-friendly
14. Make interactive practices clearly understandable
15. Simplify and improve Progress page

P3 — VISUAL POLISH
16. Color consistency
17. Typography consistency
18. Card/radius consistency
19. Icon consistency
20. Spacing consistency
21. Subtle and purposeful motion
22. Responsive Android layouts

==================================================
P1 — BILINGUAL INTERFACE
==================================================

The current application is an English-learning application for Indonesian Grade X vocational high-school students.

The interface should NOT force students to understand every navigation label and instruction in English.

Add exactly TWO interface languages:

1. Bahasa Indonesia
2. English

Default language:
BAHASA INDONESIA

The language preference should visually behave like a locally saved app preference.

Do NOT create:
- account settings
- cloud settings
- user profile settings
- backend language settings

This is only a simple local UI preference.

==================================================
LANGUAGE SELECTOR
==================================================

Add a small language/globe icon in the top-right area of the Home screen.

Use a clean rounded icon button.

When tapped, open a compact bottom sheet.

Example:

Bahasa / Language

● Bahasa Indonesia
○ English

[Terapkan / Apply]

The bottom sheet should:

- slide from the bottom
- use 24px top corner radius
- use subtle backdrop
- clearly show the selected language
- feel consistent with the rest of the application
- be easy to use with one hand

Do not create a full Settings page just for language.

The chosen language should be treated as persistent across all UI screens.

==================================================
WHAT SHOULD CHANGE LANGUAGE
==================================================

When Bahasa Indonesia is selected, localize interface elements such as:

Home
→ Beranda

Modules
→ Modul

Progress
→ Progres

Ready to learn?
→ Siap belajar?

Continue Learning
→ Lanjutkan Belajar

Start Learning
→ Mulai Belajar

Explore Modules
→ Jelajahi Modul

Start Module
→ Mulai Modul

Continue Module
→ Lanjutkan Modul

Learning Objectives
→ Tujuan Pembelajaran

Question 3 of 10
→ Soal 3 dari 10

Previous
→ Sebelumnya

Next
→ Berikutnya

Review & Submit
→ Tinjau & Kirim

Submit
→ Kirim Jawaban

Review Material
→ Pelajari Kembali Materi

Try Again
→ Coba Lagi

Back to Modules
→ Kembali ke Modul

Your Progress
→ Progres Belajarmu

Learning Outcomes
→ Capaian Pembelajaran

How to Use the App
→ Petunjuk Penggunaan

Profile
→ Profil

Correct
→ Benar

Not quite yet
→ Belum tepat

Great job!
→ Bagus!

When English is selected, use the English equivalents.

Localization must be consistent.

Do NOT mix Indonesian and English randomly across navigation.

==================================================
CORE ACADEMIC CONTENT MUST REMAIN ENGLISH
==================================================

IMPORTANT:

The language selector changes the APPLICATION INTERFACE.

It must NOT translate the core English-learning material into Indonesian.

Keep these in English in BOTH interface modes:

- Narrative Text material
- Descriptive Text material
- Procedure Text material
- reading passages
- English example sentences
- learning vocabulary words
- Pre-test questions
- Post-test questions
- answer options
- English exercises
- English learning examples

This application exists to teach English.

Do not remove English exposure.

==================================================
VOCABULARY / GLOSSARY LANGUAGE
==================================================

Vocabulary items should keep:

English word
Part of Speech
Indonesian meaning
Pronunciation

Example:

Supplier
noun
Pemasok
[Speaker icon]

This remains appropriate in both language modes.

==================================================
THEORY TERMINOLOGY
==================================================

For educational terminology, Bahasa Indonesia mode may use a semi-bilingual presentation when useful.

Example:

Definition & Purpose
Pengertian & Tujuan

Generic Structure
Struktur Teks

Key Language Features
Ciri Kebahasaan

Reading Text
Teks Bacaan

Vocabulary Preview
Pratinjau Kosakata

Do not translate the actual English lesson examples.

Use bilingual terminology only when it improves understanding.

Do not make every sentence appear twice.

==================================================
P1 — MODULE FLOW
==================================================

Audit all existing module flows.

Each of the THREE modules must follow this product flow:

Module Overview
↓
Learning Objectives
↓
Pre-test / Diagnostic Assessment
↓
Pre-test Result
↓
Theory / Learning Material
↓
Vocabulary Preview
↓
Reading
├── Local Reading Audio
└── Interactive Glossary
↓
Interactive Practice
↓
Post-test
↓
Final Result
↓
Progress Saved

Do not skip stages.

Do not change the order without PRD approval.

Module 01, Module 02, and Module 03 must reuse the same structural UX pattern while using their respective content and subtle module accents.

==================================================
MODULE ACCESS
==================================================

ALL three modules must be accessible.

Do NOT lock Module 02 or Module 03 behind Module 01.

Correct:

Module 01 — available
Module 02 — available
Module 03 — available

Students may choose any module.

==================================================
P1 — SCORING
==================================================

Audit the Result screen carefully.

The final module score must follow PRD.md:

POST-TEST WEIGHT:
70 points maximum

INTERACTIVE PRACTICE:
30 points maximum

FINAL:
100 points maximum

Formula:

Final Score
=
Post-test Weighted Score
+
Interactive Practice Score

Example:

Post-test:
8 correct answers

Raw percentage:
80 / 100

Weighted score:
56 / 70

Practice:
27 / 30

Final Score:
83 / 100

Do not display incorrect calculations.

==================================================
PRE-TEST
==================================================

Pre-test is diagnostic.

It must:

- be scored /100
- NOT affect the final 70/30 module score
- represent starting knowledge
- be completed before the learning material inside the selected module

Pre-test intro should clearly explain this.

Bahasa Indonesia example:

Pre-test Diagnostik

Mari lihat kemampuan awalmu.

10 soal
Pilihan Ganda

Nilai Pre-test tidak memengaruhi nilai akhir modul.

[Mulai Pre-test]

English version:

Diagnostic Pre-test

Let's see what you already know.

10 Questions
Multiple Choice

Your pre-test score does not affect your final module score.

[Start Pre-test]

Do not visually present the Pre-test as a stressful final exam.

==================================================
PRE-TEST VS POST-TEST COMPARISON
==================================================

This calculation is CRITICAL.

Pre-test is /100.

Post-test has TWO values:

1. Raw Post-test Percentage /100
2. Weighted Post-test Score /70

Learning improvement must compare:

Pre-test /100
VS
Post-test RAW /100

Correct example:

Pre-test:
50 / 100

Post-test:
80 / 100

Improvement:
+30

Do NOT compare:

50 /100
against
56 /70

and claim improvement +6.

The weighted score 56/70 is used only in:

Final Score calculation.

==================================================
FINAL RESULT SCREEN
==================================================

Improve the Final Result screen significantly.

It should feel polished, clear, and achievement-oriented.

Hero area:

Circular score ring

83
/100

Tuntas

Then clearly show:

Pre-test
50 /100

Post-test
80 /100

Peningkatan
+30

Post-test Weighted
56 /70

Interactive Practice
27 /30

Nilai Akhir
83 /100

Nilai Terbaru
83

Nilai Terbaik
88

For English:

Pre-test
Post-test
Improvement
Post-test Weighted
Interactive Practice
Final Score
Latest Score
Best Score

Do not hide scoring details.

==================================================
RESULT — TUNTAS
==================================================

Use:

- success green accent
- clear check icon
- polished score ring
- subtle positive motion

Optional:
very small one-time celebration particles.

Do NOT create:
- full-screen game confetti
- excessive animation
- cartoon celebration

==================================================
RESULT — PERLU REVIEW
==================================================

Do not use a harsh red failure screen.

Use warm warning tone.

Example:

Tetap Semangat

Perlu Review

Pelajari kembali materi lalu coba lagi.

Primary CTA:
Pelajari Kembali Materi

Secondary:
Coba Lagi

English:

Keep Going

Review Recommended

Review Material

Try Again

==================================================
P1 — OUT OF SCOPE
==================================================

Audit the existing UI and REMOVE any of the following if Figma previously generated them:

- Login
- Register
- Authentication
- Student Account
- Teacher Account
- Teacher Dashboard
- Classroom
- Class Code
- Join Class
- Online Database
- Firebase
- Supabase
- Cloud Sync
- Web Admin
- CMS
- Leaderboard
- Ranking
- Chat
- Forum
- AI Tutor
- Social Feed
- Subscription
- Payment
- Advertising
- online monitoring
- account-based profile
- teacher monitoring
- online score synchronization

None of these belong to the current Rp3.5 million scope.

==================================================
P2 — HOME FRESH USER
==================================================

Create a proper FIRST-TIME USER Home state.

There is no account and no student name.

Do NOT invent:

Hello, Sarah
Hello, John
Good morning, Alex

Use neutral copy.

Bahasa Indonesia:

Siap belajar?

Mulai perjalanan belajar Bahasa Inggrismu.

[Jelajahi Modul]

Progres Belajar

0 dari 3 Modul Selesai

English:

Ready to learn?

Start your English learning journey.

[Explore Modules]

Learning Progress

0 of 3 Modules Completed

Fresh users must NOT see fake Continue Learning data.

==================================================
P2 — HOME RETURNING USER
==================================================

When progress exists, show:

Lanjutkan Belajar

Modul 02
Descriptive Text

Reading · POS Terminal

65%

[Lanjutkan]

Then:

Progres Belajar

Your Modules

Quick Access

Bottom Navigation

Continue Learning should be prominent but not oversized.

==================================================
P2 — BOTTOM NAVIGATION
==================================================

Bottom navigation must contain EXACTLY THREE items.

Bahasa Indonesia:

Beranda
Modul
Progres

English:

Home
Modules
Progress

Do not add:

Profile
Petunjuk
Capaian
Settings
Language

as additional bottom-navigation items.

Use icon + label.

Active:

Primary Blue #2563EB

Inactive:

#64748B

Surface:

#FFFFFF

Use subtle top border or soft shadow.

==================================================
QUICK ACCESS
==================================================

Home should provide Quick Access to:

Petunjuk Penggunaan

Capaian Pembelajaran

Profil

English:

How to Use

Learning Outcomes

Profile

Use compact cards with consistent rounded-outline icons.

==================================================
P2 — READING EXPERIENCE
==================================================

The Reading screen is one of the most important screens in the application.

Audit and improve it carefully.

The screen must prioritize:

1. reading comfort
2. content
3. audio
4. glossary interaction
5. decoration

Recommended structure:

Module context

Reading title

Relevant illustration

Reading Audio Player

Reading sections

Interactive glossary words

Body text:

approximately 17px

Comfortable line-height:
approximately 1.55–1.65

Use left-aligned text.

Do not justify.

Use generous vertical spacing.

Do not place every paragraph inside separate heavy cards.

Do not use excessive decorative backgrounds.

Do not use animated backgrounds.

Do not cover reading text with floating UI.

==================================================
READING VISUAL EXAMPLE
==================================================

Module 01

The Story of IKEA:
Innovation in Furniture Retail

[Relevant Illustration]

Listen to Reading

[Restart] [Play/Pause]

00:24 ━━━━━●━━━━ 02:41

ORIENTATION

Long ago in 1943...

Highlighted glossary vocabulary should remain subtle and integrated into the passage.

==================================================
P2 — AUDIO
==================================================

Audio player should be compact and modern.

Include:

- Play
- Pause
- Restart
- progress
- current duration
- total duration

Use soft blue or soft teal surface.

Do NOT use:

- giant waveform
- visualizer animation
- streaming UI
- Spotify-style complex player
- internet indicators

Audio is local/offline.

==================================================
P2 — GLOSSARY
==================================================

Glossary interaction MUST use a bottom sheet.

Do NOT navigate to a separate glossary detail screen every time a reading word is tapped.

When the user taps a highlighted word:

open a bottom sheet.

Example:

Supplier                  [Speaker]

noun

Pemasok

[Close]

Use:

- top handle
- white surface
- 24px top radius
- subtle backdrop
- slide-up animation
- comfortable padding

The user should be able to close it and continue reading from the same position.

==================================================
P2 — QUIZ UX
==================================================

Improve Pre-test and Post-test answer selection for mobile use.

Do NOT use tiny radio buttons.

Each answer must be a large tappable card.

Example:

┌──────────────────────────────┐
│ A    Orientation             │
└──────────────────────────────┘

┌──────────────────────────────┐
│ B    Complication            │
└──────────────────────────────┘

Question layout:

Pre-test

Soal 3 dari 10

████████░░

Question...

[A]
[B]
[C]
[D]

Sebelumnya        Berikutnya

English:

Question 3 of 10

Previous
Next

Entire option card should be tappable.

==================================================
QUIZ OPTION STATES
==================================================

Create and consistently use:

Default
Selected
Correct
Incorrect
Disabled

Selected:

- soft blue background
- blue border
- visible selected indicator
- option letter remains clear

Never rely only on color.

==================================================
P2 — ASSESSMENT SUBMISSION
==================================================

On the final question:

Tinjau & Kirim

Open confirmation:

Kirim jawaban?

Pastikan semua soal sudah dijawab.

[Tinjau Kembali]

[Kirim Jawaban]

English:

Submit your answers?

Make sure all questions have been answered.

[Review Answers]

[Submit]

If unanswered questions exist, show how many remain.

==================================================
P2 — INTERACTIVE PRACTICE
==================================================

Interactive Practice must visibly feel interactive.

Do not show all practice activities as generic text cards.

Support clear visual patterns for:

1. Matching
2. Drag & Drop
3. Sequencing / Reordering

==================================================
MATCHING
==================================================

Use mobile-friendly cards.

Avoid narrow two-column layouts.

Use clear:

idle
selected
matched
correct
incorrect

states.

Tap-to-match interaction may be used visually if dragging is difficult on small screens.

==================================================
DRAG & DROP
==================================================

Draggable card:

- drag/grip icon
- clear text
- comfortable touch area

While dragging:

- slightly elevated
- scale approximately 1.02
- soft shadow

Drop zone:

- dashed border
- soft tinted surface
- highlighted when item is dragged over

Successful drop:

- snap
- green check
- subtle feedback

==================================================
SEQUENCING
==================================================

Use reorderable cards.

Example:

≡  IKEA was founded

≡  Supplier problems appeared

≡  Flat-pack solution developed

≡  IKEA expanded globally

Each item must have:

- drag handle
- order number if helpful
- clear text

==================================================
PRACTICE FEEDBACK
==================================================

Correct:

✓ Bagus!

Jawabanmu benar.

[Lanjut]

English:

Great job!

That's correct.

[Continue]

Incorrect:

Belum tepat

Coba periksa kembali materinya.

[Coba Lagi]

English:

Not quite yet

Review the material and try once more.

[Try Again]

Do not use:

WRONG!

FAILED!

large red full-screen feedback.

==================================================
P2 — PROGRESS SCREEN
==================================================

Simplify the Progress page.

It should feel like a learning-progress overview, not an analytics dashboard.

Recommended:

Progres Belajarmu

2 dari 3 Modul Selesai

████████████░░
67%

Module 01
Narrative Text
✓ Selesai
Nilai 85

Module 02
Descriptive Text
● Sedang Dipelajari
65%

Module 03
Procedure Text
○ Belum Dimulai

Avoid:

- unnecessary pie charts
- bar charts
- analytics graphs
- complex statistics dashboard
- excessive metric cards

==================================================
PROGRESS STATUS
==================================================

Use:

Not Started:
neutral gray

In Progress:
primary blue

Completed:
success green

Tuntas / Perlu Review should remain separate from learning-progress status.

Do not confuse:

Completed
with
Passed/Tuntas.

==================================================
P3 — VISUAL POLISH
==================================================

Perform a visual consistency audit across ALL screens.

The final visual direction remains:

MODERN EDUCATIONAL — SOFT PROFESSIONAL

It should feel:

- premium
- modern
- clean
- youthful
- mature
- calm
- educational
- polished
- intentionally designed

Do not completely replace the existing design if it already follows this direction.

Refine inconsistent parts.

==================================================
COLOR CONSISTENCY
==================================================

Use these core colors consistently:

Primary Blue:
#2563EB

Primary Dark:
#1E40AF

Primary Soft:
#EFF6FF

Navy:
#0F172A

Secondary Text:
#64748B

Muted:
#94A3B8

Background:
#F8FAFC

Surface:
#FFFFFF

Border:
#E2E8F0

Teal Accent:
#14B8A6

Success:
#16A34A

Warning:
#F59E0B

Error:
#EF4444

==================================================
MODULE ACCENTS
==================================================

Module 01 Narrative:
Blue

Module 02 Descriptive:
Purple #7C3AED

Module 03 Procedure:
Teal #0F766E

IMPORTANT:

These are only subtle accents.

Use on:

- badges
- small hero accents
- icons
- small progress highlights
- illustration details

Do NOT recolor the entire app for every module.

==================================================
TYPOGRAPHY
==================================================

Use one consistent modern font family.

Preferred:

Inter

Suggested hierarchy:

Display:
30px / 700

H1:
26px / 700

H2:
22px / 700

H3:
18px / 600

Reading:
17px / 400

Body:
16px / 400

Body Medium:
15px / 500

Small:
14px

Caption:
12–13px

Audit every screen.

Avoid random font sizes.

Avoid tiny text.

==================================================
CARD SYSTEM
==================================================

Standardize cards.

Use:

Standard card:
16px radius

Large/Hero card:
20px radius

Bottom sheet:
24px top radius

Small control:
8–12px radius when appropriate

Card padding:
16–20px

Avoid:

- random 8px / 18px / 27px radii
- overly rounded everything
- pill-shaped large cards
- excessive border/shadow differences

==================================================
SHADOWS
==================================================

Use minimal elevation.

Prefer:

white surface
+
soft border

or

very subtle shadow.

Do not create floating heavy cards.

==================================================
ICONS
==================================================

Use ONE rounded-outline icon family throughout the application.

Visual style similar to:

Lucide
or
Material Symbols Rounded

Do not mix:

- emoji
- filled icons
- outline icons
- 3D icons
- random illustrations used as icons

==================================================
SPACING
==================================================

Use a consistent 4-point spacing system:

4
8
12
16
20
24
32
40
48

Recommended:

Screen horizontal padding:
20px

Small width:
16px

Card internal padding:
16–20px

Major section gap:
24–32px

Audit screens for:

- cramped content
- inconsistent margins
- uneven card spacing
- excessive empty gaps

==================================================
PRIMARY BUTTON
==================================================

Use:

Primary Blue #2563EB

White text

Height around 52px

Radius 14–16px

Semibold label

Learning-flow CTAs should usually be full width.

Examples:

Mulai Pre-test
Lanjut ke Materi
Mulai Latihan
Mulai Post-test

==================================================
BUTTON HIERARCHY
==================================================

Primary:
filled blue

Secondary:
white / blue border

Tertiary:
text button

Do not show multiple equally dominant buttons on one screen.

One primary action per major screen.

==================================================
P3 — MOTION
==================================================

Motion must remain subtle and purposeful.

Do NOT add animation just for decoration.

==================================================
PAGE TRANSITIONS
==================================================

Forward navigation:

slight slide from right
+
fade

220–280ms

Back:

reverse.

Do NOT use:

- spin
- flip
- 3D rotation
- aggressive zoom

==================================================
CARD PRESS
==================================================

On tap:

scale 1.00 → approximately 0.98

100–150ms.

==================================================
GLOSSARY
==================================================

Slide up + fade.

250–300ms.

==================================================
QUIZ OPTION
==================================================

Selected transition:

border
+
background
+
selected indicator

150–180ms.

==================================================
DRAG DROP
==================================================

During drag:

slight elevation
+
scale 1.02

Successful drop:

snap
+
check feedback.

==================================================
PROGRESS
==================================================

Animate from previous progress value.

400–600ms.

Do not loop.

==================================================
RESULT
==================================================

Use restrained sequence:

1. score ring fills
2. score counts up
3. status appears
4. result breakdown fades in

Approximately 700–900ms.

Optional very subtle celebration for completed/tuntas module only.

==================================================
REMOVE EXCESSIVE MOTION
==================================================

Remove if currently present:

- endlessly floating cards
- moving background blobs
- looping particles
- continuous confetti
- autoplay carousels
- animated gradients
- unnecessary bouncing elements

The learning content should remain the focus.

==================================================
P3 — RESPONSIVE
==================================================

Audit and optimize the complete UI for:

360px Android width

390px Android width

412px Android width

Main reference:
390 × 844

==================================================
360PX RULES
==================================================

At 360px:

- horizontal padding approximately 16px
- one-column learning content
- full-width primary CTA
- no 2-column vocabulary if cramped
- quiz cards must remain fully visible
- bottom nav labels must fit
- no text overflow

==================================================
390–412PX RULES
==================================================

Use approximately 20px horizontal padding.

Keep:

- comfortable reading width
- one-column learning flow
- consistent card widths
- bottom navigation stable

Quick Access may use compact multi-column cards only when readability remains good.

==================================================
LONG CONTENT
==================================================

Do not use fixed screen/card heights for text-heavy content.

Use flexible vertical layout.

Allow scrolling.

Ensure:

- headings wrap
- quiz answers wrap
- reading paragraphs wrap
- buttons remain accessible
- no content overlaps bottom navigation

==================================================
ACCESSIBILITY
==================================================

Audit for:

minimum 44–48px touch targets

good contrast

readable text

no state conveyed through color only

success + icon + text

error + icon + text

selected quiz + border/icon/color

scrollable content

no clipped CTA

no hidden essential actions

==================================================
OVERALL UX FLOW
==================================================

After revision, one complete module journey must feel seamless:

Splash
↓
Beranda
↓
Modul
↓
Module Overview
↓
Tujuan Pembelajaran
↓
Pre-test
↓
Hasil Pre-test
↓
Materi
↓
Vocabulary
↓
Reading
├── Audio
└── Glossary
↓
Interactive Practice
↓
Post-test
↓
Hasil Akhir
↓
Progress

The language selector must NOT change this structure.

==================================================
HOME SUPPORT LINKS
==================================================

Home Quick Access should include:

Petunjuk Penggunaan

Capaian Pembelajaran

Profil

These pages must also follow the selected interface language.

==================================================
PETUNJUK
==================================================

Bahasa Indonesia default:

Petunjuk Penggunaan

01 Pilih Modul
02 Kerjakan Pre-test
03 Pelajari Materi
04 Pelajari Vocabulary & Audio
05 Kerjakan Latihan Interaktif
06 Kerjakan Post-test
07 Lihat Progres

English:

How to Use the App

01 Choose a Module
02 Complete Pre-test
03 Study the Material
04 Explore Vocabulary & Audio
05 Complete Interactive Practice
06 Take Post-test
07 Check Your Progress

==================================================
PROFILE
==================================================

Profile is static Researcher / Developer information.

Do NOT transform this page into a user account page.

Do not add:

Edit Profile
Logout
Account Settings
Email
Password

Keep only researcher/developer information specified by PRD.

==================================================
DO NOT REBUILD CORRECT PARTS
==================================================

This is an important revision instruction.

Before modifying a screen:

1. inspect its current quality;
2. compare it with PRD.md;
3. compare it with DESIGN.md;
4. compare it with this revision specification.

If it is already correct:
KEEP IT.

If it only needs polishing:
REFINE IT.

Only substantially redesign a screen if:
- UX is poor;
- functionality is wrong;
- layout is inconsistent;
- screen violates PRD;
- screen violates DESIGN.md.

Avoid unnecessary redesign churn.

==================================================
FINAL VISUAL QUALITY
==================================================

The finished application should look credible for:

- thesis examination
- student testing
- teacher demonstration
- real school usage
- Flutter implementation
- professional portfolio presentation

It should NOT look like a generic AI-generated template.

==================================================
FINAL AUDIT — P1
==================================================

Before finishing, verify:

[ ] Bahasa Indonesia exists
[ ] English exists
[ ] Bahasa Indonesia is default
[ ] Language selector exists
[ ] UI labels change language
[ ] English academic content remains English
[ ] All 3 modules are available
[ ] Module flow follows PRD
[ ] Pre-test is diagnostic
[ ] Pre-test does not affect final score
[ ] Post-test maximum = 70
[ ] Practice maximum = 30
[ ] Final maximum = 100
[ ] Pre/Post comparison uses /100 raw values
[ ] No feature outside scope exists

==================================================
FINAL AUDIT — P2
==================================================

Verify:

[ ] Fresh Home state correct
[ ] Returning Home state correct
[ ] Bottom navigation has exactly 3 items
[ ] Reading is comfortable
[ ] Audio player is simple
[ ] Glossary uses bottom sheet
[ ] Quiz options are mobile-friendly
[ ] Matching interaction clear
[ ] Drag & Drop clear
[ ] Sequencing clear
[ ] Feedback clear
[ ] Progress easy to understand

==================================================
FINAL AUDIT — P3
==================================================

Verify:

[ ] Color palette consistent
[ ] Typography consistent
[ ] Radius consistent
[ ] Icons consistent
[ ] Spacing consistent
[ ] Shadows subtle
[ ] Animation subtle
[ ] 360px layout works
[ ] 390px layout works
[ ] 412px layout works
[ ] No overflow
[ ] No visual clutter
[ ] No childish design
[ ] No corporate dashboard appearance

==================================================
FINAL INSTRUCTION
==================================================

Do not merely describe these revisions.

APPLY the revisions directly to the existing UI/UX.

Preserve the parts that are already correct.

Update all affected screens and reusable components consistently.

Ensure language localization is applied globally.

Ensure the result remains fully aligned with both PRD.md and DESIGN.md.

When complete, perform one final consistency pass across the entire application so every screen feels like part of the same polished Android English-learning product.