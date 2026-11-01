// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'GlucoCircle';

  @override
  String get caution =>
      'General information and members\' own experiences, not medical advice. Always consult your doctor.';

  @override
  String get tabCommunity => 'Community';

  @override
  String get tabShare => 'Share';

  @override
  String get tabSigns => 'Signs';

  @override
  String get tabHealthy => 'Healthy';

  @override
  String get actionBack => 'Back';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionClose => 'Close';

  @override
  String get comingSoon => 'This screen is being built.';

  @override
  String get communityTitle => 'Community';

  @override
  String get communitySubtitle => 'You are not alone in this.';

  @override
  String get communityShareStory => 'Share your story';

  @override
  String get firefliesBannerTitle => 'Fireflies · who\'s awake now';

  @override
  String get firefliesBannerBody =>
      'Glow quietly with others who feel the same';

  @override
  String get shareTitle => 'Share your experience';

  @override
  String get signsTitle => 'Signs of diabetes';

  @override
  String get signsIntro =>
      'Common signs to know about. Only a blood test can tell.';

  @override
  String get signThirstyTitle => 'Very thirsty';

  @override
  String get signThirstyNote => 'Drinking much more than usual';

  @override
  String get signUrinatingTitle => 'Urinating often';

  @override
  String get signUrinatingNote => 'Especially waking up at night';

  @override
  String get signTiredTitle => 'Tired all the time';

  @override
  String get signTiredNote => 'Even after resting';

  @override
  String get signWeightTitle => 'Losing weight without trying';

  @override
  String get signWeightNote => 'Not from diet or exercise';

  @override
  String get signHungryTitle => 'Always hungry';

  @override
  String get signHungryNote => 'Hungry soon after eating';

  @override
  String get signVisionTitle => 'Blurry vision';

  @override
  String get signVisionNote => 'Comes and goes';

  @override
  String get signCutsTitle => 'Cuts heal slowly';

  @override
  String get signCutsNote => 'Or infections keep coming back';

  @override
  String get signTinglingTitle => 'Tingling hands or feet';

  @override
  String get signTinglingNote => 'Numbness or pins and needles';

  @override
  String get signsConsult =>
      'Noticed any of these? Consult a doctor. They can arrange a fasting glucose or HbA1c test.';

  @override
  String get signsFindTest => 'Find a test near me';

  @override
  String get signsFindTestQuery => 'diabetes blood test lab near me';

  @override
  String get signsFindTestFailed =>
      'Couldn\'t open maps. Please ask your doctor or a nearby lab.';

  @override
  String get numbersTitle => 'Know your numbers';

  @override
  String get numbersTest => 'Test';

  @override
  String get numbersNormal => 'Normal';

  @override
  String get numbersPre => 'Pre';

  @override
  String get numbersDiabetes => 'Diabetes';

  @override
  String get numbersFasting => 'Fasting';

  @override
  String get numbersFastingUnit => 'mg/dL';

  @override
  String get numbersFastingNormal => 'under 100';

  @override
  String get numbersFastingPre => '100–125';

  @override
  String get numbersFastingDiabetes => '126+';

  @override
  String get numbersA1c => 'HbA1c';

  @override
  String get numbersA1cUnit => '3-month avg';

  @override
  String get numbersA1cNormal => 'under 5.7%';

  @override
  String get numbersA1cPre => '5.7–6.4%';

  @override
  String get numbersA1cDiabetes => '6.5%+';

  @override
  String get urgentTitle => 'Get help right away if you notice';

  @override
  String get urgentBody =>
      'Confusion or fainting, shaking and heavy sweating, very fast breathing, fruity-smelling breath, or vomiting with very high sugar.';

  @override
  String urgentCall(String number) {
    return 'Call emergency $number';
  }

  @override
  String urgentCallFailed(String number) {
    return 'Couldn\'t open the phone. Please dial $number now.';
  }

  @override
  String get sourceAda => 'Source: American Diabetes Association.';

  @override
  String get healthyTitle => 'Stay healthy';

  @override
  String get healthyIntro =>
      'Small daily habits that lower your risk — for everyone, with or without diabetes.';

  @override
  String get plateTitle => 'The healthy plate';

  @override
  String get plateSemantics =>
      'Plate: half vegetables, a quarter protein, a quarter whole grains';

  @override
  String get plateVegetables => 'vegetables & salad';

  @override
  String get plateProtein => 'protein — daal, eggs, chicken';

  @override
  String get plateGrains => 'whole grains — chapati, brown rice';

  @override
  String get plateWater => 'Drink water instead of sugary drinks.';

  @override
  String get riskTitle => 'Are you at higher risk?';

  @override
  String get riskAge => 'Age 35 or older';

  @override
  String get riskFamily => 'Parent, brother or sister with diabetes';

  @override
  String get riskWeight => 'Extra weight, especially around the waist';

  @override
  String get riskActivity => 'Little physical activity';

  @override
  String get riskPregnancy => 'Had diabetes during pregnancy';

  @override
  String get riskSouthAsian => 'South Asian family background';

  @override
  String get checkedTitle => 'Get checked, even if you feel fine';

  @override
  String get checkedBody =>
      'Adults 35 and over should test blood sugar at least every 3 years — sooner and more often with any risk above. Ask your doctor.';

  @override
  String get firefliesTitle => 'Fireflies';

  @override
  String get firefliesIntro => 'You\'re not the only one awake.';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get actionTryAgain => 'Try again';

  @override
  String get actionContinue => 'Continue';

  @override
  String get actionSkip => 'Skip';

  @override
  String get actionDone => 'Done';

  @override
  String get actionPost => 'Post';

  @override
  String get actionSave => 'Save';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionReport => 'Report';

  @override
  String get actionsTitle => 'Options';

  @override
  String get errorTitle => 'Something went wrong';

  @override
  String get errorBody => 'Please check your connection and try again.';

  @override
  String get welcomeTitle => 'A circle of people who understand.';

  @override
  String get welcomeBody =>
      'Share your experience, read others\' stories, and learn the signs of diabetes.';

  @override
  String get signInGoogle => 'Continue with Google';

  @override
  String get signInApple => 'Continue with Apple';

  @override
  String get signInEmail => 'Continue with email';

  @override
  String get signInEmailTitle => 'Continue with email';

  @override
  String get signInEmailLabel => 'Email';

  @override
  String get signInPasswordLabel => 'Password';

  @override
  String get signInEmailInvalid => 'Please enter a valid email address.';

  @override
  String signInPasswordTooShort(int count) {
    return 'Use at least $count characters.';
  }

  @override
  String get consentTitle => 'Before you join';

  @override
  String get consentNicknameLabel => 'Nickname';

  @override
  String get consentNicknameHint => 'A first name or any name you like';

  @override
  String get rulesTitle => 'Community rules';

  @override
  String get rulesBody =>
      'Share your experiences and be kind. Never tell anyone to start, stop or change a medicine. No selling, links or phone numbers.';

  @override
  String get consentAdult => 'I am 18 or older.';

  @override
  String get consentCaution =>
      'I understand GlucoCircle shares general information and members\' own experiences, not medical advice, and that I should always consult my doctor. I agree to the Terms and Privacy Policy.';

  @override
  String get onboardingTitle => 'What brings you to GlucoCircle?';

  @override
  String get onboardingBody =>
      'We\'ll show you the stories and topics that fit. Pick any, or skip.';

  @override
  String get interestType1Title => 'Type 1 diabetes';

  @override
  String get interestType1Note => 'Stories and daily life';

  @override
  String get interestType2Title => 'Type 2 diabetes';

  @override
  String get interestType2Note => 'Food, activity, daily life';

  @override
  String get interestPrediabetesTitle => 'Prediabetes';

  @override
  String get interestPrediabetesNote => 'What others have tried';

  @override
  String get interestPregnancyTitle => 'Diabetes in pregnancy';

  @override
  String get interestPregnancyNote => 'Gestational diabetes support';

  @override
  String get interestCaringTitle => 'Caring for someone';

  @override
  String get interestCaringNote => 'Parent, child or partner';

  @override
  String get interestHealthyTitle => 'Staying healthy';

  @override
  String get interestHealthyNote => 'Know the signs';

  @override
  String get topicAll => 'All';

  @override
  String get topicNewlyDiagnosed => 'Newly diagnosed';

  @override
  String get topicType1 => 'Type 1';

  @override
  String get topicType2 => 'Type 2';

  @override
  String get topicGestational => 'Gestational';

  @override
  String get topicFood => 'Food';

  @override
  String get topicCaregivers => 'Caregivers';

  @override
  String get topicExercise => 'Exercise';

  @override
  String get moodGood => 'Good';

  @override
  String get moodOkay => 'Okay';

  @override
  String get moodLow => 'Low';

  @override
  String get moodStruggling => 'Struggling';

  @override
  String get feelingTagGood => 'Feeling good';

  @override
  String get feelingTagOkay => 'Feeling okay';

  @override
  String get feelingTagLow => 'Feeling low';

  @override
  String get feelingTagStruggling => 'Struggling';

  @override
  String get anonymous => 'Anonymous';

  @override
  String get anonymousMember => 'Anonymous member';

  @override
  String relateCount(int count) {
    return 'I relate · $count';
  }

  @override
  String replyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count replies',
      one: '1 reply',
    );
    return '$_temp0';
  }

  @override
  String get awaitingReview =>
      'Waiting for a quick review. Only you can see this for now.';

  @override
  String get timeNow => 'now';

  @override
  String timeMinutes(int count) {
    return '${count}m';
  }

  @override
  String timeHours(int count) {
    return '${count}h';
  }

  @override
  String timeDays(int count) {
    return '${count}d';
  }

  @override
  String get feedEmptyTitle => 'Be the first to share';

  @override
  String get feedEmptyTopicTitle => 'Nothing here yet';

  @override
  String get feedEmptyBody =>
      'Your story could be what someone needs to read today.';

  @override
  String get shareMoodQuestion => 'How are you feeling today?';

  @override
  String get shareTextQuestion => 'What would you like to share?';

  @override
  String get shareTextHint =>
      'How you feel, what helped, a question for others…';

  @override
  String get shareTopic => 'Topic';

  @override
  String get shareAnonTitle => 'Post anonymously';

  @override
  String get shareAnonBody => 'Your name stays hidden';

  @override
  String get shareKindNote =>
      'Be kind. Share what worked for you, but please don\'t give medicine or dose advice — every body is different. Always check with your doctor.';

  @override
  String get postHeld =>
      'Thanks. A moderator will check this before others can see it.';

  @override
  String get replyHint => 'Write something kind…';

  @override
  String get replySend => 'Send reply';

  @override
  String get repliesEmptyTitle => 'No replies yet';

  @override
  String get repliesEmptyBody => 'A kind word goes a long way.';

  @override
  String get postGoneTitle => 'This post isn\'t available';

  @override
  String get postGoneBody => 'It may have been removed.';

  @override
  String get reportTitlePost => 'Report this post';

  @override
  String get reportTitleReply => 'Report this reply';

  @override
  String get reportTitleGlow => 'Report this glow';

  @override
  String get reportTitlePerson => 'Report this person';

  @override
  String get reportPrivate =>
      'Reports are private. The person won\'t know who reported them.';

  @override
  String get reportQuestion => 'What\'s wrong with it?';

  @override
  String get reportSend => 'Send report';

  @override
  String get reportDangerousTitle => 'Dangerous medical advice';

  @override
  String get reportDangerousNote => 'e.g. telling people to stop medicine';

  @override
  String get reportSellingTitle => 'Selling products or \"cures\"';

  @override
  String get reportSellingNote => 'Ads, fake remedies, scams';

  @override
  String get reportBullyingTitle => 'Bullying or harassment';

  @override
  String get reportBullyingNote => 'Shaming, insults, threats';

  @override
  String get reportDangerTitle => 'Someone may be in danger';

  @override
  String get reportDangerNote => 'A moderator will look at this first';

  @override
  String get reportSpamTitle => 'Spam or something else';

  @override
  String get reportSpamNote => 'Off-topic or repeated posts';

  @override
  String get reportSentTitle => 'Thanks for keeping the circle safe';

  @override
  String get reportSentBody =>
      'Our moderators will review this within 24 hours. Posts with dangerous medical advice are hidden while they\'re checked.';

  @override
  String get blockAction => 'Block this person';

  @override
  String get blockConfirmTitle => 'Block this person?';

  @override
  String get blockConfirmBody =>
      'You won\'t see their posts, replies or glows. They won\'t be told.';

  @override
  String get unblockAction => 'Unblock';

  @override
  String get blockedEmptyTitle => 'No one is blocked';

  @override
  String get blockedEmptyBody => 'People you block will be listed here.';

  @override
  String get inboxEmptyTitle => 'Nothing yet';

  @override
  String get inboxEmptyBody =>
      'Replies and warmth from others will show up here.';

  @override
  String inboxReply(String who) {
    return '$who replied to your post';
  }

  @override
  String inboxWarmth(String who) {
    return '$who sent you warmth';
  }

  @override
  String get settingsTopics => 'My topics';

  @override
  String get settingsBlocked => 'Blocked people';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String get settingsTerms => 'Terms';

  @override
  String get settingsContact => 'Contact us';

  @override
  String get settingsLicences => 'Licences';

  @override
  String get settingsSignOut => 'Sign out';

  @override
  String get deleteAccountTitle => 'Delete account';

  @override
  String get deleteAccountBody =>
      'This permanently deletes your account, posts and replies. It can\'t be undone.';

  @override
  String get deleteAccountConfirm => 'Delete my account';

  @override
  String get skyLegend => 'Brighter = waiting longer';

  @override
  String skyCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people feel like you right now.',
      one: '1 person feels like you right now.',
    );
    return '$_temp0';
  }

  @override
  String get skyEmptyAll =>
      'You\'re the first firefly right now. Light your glow and others will find you.';

  @override
  String get skyEmptyFilter => 'No one is glowing with this feeling right now.';

  @override
  String get skyNext => 'Next firefly';

  @override
  String glowMeta(String country, int minutes) {
    return '$country · waiting $minutes min';
  }

  @override
  String get sendWarmth => 'Send warmth';

  @override
  String get warmthSent => 'Warmth sent';

  @override
  String get lightMyGlow => 'Light my glow';

  @override
  String get seeMyGlow => 'See my glow';

  @override
  String get glowCantSleep => 'Can\'t sleep';

  @override
  String get glowAfterLow => 'After a low';

  @override
  String get glowSugarHigh => 'Sugar is high';

  @override
  String get glowNewDiagnosis => 'New diagnosis';

  @override
  String get glowFeelingHeavy => 'Feeling heavy';

  @override
  String get glowJustCompany => 'Just want company';

  @override
  String get glowDuration15 => '15 min';

  @override
  String get glowDuration30 => '30 min';

  @override
  String get glowDuration60 => '1 hour';

  @override
  String get glowDurationDawn => 'Till dawn';

  @override
  String get glowPrivacy => 'Only your nickname and country are shown';

  @override
  String get glowTitle => 'Light your glow';

  @override
  String get glowSubtitle => 'Let others who feel the same find you.';

  @override
  String get glowQuestion => 'What\'s keeping you up?';

  @override
  String get glowLineLabel => 'Say it in one line';

  @override
  String get glowLineHint => 'e.g. Can\'t switch my mind off…';

  @override
  String get glowHeld =>
      'Please reword this. Links, phone numbers and medicine instructions can\'t be shared here.';

  @override
  String get glowDurationLabel_ => 'Glow for';

  @override
  String get glowFootnote =>
      'Fireflies is for sharing feelings, not medical advice. Your glow fades on its own.';

  @override
  String get glowStart => 'Glow quietly';

  @override
  String get cautionTitle => 'First, take care of yourself';

  @override
  String get cautionBody =>
      'GlucoCircle can\'t check or treat this. Follow the plan your doctor gave you. If you feel very unwell, get help now.';

  @override
  String get cautionContinue => 'I\'m okay, continue';

  @override
  String glowingTimeLeft(int minutes) {
    return 'Glowing · $minutes min left';
  }

  @override
  String get quietTitle => 'You\'re glowing quietly';

  @override
  String get quietBody =>
      'No one can message you. People who feel the same can only send warmth.';

  @override
  String get quietNoWarmth => 'Warmth from others will show up here';

  @override
  String quietWarmthCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count people sent you warmth',
      one: '1 person sent you warmth',
    );
    return '$_temp0';
  }

  @override
  String get quietGlowBack => 'Glow back';

  @override
  String get quietDim => 'Dim my glow';

  @override
  String get glowFadedTitle => 'Your glow has faded';

  @override
  String get glowFadedBody => 'Light it again whenever you need to.';

  @override
  String reportDangerSent(String number) {
    return 'If someone is in immediate danger, don\'t wait for us. Call $number now.';
  }
}
