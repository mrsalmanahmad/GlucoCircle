# GlucoCircle wireframes

These are the designs we build from. Every screen has an image to compare against and a source file with its exact sizes, colours, copy and logic.

**The wireframes were drawn before the product changed.** GlucoCircle is now a community with general information only. It does not track or advise. So we follow their look and feel, but not all their content. Where this page and a wireframe disagree, this page wins. See [`../MVP_PLAN.md`](../MVP_PLAN.md) for the product rules.

| Path | What it is | Use it for |
|---|---|---|
| `GlucoCircle-wireframes.html` | The original interactive prototype, all 17 screens on one page. Open it in a browser. | Clicking through flows and states |
| `screens/*.png` | Image of each screen at 390 pt wide (2x). `--name` files show hidden states. | Comparing side by side with the Flutter screen |
| `source/*.html` | Readable markup and logic for each screen. Not runnable. | Exact values, copy, SVG icon paths |

**How to read the frames.** The frames are 390 wide. Tall frames are scrolling screens: the bottom nav stays fixed and the content scrolls. In Flutter, use spacing and sizes from the source, but always build with `SafeArea` and scrolling instead of fixed heights.

**Bottom nav.** The images show 5 tabs including Home. We build 4: **Community, Share, Signs, Healthy**. Community opens first.

## Screen index

| # | Screen | Image | Route | Release |
|---|---|---|---|---|
| 02 | Community | [png](screens/02-community.png) | `/community` | v1.0 |
| 03 | Share your experience | [png](screens/03-share-experience.png) | `/share` | v1.0 |
| 04 | Know the signs | [png](screens/04-know-the-signs.png) | `/signs` | v1.0, reworked |
| 05 | Stay healthy | [png](screens/05-stay-healthy.png) | `/healthy` | v1.0, reworked |
| 06 | Onboarding | [png](screens/06-onboarding-who-are-you.png) | `/onboarding` | v1.0, reworked |
| 08 | Report a post | [png](screens/08-report-post.png), [sent](screens/08-report-post--sent.png) | sheet | v1.0 |
| 09 | Fireflies, night sky | [png](screens/09-fireflies-night-sky.png) | `/fireflies` | v1.0 Lite |
| 10 | Light your glow | [png](screens/10-light-your-glow.png) | `/fireflies/glow` | v1.0 Lite |
| 11 | Safety check | [png](screens/11-safety-check.png) | `/fireflies/caution` | v1.0, **replaced** |
| 12 | Quiet glow | [png](screens/12-quiet-glow.png) | `/fireflies/quiet` | v1.0 Lite |
| 14 | Talking now (1-to-1) | [png](screens/14-talking-now.png) | `/fireflies/chat` | v1.1 |
| 15 | Breathe together | [png](screens/15-breathe-together.png) | `/fireflies/breathe` | v1.1 |
| 16 | Soft goodbye + lantern | [png](screens/16-soft-goodbye-lantern.png) | `/fireflies/goodbye` | v1.1, reworked |
| 17 | The morning after | [png](screens/17-morning-after.png) | Community card | v1.1, reworked |
| 13 | Constellation (group) | [png](screens/13-constellation.png) | `/fireflies/group` | v1.2 |
| 01 | Home & reminders | [png](screens/01-home-reminders.png) | - | **Not building** |
| 07 | Glucose log & chart | [png](screens/07-glucose-log.png), [add reading](screens/07-glucose-log--add-reading-sheet.png) | - | **Not building** |

The state images `04-know-the-signs--*` and `11-safety-check--*` show behaviour we are removing. They stay only as a record.

## What to change on each screen

### v1.0

| Screen | Keep | Change or remove |
|---|---|---|
| **02 Community** | Everything | Add a small caution line. Header gets settings and bell. Hide search. Use one list of 7 topics plus All, matching Share. |
| **03 Share** | Everything. Its footer message already says the right thing. | Nothing |
| **04 Signs** | Signs list, Know your numbers table, Get help card, Find a test | **Remove checkboxes and the "2 SIGNS NOTICED" result.** The list is read-only. See exact text below. Name the source of the numbers. |
| **05 Healthy** | Healthy plate, risk list, Get checked card | **Remove Today's goals and the "Set a yearly test reminder" button.** Remove the chevrons on the risk list. Add the caution. |
| **06 Onboarding** | Layout, title, selectable cards | Remove "Step 1 of 3" and the progress bar. Add Skip. Options become topics, not diagnoses. See exact text below. |
| **08 Report** | Everything, both states | Also use it for replies and glows. Add Block. |
| **09 Night sky** | Sky, filters, person card, Send warmth, Light my glow | Remove Talk, constellation and sunrise. Remove the diabetes type and years. Show nickname and country only. Add a `...` menu for report and block. Real counts only. |
| **10 Light your glow** | Feeling, one line, duration | Remove "How do you want to connect?" and "Match me with". Remove "chats disappear" from the footer. |
| **11 Safety check** | Night style | **Replaced by a caution step.** No blood sugar entry, no treatment steps, no emergency contact. See exact text below. |
| **12 Quiet glow** | Everything else | Remove "I'm open to talk". "Dim my glow" returns to Community. Remove "Been there · 12 years". |

### New text

**04 Signs**
- Title: "Signs of diabetes" (not "Could it be diabetes?")
- Under the title: "Common signs to know about. Only a blood test can tell."
- Fixed card, always shown: "Noticed any of these? Consult a doctor. They can arrange a fasting glucose or HbA1c test."

**06 Onboarding**
- Under the title: "We'll show you the stories and topics that fit. Pick any, or skip."
- Store the answers as `interests`, used only to pre-select feed filters.

| Option | Note |
|---|---|
| Type 1 diabetes | Stories and daily life |
| Type 2 diabetes | Food, activity, daily life |
| Prediabetes | What others have tried |
| Diabetes in pregnancy | Gestational diabetes support |
| Caring for someone | Parent, child or partner |
| Staying healthy | Know the signs |

**11 Caution step** (shown only when the feeling is "After a low" or "Sugar is high")
- Title: "First, take care of yourself"
- Body: "GlucoCircle can't check or treat this. Follow the plan your doctor gave you. If you feel very unwell, get help now."
- Red button: "Call emergency 1122"
- Yellow button: "I'm okay, continue"

### Later releases

| Screen | Change |
|---|---|
| **14, 15, 13** | Build as designed, plus report and block in chat. Rewrite any medical sample text. |
| **16 Soft goodbye** | "Still low" must show the caution step, not "rest well". Replace the lantern idea "Hope your morning reading is kind to you". |
| **17 Morning after** | Keep only the lantern card and Firefly friends. **Remove the fasting sugar entry, "rebound" text, night journal and snack tip.** It becomes a card on Community. |

## Navigation

```
Sign-in ──► Onboarding ──► Community
Community ──► Post detail ──► Report sheet
Community ──► Fireflies ──► Light your glow ──► Caution step ──► Quiet glow
                                 (only if the feeling is "After a low" or "Sugar is high")

Later:
Fireflies ──► Talking now ──► Breathe together ──► back to chat
                   └────────► Soft goodbye
Fireflies ──► Constellation
```

## Design tokens

Put these in `lib/core/theme/` and never hard-code colours or sizes in a screen. The app has two moods in v1.0: **Day** (community and info) and **Night** (Fireflies).

### Colours: Day

| Token | Hex | Use |
|---|---|---|
| `primary` | `#1E4FD8` | Buttons, active tab |
| `primaryDark` | `#163BA6` | Pressed state of links (hover colour in the prototype) |
| `ink` | `#0F1A2E` | Titles, selected chips |
| `textBody` | `#34405A` | Chip and button text |
| `textMuted` | `#4F5B6E` | Secondary text |
| `textFaint` | `#5B6576` | Inactive tabs |
| `background` | `#F4F6FA` | Screen background |
| `surface` | `#FFFFFF` | Cards |
| `border` | `#E3E8F0` | Card and chip borders |
| `borderStrong` | `#CBD3E1` | Inputs, sheet handle |
| `control` | `#B8C2D3` | Empty controls, toggle off |
| `selected` | `#F3F6FE` / `#E8EEFD` | Selected row / selected tile |
| `successText` on `successBg` | `#166534` on `#E8F5EC` | Report sent check |
| `warnText` on `warnBg` | `#8A3D05` on `#FFF4E5` | Notice cards |
| `danger` | `#B42318` | Report and emergency buttons |
| `dangerText` on `dangerBg` | `#8F1B12` on `#FDECEC` | Help cards |

Mood dots: Good `#22C55E`, Okay `#3B82F6`, Low `#F59E0B`, Struggling `#8B5CF6`. Plate: `#22A55B`, `#E07B39`, `#C9A227`.

### Colours: Night

| Token | Hex | Use |
|---|---|---|
| `nightBg` | `#0B1026` | Screen background |
| `nightSurface` | `#151C3B` | Inputs, cards, unselected chips |
| `nightHorizon` | `#121A3D` (top border `#2A3570`) | Curved horizon on the sky |
| `nightBubble` | `#1C2449` | Other person's chat bubble |
| `nightBorder` | `#323C6E` | Input and chip borders |
| `nightDivider` | `#262F57` | Dividers |
| `glow` | `#FFC857` | Fireflies, selected chips, main button |
| `glowLight` | `#FFD98A` | Highlight text |
| `onGlow` | `#1A1300` | Text on `glow` |
| `cream` | `#F3F1EA` | Main text, person card background |
| `nightSub` | `#C9CDE3` | Body text |
| `nightMuted` | `#A9B0CF` | Secondary text |
| `nightHint` | `#8E97C4` | Placeholders, stars |
| `cardInk` | `#141833` | Text on the cream card |

Glow shadow: `0 0 14px 5px rgba(255,200,87,.55)` plus `0 0 36px 12px rgba(255,170,60,.18)`.

### Colours: Morning (v1.1)

Background `#FBF6EC`, ink `#1B1A2E`, muted `#5E5A4E`, border `#ECE3D1`.

### Type

Bundle the fonts as app assets, so no network is needed. Both use the SIL Open Font License, so keep the licence text in the app.

- **Plus Jakarta Sans** (400, 500, 600, 700, 800): all interface text.
- **Fraunces** (500, 600, italic 500): Night and Morning headings and quotes only. Never in the Day screens.

| Style | Font | Size / weight | Example |
|---|---|---|---|
| Night title | Fraunces | 34 / 600 | "Fireflies" |
| Night heading | Fraunces | 30 / 600 | "Light your glow" |
| Page title | Jakarta | 26 / 800, letter-spacing -0.02em | "Community" |
| Sheet title | Jakarta | 20 / 800 | "Report this post" |
| Button | Jakarta | 16 / 700-800 | "Continue" |
| Quote | Fraunces italic | 16-17 / 500 | Glow text |
| Body | Jakarta | 14-15 / 400-500 | |
| Chip | Jakarta | 13 / 600 | |
| Tab label, small text | Jakarta | 12 / 600-700 | |

### Components

| Component | Height | Radius | Notes |
|---|---|---|---|
| Primary button (Day) | 54 | 16 | Full width, `primary` |
| Primary button (Night) | 56 | 28 | `glow` with `onGlow` text |
| Floating button | 52 | 26 | 20 from the right, shadow `0 8px 20px rgba(30,79,216,.3)` |
| Card | - | 20 | White, 1 px `border`, padding 16 |
| Bottom sheet | - | 28 on top | Handle 40 x 5, padding 12 / 20 / 32 |
| Filter chip | 36 | 18 | Padding 14 horizontal |
| Round icon button | 44 | 22 | 1 px `border` |
| Bottom nav | 80 | - | Min target 64 x 52, top border `border` |
| Toggle | 26 | 13 | 44 wide, knob 20 |

Screen side padding is 20. Tap targets are at least 44. Icons are rounded line icons with stroke 2 to 2.2. The exact SVG paths are in `source/`.

### Motion

From the prototype CSS. Turn all of it off when the system asks for reduced motion.

| Name | Effect | Timing |
|---|---|---|
| Firefly pulse | Scale 1 to 1.4, opacity .85 to 1 | 3.2 s loop, ease in-out, staggered 0.45 s per firefly |
| Sky drift | Move 6 px left and right | 24 s, alternating |
| Card pop | Rise 16 px and fade in | 0.35 s, ease out |

On the sky, brightness shows waiting time: size is `min(20, 8 + waitedMinutes / 4)` and opacity is `0.55 + min(waitedMinutes, 50) / 110`.

## Rules from the prototype to keep

- **Caution step trigger (screen 10):** runs only if the feeling is "After a low" or "Sugar is high".
- **Glow text limit:** one line is 140 characters.
- **Lantern (v1.1):** 120 characters. "Done · rest well" becomes "Leave lantern & rest" once text is entered.
- **Breathing (v1.1):** 4 s in, 4 s out, 6 rounds.

## Known issues to fix while building

### Safety: fix these first

| ID | Screen | Problem | What to build |
|---|---|---|---|
| S1 | 04 | Tapping symptoms and getting a score ("3 SIGNS NOTICED, please see a doctor soon") works as a symptom checker. Google lists symptom checkers as a health feature, and Apple gives apps usable for diagnosis greater scrutiny. | Read-only list with one fixed card (see New text). |
| S2 | 11 | It takes a blood sugar number and answers "you're back in a safe range", even for 450, and gives treatment steps. | Replace with the caution step. The app never judges a number. |
| S3 | 16 | Choosing "Still low" ends with "Done · rest well". (v1.1) | Show the caution step. |
| S4 | 14 | The flag icon is labelled "Report or block", but no screen has a Block control. Apple requires one. | Add Block to the `...` menu on posts and replies, to the person card, and in chat. |
| S5 | 09 | The count is fake: `30 + visible.length * 4`. All people on the sky are sample data. | Show real counts only. Never show invented people. Build an honest empty sky. |
| S6 | 09, 12 | Name, city, local time, language, diabetes type and years together can identify someone, next to very private text. | Show a first name or nickname, plus country. Nothing else. |

### Placeholders to fill

| Screen | Text | Value |
|---|---|---|
| 04 | `[LOCAL NUMBER]` | 1122 for Pakistan. Confirm coverage before launch. |
| 08 | `[REVIEW TIME]` | 24 hours |

### Not real design: ignore these

These come from how the prototype renders, not from the design.

- **16:** the lantern box shows `[object Object]`. The real empty state is the placeholder "Something kind for her morning…"
- **10:** the bottom button looks squashed because the frame is too short. Real size is 56 high, radius 28.
- **14:** the disclaimer is hidden behind the buttons. The full text is "Share feelings, not medical advice. If your sugar is very low or high, follow your plan or get help now."
- **04:** an 8th sign is cut off by the frame: "Tingling hands or feet / Numbness or pins and needles".
- **17:** "Firefly friends" is cut off. It lists "Maria, Asleep · Lisbon" and "Rahim, Glowing now · Dhaka".
