# GlucoCircle

Flutter community app for people affected by diabetes, with general health information. Android and iOS launch together, on Firebase.

**This is not a patient-care app.** No health tracking, reminders, targets or personal results. Never add a feature that takes a person's symptoms or numbers and gives an answer back. Medical topics always carry the shared "consult your doctor" caution.

- **Plan and scope:** `docs/MVP_PLAN.md`. Only build what is in the current release.
- **Designs:** `docs/wireframes/README.md`. Before building a screen, open its image in `docs/wireframes/screens/` and its source in `docs/wireframes/source/` for exact sizes and colours.
- **The wireframes are older than the product decision.** The README says what to change on each screen, and it wins over the wireframe. It also lists safety fixes (S1 to S6) and render glitches.
- **Colours and sizes** come from theme tokens, never hard-coded in a screen.
- **Text** goes in translation files. Urdu is coming.
- **Never** log post text or interests to analytics or crash reports.
