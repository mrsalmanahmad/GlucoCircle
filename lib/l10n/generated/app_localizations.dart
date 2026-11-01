import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'GlucoCircle'**
  String get appTitle;

  /// No description provided for @caution.
  ///
  /// In en, this message translates to:
  /// **'General information and members\' own experiences, not medical advice. Always consult your doctor.'**
  String get caution;

  /// No description provided for @tabCommunity.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get tabCommunity;

  /// No description provided for @tabShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get tabShare;

  /// No description provided for @tabSigns.
  ///
  /// In en, this message translates to:
  /// **'Signs'**
  String get tabSigns;

  /// No description provided for @tabHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get tabHealthy;

  /// No description provided for @actionBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get actionBack;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get actionClose;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'This screen is being built.'**
  String get comingSoon;

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityTitle;

  /// No description provided for @communitySubtitle.
  ///
  /// In en, this message translates to:
  /// **'You are not alone in this.'**
  String get communitySubtitle;

  /// No description provided for @communityShareStory.
  ///
  /// In en, this message translates to:
  /// **'Share your story'**
  String get communityShareStory;

  /// No description provided for @firefliesBannerTitle.
  ///
  /// In en, this message translates to:
  /// **'Fireflies · who\'s awake now'**
  String get firefliesBannerTitle;

  /// No description provided for @firefliesBannerBody.
  ///
  /// In en, this message translates to:
  /// **'Glow quietly with others who feel the same'**
  String get firefliesBannerBody;

  /// No description provided for @shareTitle.
  ///
  /// In en, this message translates to:
  /// **'Share your experience'**
  String get shareTitle;

  /// No description provided for @signsTitle.
  ///
  /// In en, this message translates to:
  /// **'Signs of diabetes'**
  String get signsTitle;

  /// No description provided for @signsIntro.
  ///
  /// In en, this message translates to:
  /// **'Common signs to know about. Only a blood test can tell.'**
  String get signsIntro;

  /// No description provided for @signThirstyTitle.
  ///
  /// In en, this message translates to:
  /// **'Very thirsty'**
  String get signThirstyTitle;

  /// No description provided for @signThirstyNote.
  ///
  /// In en, this message translates to:
  /// **'Drinking much more than usual'**
  String get signThirstyNote;

  /// No description provided for @signUrinatingTitle.
  ///
  /// In en, this message translates to:
  /// **'Urinating often'**
  String get signUrinatingTitle;

  /// No description provided for @signUrinatingNote.
  ///
  /// In en, this message translates to:
  /// **'Especially waking up at night'**
  String get signUrinatingNote;

  /// No description provided for @signTiredTitle.
  ///
  /// In en, this message translates to:
  /// **'Tired all the time'**
  String get signTiredTitle;

  /// No description provided for @signTiredNote.
  ///
  /// In en, this message translates to:
  /// **'Even after resting'**
  String get signTiredNote;

  /// No description provided for @signWeightTitle.
  ///
  /// In en, this message translates to:
  /// **'Losing weight without trying'**
  String get signWeightTitle;

  /// No description provided for @signWeightNote.
  ///
  /// In en, this message translates to:
  /// **'Not from diet or exercise'**
  String get signWeightNote;

  /// No description provided for @signHungryTitle.
  ///
  /// In en, this message translates to:
  /// **'Always hungry'**
  String get signHungryTitle;

  /// No description provided for @signHungryNote.
  ///
  /// In en, this message translates to:
  /// **'Hungry soon after eating'**
  String get signHungryNote;

  /// No description provided for @signVisionTitle.
  ///
  /// In en, this message translates to:
  /// **'Blurry vision'**
  String get signVisionTitle;

  /// No description provided for @signVisionNote.
  ///
  /// In en, this message translates to:
  /// **'Comes and goes'**
  String get signVisionNote;

  /// No description provided for @signCutsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cuts heal slowly'**
  String get signCutsTitle;

  /// No description provided for @signCutsNote.
  ///
  /// In en, this message translates to:
  /// **'Or infections keep coming back'**
  String get signCutsNote;

  /// No description provided for @signTinglingTitle.
  ///
  /// In en, this message translates to:
  /// **'Tingling hands or feet'**
  String get signTinglingTitle;

  /// No description provided for @signTinglingNote.
  ///
  /// In en, this message translates to:
  /// **'Numbness or pins and needles'**
  String get signTinglingNote;

  /// No description provided for @signsConsult.
  ///
  /// In en, this message translates to:
  /// **'Noticed any of these? Consult a doctor. They can arrange a fasting glucose or HbA1c test.'**
  String get signsConsult;

  /// No description provided for @signsFindTest.
  ///
  /// In en, this message translates to:
  /// **'Find a test near me'**
  String get signsFindTest;

  /// No description provided for @signsFindTestQuery.
  ///
  /// In en, this message translates to:
  /// **'diabetes blood test lab near me'**
  String get signsFindTestQuery;

  /// No description provided for @signsFindTestFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open maps. Please ask your doctor or a nearby lab.'**
  String get signsFindTestFailed;

  /// No description provided for @numbersTitle.
  ///
  /// In en, this message translates to:
  /// **'Know your numbers'**
  String get numbersTitle;

  /// No description provided for @numbersTest.
  ///
  /// In en, this message translates to:
  /// **'Test'**
  String get numbersTest;

  /// No description provided for @numbersNormal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get numbersNormal;

  /// No description provided for @numbersPre.
  ///
  /// In en, this message translates to:
  /// **'Pre'**
  String get numbersPre;

  /// No description provided for @numbersDiabetes.
  ///
  /// In en, this message translates to:
  /// **'Diabetes'**
  String get numbersDiabetes;

  /// No description provided for @numbersFasting.
  ///
  /// In en, this message translates to:
  /// **'Fasting'**
  String get numbersFasting;

  /// No description provided for @numbersFastingUnit.
  ///
  /// In en, this message translates to:
  /// **'mg/dL'**
  String get numbersFastingUnit;

  /// No description provided for @numbersFastingNormal.
  ///
  /// In en, this message translates to:
  /// **'under 100'**
  String get numbersFastingNormal;

  /// No description provided for @numbersFastingPre.
  ///
  /// In en, this message translates to:
  /// **'100–125'**
  String get numbersFastingPre;

  /// No description provided for @numbersFastingDiabetes.
  ///
  /// In en, this message translates to:
  /// **'126+'**
  String get numbersFastingDiabetes;

  /// No description provided for @numbersA1c.
  ///
  /// In en, this message translates to:
  /// **'HbA1c'**
  String get numbersA1c;

  /// No description provided for @numbersA1cUnit.
  ///
  /// In en, this message translates to:
  /// **'3-month avg'**
  String get numbersA1cUnit;

  /// No description provided for @numbersA1cNormal.
  ///
  /// In en, this message translates to:
  /// **'under 5.7%'**
  String get numbersA1cNormal;

  /// No description provided for @numbersA1cPre.
  ///
  /// In en, this message translates to:
  /// **'5.7–6.4%'**
  String get numbersA1cPre;

  /// No description provided for @numbersA1cDiabetes.
  ///
  /// In en, this message translates to:
  /// **'6.5%+'**
  String get numbersA1cDiabetes;

  /// No description provided for @urgentTitle.
  ///
  /// In en, this message translates to:
  /// **'Get help right away if you notice'**
  String get urgentTitle;

  /// No description provided for @urgentBody.
  ///
  /// In en, this message translates to:
  /// **'Confusion or fainting, shaking and heavy sweating, very fast breathing, fruity-smelling breath, or vomiting with very high sugar.'**
  String get urgentBody;

  /// No description provided for @urgentCall.
  ///
  /// In en, this message translates to:
  /// **'Call emergency {number}'**
  String urgentCall(String number);

  /// No description provided for @urgentCallFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the phone. Please dial {number} now.'**
  String urgentCallFailed(String number);

  /// No description provided for @sourceAda.
  ///
  /// In en, this message translates to:
  /// **'Source: American Diabetes Association.'**
  String get sourceAda;

  /// No description provided for @healthyTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay healthy'**
  String get healthyTitle;

  /// No description provided for @healthyIntro.
  ///
  /// In en, this message translates to:
  /// **'Small daily habits that lower your risk — for everyone, with or without diabetes.'**
  String get healthyIntro;

  /// No description provided for @plateTitle.
  ///
  /// In en, this message translates to:
  /// **'The healthy plate'**
  String get plateTitle;

  /// No description provided for @plateSemantics.
  ///
  /// In en, this message translates to:
  /// **'Plate: half vegetables, a quarter protein, a quarter whole grains'**
  String get plateSemantics;

  /// No description provided for @plateVegetables.
  ///
  /// In en, this message translates to:
  /// **'vegetables & salad'**
  String get plateVegetables;

  /// No description provided for @plateProtein.
  ///
  /// In en, this message translates to:
  /// **'protein — daal, eggs, chicken'**
  String get plateProtein;

  /// No description provided for @plateGrains.
  ///
  /// In en, this message translates to:
  /// **'whole grains — chapati, brown rice'**
  String get plateGrains;

  /// No description provided for @plateWater.
  ///
  /// In en, this message translates to:
  /// **'Drink water instead of sugary drinks.'**
  String get plateWater;

  /// No description provided for @riskTitle.
  ///
  /// In en, this message translates to:
  /// **'Are you at higher risk?'**
  String get riskTitle;

  /// No description provided for @riskAge.
  ///
  /// In en, this message translates to:
  /// **'Age 35 or older'**
  String get riskAge;

  /// No description provided for @riskFamily.
  ///
  /// In en, this message translates to:
  /// **'Parent, brother or sister with diabetes'**
  String get riskFamily;

  /// No description provided for @riskWeight.
  ///
  /// In en, this message translates to:
  /// **'Extra weight, especially around the waist'**
  String get riskWeight;

  /// No description provided for @riskActivity.
  ///
  /// In en, this message translates to:
  /// **'Little physical activity'**
  String get riskActivity;

  /// No description provided for @riskPregnancy.
  ///
  /// In en, this message translates to:
  /// **'Had diabetes during pregnancy'**
  String get riskPregnancy;

  /// No description provided for @riskSouthAsian.
  ///
  /// In en, this message translates to:
  /// **'South Asian family background'**
  String get riskSouthAsian;

  /// No description provided for @checkedTitle.
  ///
  /// In en, this message translates to:
  /// **'Get checked, even if you feel fine'**
  String get checkedTitle;

  /// No description provided for @checkedBody.
  ///
  /// In en, this message translates to:
  /// **'Adults 35 and over should test blood sugar at least every 3 years — sooner and more often with any risk above. Ask your doctor.'**
  String get checkedBody;

  /// No description provided for @firefliesTitle.
  ///
  /// In en, this message translates to:
  /// **'Fireflies'**
  String get firefliesTitle;

  /// No description provided for @firefliesIntro.
  ///
  /// In en, this message translates to:
  /// **'You\'re not the only one awake.'**
  String get firefliesIntro;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @actionTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get actionTryAgain;

  /// No description provided for @actionContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get actionContinue;

  /// No description provided for @actionSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get actionSkip;

  /// No description provided for @actionDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get actionDone;

  /// No description provided for @actionPost.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get actionPost;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionReport.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get actionReport;

  /// No description provided for @actionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get actionsTitle;

  /// No description provided for @errorTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get errorTitle;

  /// No description provided for @errorBody.
  ///
  /// In en, this message translates to:
  /// **'Please check your connection and try again.'**
  String get errorBody;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'A circle of people who understand.'**
  String get welcomeTitle;

  /// No description provided for @welcomeBody.
  ///
  /// In en, this message translates to:
  /// **'Share your experience, read others\' stories, and learn the signs of diabetes.'**
  String get welcomeBody;

  /// No description provided for @signInGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get signInGoogle;

  /// No description provided for @signInApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get signInApple;

  /// No description provided for @signInEmail.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get signInEmail;

  /// No description provided for @signInEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Continue with email'**
  String get signInEmailTitle;

  /// No description provided for @signInEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get signInEmailLabel;

  /// No description provided for @signInPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get signInPasswordLabel;

  /// No description provided for @signInEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address.'**
  String get signInEmailInvalid;

  /// No description provided for @signInPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least {count} characters.'**
  String signInPasswordTooShort(int count);

  /// No description provided for @consentTitle.
  ///
  /// In en, this message translates to:
  /// **'Before you join'**
  String get consentTitle;

  /// No description provided for @consentNicknameLabel.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get consentNicknameLabel;

  /// No description provided for @consentNicknameHint.
  ///
  /// In en, this message translates to:
  /// **'A first name or any name you like'**
  String get consentNicknameHint;

  /// No description provided for @rulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Community rules'**
  String get rulesTitle;

  /// No description provided for @rulesBody.
  ///
  /// In en, this message translates to:
  /// **'Share your experiences and be kind. Never tell anyone to start, stop or change a medicine. No selling, links or phone numbers.'**
  String get rulesBody;

  /// No description provided for @consentAdult.
  ///
  /// In en, this message translates to:
  /// **'I am 18 or older.'**
  String get consentAdult;

  /// No description provided for @consentCaution.
  ///
  /// In en, this message translates to:
  /// **'I understand GlucoCircle shares general information and members\' own experiences, not medical advice, and that I should always consult my doctor. I agree to the Terms and Privacy Policy.'**
  String get consentCaution;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'What brings you to GlucoCircle?'**
  String get onboardingTitle;

  /// No description provided for @onboardingBody.
  ///
  /// In en, this message translates to:
  /// **'We\'ll show you the stories and topics that fit. Pick any, or skip.'**
  String get onboardingBody;

  /// No description provided for @interestType1Title.
  ///
  /// In en, this message translates to:
  /// **'Type 1 diabetes'**
  String get interestType1Title;

  /// No description provided for @interestType1Note.
  ///
  /// In en, this message translates to:
  /// **'Stories and daily life'**
  String get interestType1Note;

  /// No description provided for @interestType2Title.
  ///
  /// In en, this message translates to:
  /// **'Type 2 diabetes'**
  String get interestType2Title;

  /// No description provided for @interestType2Note.
  ///
  /// In en, this message translates to:
  /// **'Food, activity, daily life'**
  String get interestType2Note;

  /// No description provided for @interestPrediabetesTitle.
  ///
  /// In en, this message translates to:
  /// **'Prediabetes'**
  String get interestPrediabetesTitle;

  /// No description provided for @interestPrediabetesNote.
  ///
  /// In en, this message translates to:
  /// **'What others have tried'**
  String get interestPrediabetesNote;

  /// No description provided for @interestPregnancyTitle.
  ///
  /// In en, this message translates to:
  /// **'Diabetes in pregnancy'**
  String get interestPregnancyTitle;

  /// No description provided for @interestPregnancyNote.
  ///
  /// In en, this message translates to:
  /// **'Gestational diabetes support'**
  String get interestPregnancyNote;

  /// No description provided for @interestCaringTitle.
  ///
  /// In en, this message translates to:
  /// **'Caring for someone'**
  String get interestCaringTitle;

  /// No description provided for @interestCaringNote.
  ///
  /// In en, this message translates to:
  /// **'Parent, child or partner'**
  String get interestCaringNote;

  /// No description provided for @interestHealthyTitle.
  ///
  /// In en, this message translates to:
  /// **'Staying healthy'**
  String get interestHealthyTitle;

  /// No description provided for @interestHealthyNote.
  ///
  /// In en, this message translates to:
  /// **'Know the signs'**
  String get interestHealthyNote;

  /// No description provided for @topicAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get topicAll;

  /// No description provided for @topicNewlyDiagnosed.
  ///
  /// In en, this message translates to:
  /// **'Newly diagnosed'**
  String get topicNewlyDiagnosed;

  /// No description provided for @topicType1.
  ///
  /// In en, this message translates to:
  /// **'Type 1'**
  String get topicType1;

  /// No description provided for @topicType2.
  ///
  /// In en, this message translates to:
  /// **'Type 2'**
  String get topicType2;

  /// No description provided for @topicGestational.
  ///
  /// In en, this message translates to:
  /// **'Gestational'**
  String get topicGestational;

  /// No description provided for @topicFood.
  ///
  /// In en, this message translates to:
  /// **'Food'**
  String get topicFood;

  /// No description provided for @topicCaregivers.
  ///
  /// In en, this message translates to:
  /// **'Caregivers'**
  String get topicCaregivers;

  /// No description provided for @topicExercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get topicExercise;

  /// No description provided for @moodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get moodGood;

  /// No description provided for @moodOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get moodOkay;

  /// No description provided for @moodLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get moodLow;

  /// No description provided for @moodStruggling.
  ///
  /// In en, this message translates to:
  /// **'Struggling'**
  String get moodStruggling;

  /// No description provided for @feelingTagGood.
  ///
  /// In en, this message translates to:
  /// **'Feeling good'**
  String get feelingTagGood;

  /// No description provided for @feelingTagOkay.
  ///
  /// In en, this message translates to:
  /// **'Feeling okay'**
  String get feelingTagOkay;

  /// No description provided for @feelingTagLow.
  ///
  /// In en, this message translates to:
  /// **'Feeling low'**
  String get feelingTagLow;

  /// No description provided for @feelingTagStruggling.
  ///
  /// In en, this message translates to:
  /// **'Struggling'**
  String get feelingTagStruggling;

  /// No description provided for @anonymous.
  ///
  /// In en, this message translates to:
  /// **'Anonymous'**
  String get anonymous;

  /// No description provided for @anonymousMember.
  ///
  /// In en, this message translates to:
  /// **'Anonymous member'**
  String get anonymousMember;

  /// No description provided for @relateCount.
  ///
  /// In en, this message translates to:
  /// **'I relate · {count}'**
  String relateCount(int count);

  /// No description provided for @replyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 reply} other{{count} replies}}'**
  String replyCount(int count);

  /// No description provided for @awaitingReview.
  ///
  /// In en, this message translates to:
  /// **'Waiting for a quick review. Only you can see this for now.'**
  String get awaitingReview;

  /// No description provided for @timeNow.
  ///
  /// In en, this message translates to:
  /// **'now'**
  String get timeNow;

  /// No description provided for @timeMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count}m'**
  String timeMinutes(int count);

  /// No description provided for @timeHours.
  ///
  /// In en, this message translates to:
  /// **'{count}h'**
  String timeHours(int count);

  /// No description provided for @timeDays.
  ///
  /// In en, this message translates to:
  /// **'{count}d'**
  String timeDays(int count);

  /// No description provided for @feedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Be the first to share'**
  String get feedEmptyTitle;

  /// No description provided for @feedEmptyTopicTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet'**
  String get feedEmptyTopicTitle;

  /// No description provided for @feedEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Your story could be what someone needs to read today.'**
  String get feedEmptyBody;

  /// No description provided for @shareMoodQuestion.
  ///
  /// In en, this message translates to:
  /// **'How are you feeling today?'**
  String get shareMoodQuestion;

  /// No description provided for @shareTextQuestion.
  ///
  /// In en, this message translates to:
  /// **'What would you like to share?'**
  String get shareTextQuestion;

  /// No description provided for @shareTextHint.
  ///
  /// In en, this message translates to:
  /// **'How you feel, what helped, a question for others…'**
  String get shareTextHint;

  /// No description provided for @shareTopic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get shareTopic;

  /// No description provided for @shareAnonTitle.
  ///
  /// In en, this message translates to:
  /// **'Post anonymously'**
  String get shareAnonTitle;

  /// No description provided for @shareAnonBody.
  ///
  /// In en, this message translates to:
  /// **'Your name stays hidden'**
  String get shareAnonBody;

  /// No description provided for @shareKindNote.
  ///
  /// In en, this message translates to:
  /// **'Be kind. Share what worked for you, but please don\'t give medicine or dose advice — every body is different. Always check with your doctor.'**
  String get shareKindNote;

  /// No description provided for @postHeld.
  ///
  /// In en, this message translates to:
  /// **'Thanks. A moderator will check this before others can see it.'**
  String get postHeld;

  /// No description provided for @replyHint.
  ///
  /// In en, this message translates to:
  /// **'Write something kind…'**
  String get replyHint;

  /// No description provided for @replySend.
  ///
  /// In en, this message translates to:
  /// **'Send reply'**
  String get replySend;

  /// No description provided for @repliesEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No replies yet'**
  String get repliesEmptyTitle;

  /// No description provided for @repliesEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'A kind word goes a long way.'**
  String get repliesEmptyBody;

  /// No description provided for @postGoneTitle.
  ///
  /// In en, this message translates to:
  /// **'This post isn\'t available'**
  String get postGoneTitle;

  /// No description provided for @postGoneBody.
  ///
  /// In en, this message translates to:
  /// **'It may have been removed.'**
  String get postGoneBody;

  /// No description provided for @reportTitlePost.
  ///
  /// In en, this message translates to:
  /// **'Report this post'**
  String get reportTitlePost;

  /// No description provided for @reportTitleReply.
  ///
  /// In en, this message translates to:
  /// **'Report this reply'**
  String get reportTitleReply;

  /// No description provided for @reportTitleGlow.
  ///
  /// In en, this message translates to:
  /// **'Report this glow'**
  String get reportTitleGlow;

  /// No description provided for @reportTitlePerson.
  ///
  /// In en, this message translates to:
  /// **'Report this person'**
  String get reportTitlePerson;

  /// No description provided for @reportPrivate.
  ///
  /// In en, this message translates to:
  /// **'Reports are private. The person won\'t know who reported them.'**
  String get reportPrivate;

  /// No description provided for @reportQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s wrong with it?'**
  String get reportQuestion;

  /// No description provided for @reportSend.
  ///
  /// In en, this message translates to:
  /// **'Send report'**
  String get reportSend;

  /// No description provided for @reportDangerousTitle.
  ///
  /// In en, this message translates to:
  /// **'Dangerous medical advice'**
  String get reportDangerousTitle;

  /// No description provided for @reportDangerousNote.
  ///
  /// In en, this message translates to:
  /// **'e.g. telling people to stop medicine'**
  String get reportDangerousNote;

  /// No description provided for @reportSellingTitle.
  ///
  /// In en, this message translates to:
  /// **'Selling products or \"cures\"'**
  String get reportSellingTitle;

  /// No description provided for @reportSellingNote.
  ///
  /// In en, this message translates to:
  /// **'Ads, fake remedies, scams'**
  String get reportSellingNote;

  /// No description provided for @reportBullyingTitle.
  ///
  /// In en, this message translates to:
  /// **'Bullying or harassment'**
  String get reportBullyingTitle;

  /// No description provided for @reportBullyingNote.
  ///
  /// In en, this message translates to:
  /// **'Shaming, insults, threats'**
  String get reportBullyingNote;

  /// No description provided for @reportDangerTitle.
  ///
  /// In en, this message translates to:
  /// **'Someone may be in danger'**
  String get reportDangerTitle;

  /// No description provided for @reportDangerNote.
  ///
  /// In en, this message translates to:
  /// **'A moderator will look at this first'**
  String get reportDangerNote;

  /// No description provided for @reportSpamTitle.
  ///
  /// In en, this message translates to:
  /// **'Spam or something else'**
  String get reportSpamTitle;

  /// No description provided for @reportSpamNote.
  ///
  /// In en, this message translates to:
  /// **'Off-topic or repeated posts'**
  String get reportSpamNote;

  /// No description provided for @reportSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Thanks for keeping the circle safe'**
  String get reportSentTitle;

  /// No description provided for @reportSentBody.
  ///
  /// In en, this message translates to:
  /// **'Our moderators will review this within 24 hours. Posts with dangerous medical advice are hidden while they\'re checked.'**
  String get reportSentBody;

  /// No description provided for @blockAction.
  ///
  /// In en, this message translates to:
  /// **'Block this person'**
  String get blockAction;

  /// No description provided for @blockConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Block this person?'**
  String get blockConfirmTitle;

  /// No description provided for @blockConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'You won\'t see their posts, replies or glows. They won\'t be told.'**
  String get blockConfirmBody;

  /// No description provided for @unblockAction.
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get unblockAction;

  /// No description provided for @blockedEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No one is blocked'**
  String get blockedEmptyTitle;

  /// No description provided for @blockedEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'People you block will be listed here.'**
  String get blockedEmptyBody;

  /// No description provided for @inboxEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet'**
  String get inboxEmptyTitle;

  /// No description provided for @inboxEmptyBody.
  ///
  /// In en, this message translates to:
  /// **'Replies and warmth from others will show up here.'**
  String get inboxEmptyBody;

  /// No description provided for @inboxReply.
  ///
  /// In en, this message translates to:
  /// **'{who} replied to your post'**
  String inboxReply(String who);

  /// No description provided for @inboxWarmth.
  ///
  /// In en, this message translates to:
  /// **'{who} sent you warmth'**
  String inboxWarmth(String who);

  /// No description provided for @settingsTopics.
  ///
  /// In en, this message translates to:
  /// **'My topics'**
  String get settingsTopics;

  /// No description provided for @settingsBlocked.
  ///
  /// In en, this message translates to:
  /// **'Blocked people'**
  String get settingsBlocked;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get settingsTerms;

  /// No description provided for @settingsContact.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get settingsContact;

  /// No description provided for @settingsLicences.
  ///
  /// In en, this message translates to:
  /// **'Licences'**
  String get settingsLicences;

  /// No description provided for @settingsSignOut.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get settingsSignOut;

  /// No description provided for @deleteAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccountTitle;

  /// No description provided for @deleteAccountBody.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your account, posts and replies. It can\'t be undone.'**
  String get deleteAccountBody;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteAccountConfirm;

  /// No description provided for @skyLegend.
  ///
  /// In en, this message translates to:
  /// **'Brighter = waiting longer'**
  String get skyLegend;

  /// No description provided for @skyCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person feels like you right now.} other{{count} people feel like you right now.}}'**
  String skyCount(int count);

  /// No description provided for @skyEmptyAll.
  ///
  /// In en, this message translates to:
  /// **'You\'re the first firefly right now. Light your glow and others will find you.'**
  String get skyEmptyAll;

  /// No description provided for @skyEmptyFilter.
  ///
  /// In en, this message translates to:
  /// **'No one is glowing with this feeling right now.'**
  String get skyEmptyFilter;

  /// No description provided for @skyNext.
  ///
  /// In en, this message translates to:
  /// **'Next firefly'**
  String get skyNext;

  /// No description provided for @glowMeta.
  ///
  /// In en, this message translates to:
  /// **'{country} · waiting {minutes} min'**
  String glowMeta(String country, int minutes);

  /// No description provided for @sendWarmth.
  ///
  /// In en, this message translates to:
  /// **'Send warmth'**
  String get sendWarmth;

  /// No description provided for @warmthSent.
  ///
  /// In en, this message translates to:
  /// **'Warmth sent'**
  String get warmthSent;

  /// No description provided for @lightMyGlow.
  ///
  /// In en, this message translates to:
  /// **'Light my glow'**
  String get lightMyGlow;

  /// No description provided for @seeMyGlow.
  ///
  /// In en, this message translates to:
  /// **'See my glow'**
  String get seeMyGlow;

  /// No description provided for @glowCantSleep.
  ///
  /// In en, this message translates to:
  /// **'Can\'t sleep'**
  String get glowCantSleep;

  /// No description provided for @glowAfterLow.
  ///
  /// In en, this message translates to:
  /// **'After a low'**
  String get glowAfterLow;

  /// No description provided for @glowSugarHigh.
  ///
  /// In en, this message translates to:
  /// **'Sugar is high'**
  String get glowSugarHigh;

  /// No description provided for @glowNewDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'New diagnosis'**
  String get glowNewDiagnosis;

  /// No description provided for @glowFeelingHeavy.
  ///
  /// In en, this message translates to:
  /// **'Feeling heavy'**
  String get glowFeelingHeavy;

  /// No description provided for @glowJustCompany.
  ///
  /// In en, this message translates to:
  /// **'Just want company'**
  String get glowJustCompany;

  /// No description provided for @glowDuration15.
  ///
  /// In en, this message translates to:
  /// **'15 min'**
  String get glowDuration15;

  /// No description provided for @glowDuration30.
  ///
  /// In en, this message translates to:
  /// **'30 min'**
  String get glowDuration30;

  /// No description provided for @glowDuration60.
  ///
  /// In en, this message translates to:
  /// **'1 hour'**
  String get glowDuration60;

  /// No description provided for @glowDurationDawn.
  ///
  /// In en, this message translates to:
  /// **'Till dawn'**
  String get glowDurationDawn;

  /// No description provided for @glowPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Only your nickname and country are shown'**
  String get glowPrivacy;

  /// No description provided for @glowTitle.
  ///
  /// In en, this message translates to:
  /// **'Light your glow'**
  String get glowTitle;

  /// No description provided for @glowSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Let others who feel the same find you.'**
  String get glowSubtitle;

  /// No description provided for @glowQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s keeping you up?'**
  String get glowQuestion;

  /// No description provided for @glowLineLabel.
  ///
  /// In en, this message translates to:
  /// **'Say it in one line'**
  String get glowLineLabel;

  /// No description provided for @glowLineHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Can\'t switch my mind off…'**
  String get glowLineHint;

  /// No description provided for @glowHeld.
  ///
  /// In en, this message translates to:
  /// **'Please reword this. Links, phone numbers and medicine instructions can\'t be shared here.'**
  String get glowHeld;

  /// No description provided for @glowDurationLabel_.
  ///
  /// In en, this message translates to:
  /// **'Glow for'**
  String get glowDurationLabel_;

  /// No description provided for @glowFootnote.
  ///
  /// In en, this message translates to:
  /// **'Fireflies is for sharing feelings, not medical advice. Your glow fades on its own.'**
  String get glowFootnote;

  /// No description provided for @glowStart.
  ///
  /// In en, this message translates to:
  /// **'Glow quietly'**
  String get glowStart;

  /// No description provided for @cautionTitle.
  ///
  /// In en, this message translates to:
  /// **'First, take care of yourself'**
  String get cautionTitle;

  /// No description provided for @cautionBody.
  ///
  /// In en, this message translates to:
  /// **'GlucoCircle can\'t check or treat this. Follow the plan your doctor gave you. If you feel very unwell, get help now.'**
  String get cautionBody;

  /// No description provided for @cautionContinue.
  ///
  /// In en, this message translates to:
  /// **'I\'m okay, continue'**
  String get cautionContinue;

  /// No description provided for @glowingTimeLeft.
  ///
  /// In en, this message translates to:
  /// **'Glowing · {minutes} min left'**
  String glowingTimeLeft(int minutes);

  /// No description provided for @quietTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'re glowing quietly'**
  String get quietTitle;

  /// No description provided for @quietBody.
  ///
  /// In en, this message translates to:
  /// **'No one can message you. People who feel the same can only send warmth.'**
  String get quietBody;

  /// No description provided for @quietNoWarmth.
  ///
  /// In en, this message translates to:
  /// **'Warmth from others will show up here'**
  String get quietNoWarmth;

  /// No description provided for @quietWarmthCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 person sent you warmth} other{{count} people sent you warmth}}'**
  String quietWarmthCount(int count);

  /// No description provided for @quietGlowBack.
  ///
  /// In en, this message translates to:
  /// **'Glow back'**
  String get quietGlowBack;

  /// No description provided for @quietDim.
  ///
  /// In en, this message translates to:
  /// **'Dim my glow'**
  String get quietDim;

  /// No description provided for @glowFadedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your glow has faded'**
  String get glowFadedTitle;

  /// No description provided for @glowFadedBody.
  ///
  /// In en, this message translates to:
  /// **'Light it again whenever you need to.'**
  String get glowFadedBody;

  /// No description provided for @reportDangerSent.
  ///
  /// In en, this message translates to:
  /// **'If someone is in immediate danger, don\'t wait for us. Call {number} now.'**
  String reportDangerSent(String number);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
