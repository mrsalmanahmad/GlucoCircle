# GlucoCircle: MVP plan

**What it is:** a community for people affected by diabetes, plus general health information. It does not track, treat, diagnose or advise anyone. Every medical topic says: consult your doctor.

**Target:** code complete in 15 working days (Wed 18 November 2026), live on **Google Play and the App Store together between 30 November and 3 December 2026**.

This assumes a start on Monday 2 November 2026, one developer working full time (6 days a week) who already knows Flutter, using Claude Code. Part time, or new to Flutter, means roughly 1.5 to 2 times longer.

Designs and screen-by-screen changes are in [`wireframes/README.md`](wireframes/README.md).

## Product rules

Every feature must pass these. If it fails one, it doesn't go in the app.

1. **No personal health tracking.** No blood sugar logs, medicine or test reminders, targets or goals.
2. **No personal results.** The app never takes a person's symptoms or numbers and gives an answer back. Information is the same for everyone.
3. **General information only, with a named source**, such as the American Diabetes Association or WHO, and checked by a doctor.
4. **Always point to a doctor.** The caution below appears everywhere medical topics do.
5. **No medical promises in the store listing.** Never say "manage", "track", "control" or "improve" your diabetes.

### Standard caution text

Use one shared widget, so the wording stays the same everywhere.

> General information and members' own experiences, not medical advice. Always consult your doctor.

**Where it appears:** sign-up consent, the Community feed, post detail, Signs, Healthy, Light your glow.

**In the store description**, use the sentence Google requires:

> GlucoCircle is not a medical device and does not diagnose, treat, cure, or prevent any medical condition. Always consult a healthcare professional for medical advice, diagnosis, or treatment.

## What the caution does not solve

Being info-only lowers the risk, but these still apply.

| Rule | What it means for us |
|---|---|
| **Google still treats this as health-related.** Its policy covers apps with "health-related features or information", and every app must complete the Health apps declaration. | We can choose the **Social** category, but we don't select "no health features". The likely answer is "Medical Reference and Education". The form also mentions "patient communities", so read its definitions when filling it in and answer truthfully. |
| **Members can still post dangerous advice.** Google bans harmful health claims. Apple requires filtering, reporting, blocking and published contact details for all user content. | Moderation is now the main safety work. It can't be dropped. |
| **Posts reveal health status.** | Treat the data as sensitive, even with no tracker. |
| **Google's 14-day test is unchanged.** Personal accounts created after 13 November 2023 need 12 testers opted in for 14 days in a row. Production review then "usually takes seven days or less". | Removing features finishes the code sooner, but doesn't remove this wait. We start the clock on Day 5. **If your account is older or an organisation account, you skip the test** and could launch around 18 to 25 November. |
| **Apple's rule for health apps.** Guideline 5.1.1(ix) says apps in healthcare, or that need sensitive information, "should be submitted by a legal entity". | Lower risk now that we offer no health service and don't require health details, but not zero. We submit on an individual account (or your company's, if you have one). If Apple rejects it on this rule, Android launches on time and you register a company for iOS. |

## Decisions

These are made so that work can start now. Change any of them before Day 1 if they are wrong.

| Topic | Decision | Why |
|---|---|---|
| Store category | Social (Google Play), Social Networking (App Store) | Matches what the app now is |
| Platforms | **Android and iOS together** | Your decision. Same code and same launch date. Android sets the date because of its 14-day test. |
| First country | Pakistan only | One language, one emergency number, one legal system, and people in one place. The wireframes are set in Lahore. |
| Scope | 10 of the 17 wireframes, reworked | See below |
| Fireflies in v1.0 | **Lite: quiet glow and warmth, no chat** | It is community, not medical, and it is what makes this app different. Lite tests whether people come at night, without the risk of live chat. |
| Backend | Firebase (Auth, Firestore, Functions, Messaging, Crashlytics, Hosting) | No server to run, and data can expire on its own for glows |
| App architecture | Riverpod, go_router, feature folders | Common and fast to build with |
| Sign-in | Google, Sign in with Apple, plus email and password | Apple guideline 4.8 needs a privacy-friendly option if we offer Google. Reviewers need the email test login. |
| Age | 18+ only | Strangers and night-time use |
| Language | English first, Urdu in v1.1 | All text goes in translation files from Day 2, because adding that later is painful |
| Moderation | You are the moderator, checking twice a day, with a 24-hour promise | Apple and Google both expect real moderation |

## What is in each release

| Release | Contents | Wireframes |
|---|---|---|
| **v1.0 MVP** | Community feed, posting, replies, report and block, Signs and Healthy info pages, Fireflies Lite | 02, 03, 04, 05, 06, 08, 09, 10, 11, 12 (reworked) |
| **v1.1 Talk** | Urdu, 1-to-1 text chat, Breathe together, Soft goodbye, lanterns, AI safety filter for chat | 14, 15, 16, part of 17 |
| **v1.2 Together** | Group constellations, voice notes, auto-translation, firefly friends, more countries | 13, rest of 17 |

**Removed for good:** glucose log and chart, targets, doctor PDF, medicine and test reminders, daily goals, the symptom score on Signs, blood sugar checks in Fireflies, emergency contact, night journal. This removes wireframes 01 and 07 completely.

**Cut from v1.0 for time:** chat, voice notes, translation, matching toggles, sunrise countdown, community search.

## What the wireframes do not include

These are required for launch but have no design. Build them from the existing components and don't run a new design round. They are included in the schedule below.

| Missing | Why it is needed |
|---|---|
| Welcome and sign-in, 18+ and consent | No account screens exist |
| Settings and profile | No link exists, and Home is gone. Add it to the Community header. Holds **delete account**, which both stores require. |
| Post detail and replies | "18 replies" goes nowhere |
| Block user and block list | Required by Apple guideline 1.2, and the prototype has no control for it |
| Notification inbox | The bell goes nowhere. Moves to the Community header. |
| Empty, loading, offline and error states | Includes an honest empty night sky and an empty feed |
| Moderation tool | Firestore console plus an email alert. No custom admin app. |
| Web pages: account deletion, privacy policy, terms | Required for the store listing. Hosted free on Firebase. |

## Schedule

### Phase 0: Foundation (Days 1-2)

**Day 1, Mon 2 Nov: accounts and project**
- [ ] Create the Google Play Console account **first thing**. Identity checks can take days.
- [ ] Enrol in the Apple Developer Program ($99 a year). This can also take days.
- [ ] Start recruiting **20 testers** (12 are required, extra covers dropouts), and ask who has an iPhone. They also become your first community members.
- [ ] Check that the name "GlucoCircle" is free on both stores and as a domain, then buy the domain.
- [x] Create the Flutter project for Android and iOS with app ID `com.glucocircle.app`. This cannot change after publishing, so confirm you are happy with it before the first upload.
- [ ] Create the Firebase project in region `asia-south1`. This also cannot change. Turn on the Blaze plan with a budget alert.

**Day 2, Tue 3 Nov: design system**
- [x] Add design tokens from the wireframes README. Bundle the fonts and set up translation files.
- [x] Build shared widgets: buttons, cards, chips, toggle, bottom sheet, caution text, firefly glow. (List rows come with the first screen that needs them.)
- [x] Set up the 4 tabs (Community, Share, Signs, Healthy) with placeholder screens.

**Done when:** the app runs on a real Android phone and iPhone with 4 tabs and correct fonts and colours. So far it has run on the emulator and simulator.

### Phase 1: First release to testers (Days 3-5)

**Day 3, Wed 4 Nov: sign-in and onboarding** (screen 06)
- [ ] Sign-in with Google, Apple and email, 18+ check, terms and caution consent.
- [ ] Reworded onboarding: optional topic picker that can be skipped.

**Day 4, Thu 5 Nov: info pages and settings** (screens 04, 05)
- [ ] Signs and Healthy as read-only pages, with sources and the caution.
- [ ] Emergency call button and maps search.
- [ ] Settings with delete account, plus the web deletion page.

**Day 5, Fri 6 Nov: upload**
- [ ] Firestore security rules. Privacy policy and terms published.
- [ ] Store listing, Data Safety form, Health apps declaration, content rating.
- [ ] Upload to Google's closed testing track. **This starts the path to the 14-day clock.**
- [ ] Upload to TestFlight for iPhone testers. Apple has no 14-day rule, so this doesn't affect the date.

**Done when:** testers can install the app, sign in and read the info pages. Allow about 2 days for Google's first review, so all testers should be opted in by **Mon 9 Nov**.

### Phase 2: Community (Days 6-9)

**Day 6, Sat 7 Nov: feed** (screen 02)
- [ ] Feed, topic filters, "I relate", caution line.

**Day 7, Mon 9 Nov: posting** (screen 03)
- [ ] Composer with mood, topic and anonymous option.
- [ ] `createPost` Cloud Function with word filter (see Safety below).

**Day 8, Tue 10 Nov: replies and inbox**
- [ ] Post detail and replies.
- [ ] Push notifications on both platforms (iOS needs an Apple push key) and bell inbox.

**Day 9, Wed 11 Nov: report and block** (screen 08)
- [ ] Report sheet with sent state, on posts and replies.
- [ ] Block user, block list.
- [ ] Hide reported "dangerous advice" until reviewed, and email the moderator.
- [ ] Send build 2 to testers.

**Done when:** testers can post, reply, report and block, and you receive and can act on a report.

### Phase 3: Fireflies Lite (Days 10-12)

**Day 10, Thu 12 Nov: night sky** (screen 09)
- [ ] Sky with real glows only, animations, person card, feeling filters.
- [ ] Honest empty sky state, for example "You're the first firefly tonight."

**Day 11, Fri 13 Nov: lighting a glow** (screens 10, 11)
- [ ] Light your glow: feeling, one line, duration.
- [ ] Caution step that replaces the safety check. No blood sugar entry.
- [ ] `createGlow` function with the same word filter. Glows expire on their own.

**Day 12, Sat 14 Nov: warmth** (screen 12)
- [ ] Quiet glow screen, Send warmth, Glow back, push notification.
- [ ] Report and block on the person card. Community banner.
- [ ] Send build 3 to testers.

**Done when:** two phones can see each other's glow and exchange warmth, and glows disappear on time.

### Phase 4: Hardening (Days 13-15)

**Day 13, Mon 16 Nov: polish**
- [ ] Empty, loading, offline and error states on every screen.
- [ ] Compare every screen side by side with its wireframe.
- [ ] Large text, screen reader labels, reduced motion.

**Day 14, Tue 17 Nov: testing and freeze**
- [ ] Security rules tests in the Firebase emulator (see Safety below). Tests for the word filter.
- [ ] Test on cheap Android phones and an older iPhone. Fix tester bugs.
- [ ] **A doctor checks the Signs and Healthy pages.** Book this in the first week.
- [ ] Send build 4. Feature freeze.

**Day 15, Wed 18 Nov: store submissions**
- [ ] Screenshots and final listings for both stores. Apple privacy labels.
- [ ] Submit to the App Store with **manual release**, so it can wait for Android.

### Phase 5: Launch (19 Nov to 3 Dec)

| When | What |
|---|---|
| 19-22 Nov | Fix bugs. Answer any Apple review questions. Keep testers posting and replying, and write welcome posts together. Google asks how the test went, so keep notes. |
| **Mon 23 Nov** | Earliest date the 14 days are complete, if all testers joined by 9 Nov. **Apply for Google production access.** |
| By about Mon 30 Nov | Google's answer (usually 7 days or less, can be longer) |
| **30 Nov-3 Dec** | Release in Pakistan on both stores on the same day. Staged rollout: start at 20% and go to 100% after 2 calm days. |
| Launch week | Invite people from diabetes groups and clinics. Check reports twice a day. Reply to every early post. |

This waiting time is also the project's only buffer. If coding slips by a few days, the launch date does not move.

**If you run late, cut in this order:**
1. Bell inbox (keep push only)
2. Fireflies Lite (moves to the next update, and the app still launches)

**Never cut:** report and block, word filter, delete account, the caution text, doctor check of the info pages.

## Safety and privacy

**Information**
- Never give dosing advice, and never diagnose.
- Each info page names its source. A doctor checks them before launch.
- Keep the emergency number (1122) on Signs and on the Fireflies caution step. Confirm its coverage before launch.
- Fix issues S1 to S6 in the [wireframes README](wireframes/README.md#safety-fix-these-first).

**Anonymous posting must be truly anonymous**
- Never store `authorId` on a public post document when it is anonymous. Any user could read it with a modified app.
- Posts and glows are written only through Cloud Functions. Any private author link goes in a document only the moderator can read.

**Security rules, each with a test**
- Interests, inbox and settings: only the owner can read or write.
- Reports: users can create them, but nobody can read them except moderators.
- Blocked people cannot see each other's posts or glows.

**Content filter**
- Server-side word list in English and Roman Urdu: stop or skip insulin, "cure", herbal sales, phone numbers, links, WhatsApp.
- A match is held for review and not published.
- Apple 1.2 requires filtering, reporting with timely response, blocking and published contact details.

**Community rules**
- Show short rules at sign-up: share experiences, never tell anyone to change their medicine, no selling.
- The Share screen already has this message. Keep it.

**Data**
- No post text or interests in analytics or crash logs.
- No ads and no sale of data.
- Deleting an account deletes the person's data, from the app or the web page.

**Technical detail that is easy to miss**
- Firestore auto-delete (TTL) typically runs within 24 hours after expiry, and expired documents still appear in queries until then. Always filter by `expiresAt > now`, or faded glows will stay on the sky.

## Code structure

```
lib/
  app/            routes, app start
  core/           theme tokens, shared widgets, caution text, translations
  features/
    auth/  onboarding/  community/  signs/
    healthy/  fireflies/  settings/
functions/        createPost, createGlow, reports, notifications
docs/             this plan and the wireframes
```

## Data model

```
users/{uid}              name, nickname, interests (optional), consent dates
users/{uid}/inbox        type, text, createdAt
users/{uid}/blocks/{uid}
posts/{id}               name (or null if anonymous), mood, topic, text, counts, status
posts/{id}/replies       same pattern as posts
posts/{id}/relates/{uid}
reports/{id}             targetType, targetId, reason, status
glows/{id}               nickname, country, feeling, line, expiresAt
glows/{id}/warmth/{uid}  createdAt
moderation/{targetId}    authorUid (private)
```

There is no health data collection. The Signs and Healthy pages are stored inside the app.

## Costs to launch

| Item | Cost |
|---|---|
| Google Play account | $25 once |
| Apple Developer | $99 a year |
| Domain | About $10-15 a year |
| Firebase | Should be close to $0 at this size, with a budget alert set |
| Doctor's check | Your arrangement |

## Biggest risks

| Risk | What we do |
|---|---|
| **Empty community.** A community app is worthless with no people, and this is now the whole product. | Testers become first members. Write welcome posts before launch. Invite diabetes groups and clinics. Never use fake users or fake counts. |
| **No daily reason to open the app.** Removing the tracker removes the daily habit. | Reply and warmth notifications bring people back. Measure this first (see below). |
| **Harmful advice in posts** | Word filter, auto-hide on "dangerous advice" reports, caution text, community rules |
| **People expect medical help in an emergency** | Caution text and emergency number on Signs and the Fireflies caution step |
| **Moderation takes more time than expected** | Word filter first, small first country, twice-daily checks |
| **Play production access refused** | Recruit 20 engaged testers, push updates during the test, keep notes |
| **Apple rejects an individual account** | Android launches on time. Register a company, then resubmit. |
| **This Mac has an Intel chip.** Flutter warns that a future version will need Apple Silicon to build apps. | Stay on the current Flutter version through launch. Plan for an Apple Silicon Mac or a cloud build service for iOS later. |

## After launch: should we build chat?

Build v1.1 chat only when all of these are true for 2 weeks in a row. These are starting numbers, so adjust them once you see real data.

- [ ] At least **30%** of new users post, reply or relate in week one
- [ ] At least **20%** of new users come back in week two
- [ ] At least **10 real glows per night** on average
- [ ] Every report answered within **24 hours**

Rough size: v1.1 is 3 to 4 weeks and v1.2 is 3 to 4 weeks.

If people aren't glowing at night, improve the community first. Don't build chat for an empty sky.

## Launch checklist

**Store**
- [ ] 12+ testers opted in for 14 continuous days (if your account requires it)
- [ ] Google production access granted
- [ ] App Store review passed, held for manual release
- [ ] Category set to Social on Google Play, Social Networking on the App Store
- [ ] Data Safety form, Health apps declaration and Apple privacy labels answered truthfully
- [ ] Required "not a medical device" sentence in the description
- [ ] No "manage", "track" or "control" claims in the listing or screenshots
- [ ] Test login given to reviewers
- [ ] Available in Pakistan only

**Product**
- [ ] Every v1.0 screen compared with its wireframe
- [ ] Issues S1 to S6 closed
- [ ] Caution text on every required screen
- [ ] `[LOCAL NUMBER]` and `[REVIEW TIME]` replaced
- [ ] Delete account works, in the app and on the web
- [ ] Contact details visible in the app

**People**
- [ ] Doctor has checked the info pages
- [ ] Privacy policy and terms reviewed by a local lawyer if possible
- [ ] Moderator rota set
- [ ] Welcome posts written

## Sources

Checked on 1 November 2026. Store rules change, so check them again before submitting.

- [Google Play: testing requirements for new personal developer accounts](https://support.google.com/googleplay/android-developer/answer/14151465?hl=en-GB)
- [Google Play: Health apps declaration](https://support.google.com/googleplay/android-developer/answer/14738291)
- [Google Play: health and medical apps policy](https://support.google.com/googleplay/android-developer/answer/16679511?hl=en)
- [Google Play: account deletion requirements](https://support.google.com/googleplay/android-developer/answer/13327111)
- [Apple: App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/) (1.2, 1.4.1, 4.8, 5.1.1)
- [Firebase: Firestore TTL policies](https://firebase.google.com/docs/firestore/ttl)
