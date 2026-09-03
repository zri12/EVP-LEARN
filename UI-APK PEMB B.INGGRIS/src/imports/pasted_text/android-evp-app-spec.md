You are designing and building a complete high-fidelity interactive mobile UI/UX prototype for an Android educational application.

IMPORTANT: Before generating anything, fully read and understand BOTH attached files:

1. PRD.md
2. DESIGN.md

These two files are mandatory sources of truth.

SOURCE-OF-TRUTH HIERARCHY

- PRD.md defines WHAT the product must do:
  product scope, features, user flow, scoring logic, progress behavior, offline requirements, assessments, module structure, persistence behavior, and what is explicitly out of scope.

- DESIGN.md defines HOW the product must look and behave visually:
  visual direction, colors, typography, spacing, components, layout, motion, navigation, responsive behavior, states, screen specifications, interaction patterns, and UI constraints.

Do NOT ignore either document.

If a visual decision conflicts with product behavior, PRD.md takes priority for behavior.

If a visual/layout decision is not specified in PRD.md but is specified in DESIGN.md, follow DESIGN.md.

Do not invent new features.

Do not modify the product scope.

Do not silently simplify required features.

Do not change the assessment or scoring logic.

==================================================
PROJECT
==================================================

Create a modern Android mobile educational application for Grade X vocational high-school students learning English for Vocational Purposes (EVP) in a retail context.

The application contains three learning modules:

Module 01
Narrative Text
Inspirational Business & Brand Stories

Module 02
Descriptive Text
Retail Products & Store Fixtures

Module 03
Procedure Text
Store Standard Operating Procedures

The application is an offline-first, single-device learning application.

There is NO authentication system.

There is NO teacher dashboard.

There is NO student account.

There is NO classroom system.

There is NO class code.

There is NO backend.

There is NO Firebase.

There is NO Supabase.

There is NO web admin.

There is NO online score synchronization.

Do not generate UI for any of those features.

==================================================
PRIMARY DESIGN GOAL
==================================================

Create a polished, modern, clean, premium educational mobile experience that feels appropriate for teenage vocational-school students.

The visual personality should be:

- Modern
- Educational
- Soft professional
- Clean
- Structured
- Calm
- Friendly
- Youthful but mature
- Highly readable
- Interactive without becoming childish
- Visually refined
- Suitable for a real thesis/research application
- Suitable for continued educational use after research

The application must NOT look like:

- a children's learning game
- a school administration dashboard
- an ERP system
- an e-commerce app
- a corporate SaaS dashboard
- a neon gaming application
- a generic template
- an old-fashioned LMS
- a cartoon-heavy learning app

The interface should feel intentionally designed, not AI-generated.

==================================================
DESIGN LANGUAGE
==================================================

Use the design direction from DESIGN.md:

Modern Educational — Soft Professional.

PRIMARY COLOR
#2563EB

PRIMARY DARK
#1E40AF

PRIMARY SOFT
#EFF6FF

MAIN TEXT / NAVY
#0F172A

SECONDARY TEXT
#64748B

MUTED TEXT
#94A3B8

APPLICATION BACKGROUND
#F8FAFC

SURFACE
#FFFFFF

BORDER
#E2E8F0

SECONDARY ACCENT / TEAL
#14B8A6

SUCCESS
#16A34A

WARNING
#F59E0B

ERROR
#EF4444

Keep blue dominant.

Teal is secondary.

Do not overuse gradients.

Do not use neon colors.

Do not use heavy glassmorphism.

Do not use large glossy 3D components.

==================================================
MODULE ACCENT COLORS
==================================================

The application must remain visually consistent.

Use only subtle module differentiation:

Module 01 Narrative:
Blue accent

Module 02 Descriptive:
Purple accent #7C3AED

Module 03 Procedure:
Teal accent #0F766E

Module accents may appear in:

- module badge
- small illustration details
- hero accent
- progress highlight
- module icon
- subtle background tint

DO NOT completely recolor the application for each module.

==================================================
TYPOGRAPHY
==================================================

Use Inter as the primary interface font.

Typography hierarchy:

Display:
30px / 700

H1:
26px / 700

H2:
22px / 700

H3:
18px / 600

Reading Text:
17px / 400
comfortable line-height approximately 1.55–1.65

Body:
16px / 400

Body Medium:
15px / 500

Small:
14px

Caption:
12–13px

Long reading content must remain extremely readable.

Do not justify body text.

Use left alignment.

Avoid tiny typography.

==================================================
SPACING AND SHAPE SYSTEM
==================================================

Use a 4-point spacing system.

Primary values:

4
8
12
16
20
24
32
40
48

Default screen horizontal padding:
20px

Small Android:
16px

Card padding:
16–20px

Section spacing:
24–32px

Radius:

Small:
8px

Medium:
12px

Standard Card:
16px

Large / Hero Card:
20px

Bottom Sheet:
24px top radius

Use subtle borders and very soft elevation.

Avoid large shadows.

==================================================
ICONOGRAPHY
==================================================

Use ONE consistent rounded outline icon family.

Preferred visual style:

Lucide-like
or
Material Symbols Rounded-like

Do not mix icon styles.

Do not use emoji as primary UI icons.

==================================================
ILLUSTRATION DIRECTION
==================================================

Use modern editorial semi-flat illustration.

Illustrations should have:

- clean geometry
- soft depth
- realistic proportions
- restrained colors
- subtle shadows
- educational context
- modern retail context

Avoid childish cartoon characters.

For product-oriented content such as:

- POS terminal
- supermarket gondola shelving
- leather biker jacket

use clean semi-realistic educational product illustrations.

For Narrative and Procedure sections, use modern editorial scenes.

==================================================
TARGET DEVICE
==================================================

Design mobile-first for Android.

Main reference viewport:

390 × 844

Also ensure layouts behave properly at:

360px width
390px width
412px width

Primary orientation:
portrait.

All major content must use flexible vertical layouts.

Long content must scroll.

Do not create desktop-first layouts.

Do not create a tablet dashboard.

==================================================
NAVIGATION
==================================================

Primary bottom navigation must contain EXACTLY THREE items:

1. Home
2. Modules
3. Progress

Do not add more items.

Bottom navigation should use:

- icon + label
- white surface
- subtle top border
- active blue state
- muted inactive state
- optional soft-blue active pill

Petunjuk / Guide,
Capaian Pembelajaran / Learning Outcomes,
and Profile

must be accessed through Home Quick Access, not bottom navigation.

==================================================
FULL SCREEN INVENTORY
==================================================

Design and implement all important screens/states required by PRD.md and DESIGN.md.

The prototype must include at minimum:

01. Splash Screen

02. Home — Fresh User

03. Home — Returning User / Continue Learning

04. Modules List

05. Module Overview

06. Learning Objectives

07. Pre-test Introduction

08. Pre-test Question

09. Pre-test Review / Submit Confirmation

10. Pre-test Result

11. Theory / Learning Material

12. Vocabulary Preview

13. Reading Screen

14. Reading Audio Player State

15. Interactive Glossary Bottom Sheet

16. Interactive Practice Introduction

17. Practice — Matching

18. Practice — Drag & Drop

19. Practice — Sequencing

20. Practice Correct Feedback

21. Practice Incorrect Feedback

22. Post-test Introduction

23. Post-test Question

24. Post-test Review / Submit Confirmation

25. Final Result — Tuntas

26. Final Result — Perlu Review

27. Pre-test vs Post-test Comparison

28. Progress Screen

29. Petunjuk Penggunaan / How to Use

30. Capaian Pembelajaran / Learning Outcomes

31. Profile / Researcher

32. Empty Progress State

33. Generic Error State

34. Missing Audio State

Reuse components and templates rather than creating inconsistent visual styles for every screen.

==================================================
HOME — FRESH USER
==================================================

Create a clear first-use Home state.

There is no login and no student name.

Do not use fake personal greetings such as:
"Hello, John."

Use something neutral such as:

"Ready to learn?"

Supporting copy:

"Start your English learning journey."

The page hierarchy should be:

Header / Branding

Start Learning Hero

Overall Progress:
0 of 3 modules

Modules preview

Quick Access

Bottom Navigation

Do NOT display Continue Learning if no progress exists.

Primary CTA:
Explore Modules

==================================================
HOME — RETURNING USER
==================================================

Returning-user Home hierarchy:

Header

Continue Learning card

Overall learning progress

Your Modules

Quick Access

Bottom Navigation

Continue Learning card should show:

- module number
- module title
- last learning section
- module progress
- Continue CTA

Example concept:

Continue Learning

Module 02
Descriptive Text

Reading · POS Terminal

65%

Continue →

Do not make the card visually overwhelming.

==================================================
MODULE LIST
==================================================

Header:

Learning Modules

Subtitle:

Choose any module to start learning.

All three modules are unlocked.

Each Module Card must communicate:

- module number
- module title
- module subtitle
- illustration/icon
- current status
- progress
- action

Status variants:

Not Started
In Progress
Completed

CTA variants:

Start
Continue
Review / Learn Again

==================================================
MODULE OVERVIEW
==================================================

Create a visually strong but clean module introduction.

Hierarchy:

Module badge

Module title

Subtitle

Hero illustration

About This Module

You Will Learn

Learning Journey

Primary CTA

Learning Journey must visually communicate:

1. Pre-test
2. Learn
3. Practice
4. Post-test

Use a vertical stepper or timeline.

States:

Upcoming = gray

Current = blue

Completed = green

Do not lock other modules globally.

==================================================
LEARNING OBJECTIVES
==================================================

Do not show objectives as one plain paragraph.

Use structured objective cards/list.

Example hierarchy:

Learning Objectives

After completing this module, you will be able to:

01
Objective

02
Objective

03
Objective

Primary CTA:
Start Pre-test

==================================================
PRE-TEST INTRO
==================================================

The experience must feel diagnostic, not threatening.

Use:

Diagnostic Pre-test

Let's see what you already know.

Display metadata:

10 questions
Multiple Choice

Important information card:

"Your pre-test score does not affect your final module score."

Primary CTA:
Start Pre-test

Do not use celebratory graphics before the test.

==================================================
ASSESSMENT TEMPLATE
==================================================

Pre-test and Post-test MUST reuse one consistent assessment design.

Layout:

Top App Bar

Assessment Type

Question Counter

Linear Progress

Question

Four large answer option cards

Bottom Navigation:
Previous
Next

Example:

Question 3 of 10

Question content...

[A] Answer
[B] Answer
[C] Answer
[D] Answer

Previous
Next

Option cards must have comfortable mobile touch targets.

Do not use tiny radio buttons.

==================================================
QUIZ OPTION STATES
==================================================

Create variants:

Default

Selected

Correct

Incorrect

Disabled

Selected state:

- soft blue background
- blue border
- visible option letter
- accessible state indicator

Do not communicate selection using color alone.

==================================================
ASSESSMENT SUBMIT
==================================================

On last question show:

Review & Submit

Before submission display confirmation:

Submit your answers?

Make sure you have answered all questions.

Actions:

Review Answers

Submit

If unanswered questions exist, show a clear warning.

==================================================
PRE-TEST RESULT
==================================================

Keep the result calm and informative.

Hero:

60 / 100

Supporting:

6 correct
4 incorrect

Message:

"This score represents your starting knowledge."

Primary CTA:

Continue to Learning

Do NOT use confetti here.

Pre-test is diagnostic.

==================================================
THEORY / LEARNING CONTENT
==================================================

High readability is critical.

Show current context:

Module 01 · Narrative Text

Learn · Step 2 of 4

Use structured sections.

Examples:

Definition & Purpose

Generic Structure

Key Language Features

Avoid a huge single white text card.

Use semantic sections and subtle visual hierarchy.

==================================================
GENERIC STRUCTURE
==================================================

Use a visual timeline / step pattern.

Narrative may show:

Orientation
↓
Complication
↓
Resolution
↓
Re-orientation

Descriptive:

Identification
↓
Description

Procedure:

Goal
↓
Materials
↓
Steps

Use consistent component styling.

==================================================
VOCABULARY PREVIEW
==================================================

Title:

Vocabulary Preview

Subtitle:

Learn these words before reading.

Each vocabulary card contains:

- English word
- part of speech
- Indonesian meaning
- pronunciation button

Prefer a one-column list on mobile.

Pronunciation button must have at least a 44px touch target.

Use teal subtly for audio/vocabulary interactions.

Do not autoplay audio.

==================================================
READING SCREEN
==================================================

This is one of the most important screens.

Prioritize readability.

Hierarchy:

Module context

Reading title

Relevant illustration

Reading audio card

Reading text sections

Interactive glossary words

Use reading body size around 17px.

Use generous line height.

Interactive glossary words should be visibly interactive but should not look like standard web hyperlinks.

Use subtle:

- underline
- medium weight
- tinted highlight

Only targeted vocabulary should be interactive.

==================================================
READING AUDIO PLAYER
==================================================

Create a compact local-audio player card.

Use:

Listen to Reading

Play / Pause

Restart

Progress bar

Current duration

Total duration

Use soft blue or soft teal surface.

Avoid elaborate waveform visualizations.

No streaming UI.

No internet indicators.

==================================================
GLOSSARY
==================================================

When an interactive word is tapped, open a bottom sheet.

Do NOT navigate to a separate page.

Bottom sheet content:

Handle

Word

Part of Speech

Pronunciation button

Indonesian meaning

Optional example only when content is available in source material

Use 24px top corner radius.

Use subtle backdrop.

==================================================
INTERACTIVE PRACTICE
==================================================

Create a reusable Practice shell.

Introduction:

Interactive Practice

Apply what you have learned.

3 activities

Maximum score: 30

Primary CTA:

Start Practice

Top progress during activity:

Activity 1 of 3

==================================================
MATCHING PRACTICE
==================================================

Design mobile-friendly matching.

Do not create two tiny narrow columns.

Use cards with clear selected/matched states.

Interaction should be understandable through either:

- drag
or
- tap-to-match concept

States:

idle
selected
matched
correct
incorrect

==================================================
DRAG AND DROP
==================================================

Draggable item:

- grip icon
- clear text
- subtle elevation while dragging

Drop zone:

- dashed border
- soft background
- highlighted drag-over state

Successful drop:

- snap animation
- success state
- check icon

==================================================
SEQUENCING
==================================================

Create reorderable list cards.

Each item:

drag handle
sequence number
text

While dragging:

slight elevation
1.02 scale

Use smooth reorder behavior.

==================================================
PRACTICE FEEDBACK
==================================================

Correct:

Green success icon

"Great job!"

"That's correct."

Continue

Incorrect:

Soft warning/error surface

"Not quite yet"

"Try reviewing the sentence again."

Try Again

Do not use harsh full-screen red failure feedback.

==================================================
POST-TEST INTRO
==================================================

Make this more achievement-oriented than Pre-test.

Title:

Post-test

Subtitle:

You're almost there!

Metadata:

10 questions
Maximum 70 points

CTA:

Start Post-test

==================================================
POST-TEST
==================================================

Reuse the exact Pre-test assessment component system.

Do NOT create a visually different quiz system.

Only labels and assessment context should change.

==================================================
FINAL RESULT
==================================================

This is a high-priority visual screen.

Use a polished result composition.

Hero area:

Circular score ring

Large final score

Status

Example:

83 / 100

Tuntas

Show breakdown clearly:

Pre-test /100

Post-test Raw /100

Post-test Weighted /70

Interactive Practice /30

Final Score /100

Learning Gain

Latest Score

Best Score

Primary CTA:

Review Material

Secondary CTA:

Try Again

Tertiary:

Back to Modules

==================================================
LEARNING GAIN
==================================================

Do NOT compare the weighted 70-point score to the Pre-test.

Use raw Post-test percentage for comparison as defined in PRD.md.

Example visual:

Pre-test
50

→

Post-test
80

+30 Improvement

Keep this visually clear.

==================================================
RESULT — TUNTAS
==================================================

Use:

success green accent

check icon

positive restrained message

Optional small one-time celebration.

Do NOT cover the entire screen with confetti.

==================================================
RESULT — PERLU REVIEW
==================================================

Do NOT show a red failure experience.

Use warm warning tone.

Example:

Keep Going

Perlu Review

Supporting copy encouraging review.

Primary CTA:

Review Material

==================================================
PROGRESS SCREEN
==================================================

Keep this educational, not analytical.

Header:

Your Progress

Overall:

2 of 3 Modules Completed

67%

Linear overall progress.

Then display three module progress cards.

Each may show:

module title
status
progress
latest/final score
best score where relevant
CTA

Avoid complex graphs.

Avoid dashboards with many charts.

==================================================
PETUNJUK / HOW TO USE
==================================================

Use numbered educational steps.

Suggested hierarchy:

How to Use the App

01 Choose a Module

02 Complete Pre-test

03 Study the Material

04 Explore Vocabulary & Audio

05 Complete Interactive Practice

06 Take Post-test

07 Check Your Progress

Each step should have:

number
icon
short description

==================================================
LEARNING OUTCOMES
==================================================

Create a clean modern academic layout.

Title:

Learning Outcomes

Metadata card:

Kurikulum Merdeka

Phase E

Grade X SMK

Reading–Viewing

Then structured competency cards.

Do not paste one large academic paragraph.

==================================================
PROFILE
==================================================

This is a Researcher / Developer information screen.

Use:

photo placeholder

name placeholder

Researcher / Developer

Information sections:

NIM
Program Studi
Fakultas
Universitas
Dosen Pembimbing
Judul Penelitian
Tahun

Do NOT design it like a social-media profile.

Data is currently pending.

Use clear neutral placeholders.

==================================================
PENDING DATA
==================================================

Some information is not final:

- application name
- application logo
- app icon
- researcher profile
- researcher photo
- final passing threshold if changed later
- final pronunciation accent
- final Pre-test question bank

Do not invent permanent final data.

Use well-structured placeholders where necessary.

Do NOT create fake academic Pre-test content and present it as final.

For UI demonstration, use neutral clearly temporary assessment placeholders.

==================================================
MOTION SYSTEM
==================================================

Motion should be restrained and purposeful.

PAGE TRANSITION

Forward:

slight slide from right
+
fade

220–280ms

Back:

reverse.

Do not use:

flip
spin
aggressive zoom

==================================================
SPLASH MOTION
==================================================

Logo:

fade in
+
scale 0.96 → 1.0

500–700ms

Keep minimal.

==================================================
CARD PRESS
==================================================

Scale:

1.00 → 0.98

100–150ms

==================================================
QUIZ OPTION
==================================================

Selected state:

border transition

soft background transition

selected icon/badge

150–180ms

==================================================
GLOSSARY
==================================================

Bottom sheet:

slide up
+
fade

250–300ms

==================================================
PROGRESS
==================================================

Animate progress from previous value.

400–600ms

Do not loop.

==================================================
RESULT
==================================================

Animate:

score ring
score count-up
status fade-in
breakdown reveal

700–900ms total feeling.

Optional tiny one-time completion particles.

Do not loop animation.

==================================================
ACCESSIBILITY
==================================================

Ensure:

- body text at least 15–16px
- reading text approximately 17px
- touch target minimum 44–48px
- sufficient contrast
- state is never communicated by color alone
- selected option has border/icon/text differences
- success/error includes icon and text
- content can scroll
- text wrapping works
- CTA is not clipped
- layout survives larger text sizes

==================================================
RESPONSIVE RULES
==================================================

At 360px:

- use 16px horizontal padding
- one-column layout
- full-width learning CTA
- do not force vocabulary into two columns

At 390–412px:

- use approximately 20px horizontal padding
- maintain one-column reading/learning layout
- Quick Access may use compact multi-column arrangement only if comfortable

Do not hard-code large fixed heights for text-heavy content.

==================================================
COMPONENT CONSISTENCY
==================================================

Create reusable components for:

App Bar

Bottom Navigation

Primary Button

Secondary Button

Text Button

Icon Button

Module Card

Continue Learning Card

Progress Card

Quick Access Card

Status Badge

Module Badge

Linear Progress

Circular Score

Objective Card

Learning Journey Stepper

Vocabulary Card

Audio Player Card

Interactive Glossary Word

Glossary Bottom Sheet

Quiz Option

Question Progress

Drag Item

Drop Zone

Sequence Item

Feedback Card

Result Metric Card

Information Banner

Warning Banner

Empty State

Error State

Confirmation Sheet

Use consistent variants rather than manually redesigning components on every screen.

==================================================
CRITICAL STATES
==================================================

Design visual variants for:

Home Fresh User

Home Returning User

Module Not Started

Module In Progress

Module Completed

Quiz Default

Quiz Selected

Practice Correct

Practice Incorrect

Audio Idle

Audio Playing

Audio Missing

Progress Empty

Result Tuntas

Result Perlu Review

Generic Error

==================================================
PROTOTYPE INTERACTIONS
==================================================

Create a working interactive prototype demonstrating the complete Module 01 journey.

Minimum prototype:

Splash
→ Home
→ Modules
→ Module 01
→ Module Overview
→ Learning Objectives
→ Pre-test Intro
→ Pre-test Question
→ Submit
→ Pre-test Result
→ Theory
→ Vocabulary
→ Reading
→ Tap Glossary Word
→ Glossary Bottom Sheet
→ Interactive Practice
→ Correct/Incorrect Feedback
→ Post-test Intro
→ Post-test Question
→ Submit
→ Final Result
→ Progress

Additionally:

Home
→ Petunjuk

Home
→ Learning Outcomes

Home
→ Profile

Bottom navigation must work between:

Home
Modules
Progress

==================================================
CONTENT BEHAVIOR
==================================================

Use the real module names defined in PRD.md.

Do not rewrite academic content.

Do not invent final Pre-test questions.

Do not alter answer logic.

Do not alter scoring.

Do not create hidden online functionality.

==================================================
LOCAL/OFFLINE CONTEXT
==================================================

The real product will be offline-first.

The prototype may use mock/local interaction state only.

Do not add:

network loading
cloud synchronization
account status
online/offline account badges
server errors
upload indicators

Core learning experience should visually feel independent of connectivity.

==================================================
DO NOT CREATE
==================================================

Absolutely do not introduce:

Login

Register

Authentication

Student Account

Teacher Account

Teacher Dashboard

Classroom

Class Code

Join Class

Online Database

Firebase

Supabase

REST API UI

Web Admin

CMS

Cloud Sync

Leaderboard

Ranking

Chat

Forum

AI Tutor

Subscription

Payments

Advertising

Social Feed

Daily Streak

Heavy gamification

These are outside current project scope.

==================================================
DO NOT USE THESE VISUAL PATTERNS
==================================================

Do not use:

heavy glassmorphism

neon colors

rainbow gradients

gaming HUD

oversized glowing buttons

3D glossy cards

cartoon school children

emoji as interface icons

huge floating decorative shapes

looping animated backgrounds

automatic carousel

more than three bottom-navigation items

desktop dashboard pattern

e-commerce product card pattern

excessive charts

excessive rounded pill elements

random gradients

random radius values

inconsistent icon families

==================================================
QUALITY STANDARD
==================================================

The generated result must feel like a high-fidelity portfolio-quality mobile education application.

Do not stop at a generic wireframe.

Use realistic spacing.

Use polished visual hierarchy.

Use proper component states.

Use meaningful empty/error states.

Use a consistent design system.

Ensure repeated screens visibly belong to the same product.

The application should look credible enough to be:

- presented to a thesis examiner
- demonstrated to teachers
- tested by students
- handed off to a Flutter developer
- used as a professional portfolio project

==================================================
IMPLEMENTATION / DESIGN STRUCTURE
==================================================

Organize the generated interface consistently.

Where possible, internally structure reusable components and tokens instead of duplicating styling.

Do not hard-code inconsistent colors and sizes across screens.

Use responsive layout rather than absolute positioning for text-heavy areas.

==================================================
EXECUTION ORDER
==================================================

Work in this sequence:

PHASE 1
Read PRD.md and DESIGN.md completely.

PHASE 2
Establish visual foundations:
colors
typography
spacing
radius
icons
component hierarchy.

PHASE 3
Build reusable components.

PHASE 4
Build the core navigation:
Splash
Home
Modules
Progress.

PHASE 5
Build one complete Module 01 learning journey.

PHASE 6
Ensure the same learning templates can represent Module 02 and Module 03 without redesigning the whole interface.

PHASE 7
Build support pages:
Petunjuk
Learning Outcomes
Profile.

PHASE 8
Build required state variants.

PHASE 9
Connect prototype interactions.

PHASE 10
Perform a final consistency audit.

==================================================
FINAL SELF-AUDIT
==================================================

Before considering the work complete, check:

1. Did you read PRD.md and DESIGN.md?

2. Are there exactly three main bottom-navigation items?

3. Is the application mobile-first?

4. Is the dominant color blue?

5. Are module colors only subtle accents?

6. Is reading text highly readable?

7. Are Pre-test and Post-test visually consistent?

8. Is the Glossary implemented as a bottom sheet?

9. Are audio controls clear?

10. Are practice interactions understandable on a phone?

11. Are progress states clear?

12. Is Final Result visually polished?

13. Does the result correctly distinguish:
    Pre-test /100,
    Post-test raw /100,
    Post-test weighted /70,
    Practice /30,
    Final /100?

14. Is there any invented login/backend/classroom functionality?
    If yes, remove it.

15. Did you invent academic content?
    If yes, replace it with clearly temporary placeholder content.

16. Does the interface look childish?
    If yes, refine it toward a modern teenage/young-adult educational aesthetic.

17. Is there excessive gradient, glassmorphism, animation, or visual clutter?
    If yes, simplify it.

18. Can a Flutter developer understand and implement the layout consistently?

19. Does the full journey feel like one coherent application?

20. Is the result presentation-ready?

Only after completing this audit should the initial UI/UX generation be considered complete.