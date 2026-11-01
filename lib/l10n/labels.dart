import '../data/models.dart';
import 'generated/app_localizations.dart';

extension EnumLabels on AppLocalizations {
  String topicLabel(Topic topic) => switch (topic) {
    Topic.newlyDiagnosed => topicNewlyDiagnosed,
    Topic.type1 => topicType1,
    Topic.type2 => topicType2,
    Topic.gestational => topicGestational,
    Topic.food => topicFood,
    Topic.caregivers => topicCaregivers,
    Topic.exercise => topicExercise,
  };

  String moodLabel(Mood mood) => switch (mood) {
    Mood.good => moodGood,
    Mood.okay => moodOkay,
    Mood.low => moodLow,
    Mood.struggling => moodStruggling,
  };

  String feelingTag(Mood mood) => switch (mood) {
    Mood.good => feelingTagGood,
    Mood.okay => feelingTagOkay,
    Mood.low => feelingTagLow,
    Mood.struggling => feelingTagStruggling,
  };

  String glowFeelingLabel(GlowFeeling feeling) => switch (feeling) {
    GlowFeeling.cantSleep => glowCantSleep,
    GlowFeeling.afterLow => glowAfterLow,
    GlowFeeling.sugarHigh => glowSugarHigh,
    GlowFeeling.newDiagnosis => glowNewDiagnosis,
    GlowFeeling.feelingHeavy => glowFeelingHeavy,
    GlowFeeling.justCompany => glowJustCompany,
  };

  String glowDurationLabel(GlowDuration duration) => switch (duration) {
    GlowDuration.min15 => glowDuration15,
    GlowDuration.min30 => glowDuration30,
    GlowDuration.hour1 => glowDuration60,
    GlowDuration.tillDawn => glowDurationDawn,
  };

  String reportReasonTitle(ReportReason reason) => switch (reason) {
    ReportReason.dangerousAdvice => reportDangerousTitle,
    ReportReason.selling => reportSellingTitle,
    ReportReason.bullying => reportBullyingTitle,
    ReportReason.danger => reportDangerTitle,
    ReportReason.spam => reportSpamTitle,
  };

  String reportReasonNote(ReportReason reason) => switch (reason) {
    ReportReason.dangerousAdvice => reportDangerousNote,
    ReportReason.selling => reportSellingNote,
    ReportReason.bullying => reportBullyingNote,
    ReportReason.danger => reportDangerNote,
    ReportReason.spam => reportSpamNote,
  };

  String reportTitle(ReportTarget target) => switch (target) {
    ReportTarget.post => reportTitlePost,
    ReportTarget.reply => reportTitleReply,
    ReportTarget.glow => reportTitleGlow,
    ReportTarget.warmth => reportTitlePerson,
  };

  String interestTitle(Interest interest) => switch (interest) {
    Interest.type1 => interestType1Title,
    Interest.type2 => interestType2Title,
    Interest.prediabetes => interestPrediabetesTitle,
    Interest.pregnancy => interestPregnancyTitle,
    Interest.caring => interestCaringTitle,
    Interest.stayingHealthy => interestHealthyTitle,
  };

  String interestNote(Interest interest) => switch (interest) {
    Interest.type1 => interestType1Note,
    Interest.type2 => interestType2Note,
    Interest.prediabetes => interestPrediabetesNote,
    Interest.pregnancy => interestPregnancyNote,
    Interest.caring => interestCaringNote,
    Interest.stayingHealthy => interestHealthyNote,
  };

  String timeAgo(DateTime then, DateTime now) {
    final elapsed = now.difference(then);
    if (elapsed.inMinutes < 1) return timeNow;
    if (elapsed.inHours < 1) return timeMinutes(elapsed.inMinutes);
    if (elapsed.inDays < 1) return timeHours(elapsed.inHours);
    return timeDays(elapsed.inDays);
  }
}
