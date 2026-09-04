import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'EVP LEARN'**
  String get appName;

  /// No description provided for @brandDescriptor.
  ///
  /// In en, this message translates to:
  /// **'ENGLISH FOR VOCATIONAL PURPOSES'**
  String get brandDescriptor;

  /// No description provided for @splashRetail.
  ///
  /// In en, this message translates to:
  /// **'Learning for the world of retail'**
  String get splashRetail;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navModules.
  ///
  /// In en, this message translates to:
  /// **'Modules'**
  String get navModules;

  /// No description provided for @navProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get navProgress;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @languageTitle.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// No description provided for @languageIndonesian.
  ///
  /// In en, this message translates to:
  /// **'Bahasa Indonesia'**
  String get languageIndonesian;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @readyToLearn.
  ///
  /// In en, this message translates to:
  /// **'Ready to learn?'**
  String get readyToLearn;

  /// No description provided for @startJourney.
  ///
  /// In en, this message translates to:
  /// **'Start your English-learning journey for the world of retail.'**
  String get startJourney;

  /// No description provided for @exploreModules.
  ///
  /// In en, this message translates to:
  /// **'Explore Modules'**
  String get exploreModules;

  /// No description provided for @continueLearning.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get continueLearning;

  /// No description provided for @learningProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Learning Progress'**
  String get learningProgress;

  /// No description provided for @noProgressYet.
  ///
  /// In en, this message translates to:
  /// **'Your learning journey starts here.'**
  String get noProgressYet;

  /// No description provided for @modulesComplete.
  ///
  /// In en, this message translates to:
  /// **'{count} of 3 Modules Completed'**
  String modulesComplete(int count);

  /// No description provided for @yourModules.
  ///
  /// In en, this message translates to:
  /// **'Learning Modules'**
  String get yourModules;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to Use'**
  String get howToUse;

  /// No description provided for @learningOutcomes.
  ///
  /// In en, this message translates to:
  /// **'Learning Outcomes'**
  String get learningOutcomes;

  /// No description provided for @moduleLabel.
  ///
  /// In en, this message translates to:
  /// **'Module {number}'**
  String moduleLabel(int number);

  /// No description provided for @percentComplete.
  ///
  /// In en, this message translates to:
  /// **'{percent}% complete'**
  String percentComplete(int percent);

  /// No description provided for @startModule.
  ///
  /// In en, this message translates to:
  /// **'Start Module'**
  String get startModule;

  /// No description provided for @continueModule.
  ///
  /// In en, this message translates to:
  /// **'Continue Module'**
  String get continueModule;

  /// No description provided for @reviewModule.
  ///
  /// In en, this message translates to:
  /// **'Review Module'**
  String get reviewModule;

  /// No description provided for @notStarted.
  ///
  /// In en, this message translates to:
  /// **'Not Started'**
  String get notStarted;

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @learningModules.
  ///
  /// In en, this message translates to:
  /// **'Learning Modules'**
  String get learningModules;

  /// No description provided for @chooseModule.
  ///
  /// In en, this message translates to:
  /// **'Choose any module to start learning.'**
  String get chooseModule;

  /// No description provided for @yourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Learning Progress'**
  String get yourProgress;

  /// No description provided for @overallProgress.
  ///
  /// In en, this message translates to:
  /// **'Overall Progress'**
  String get overallProgress;

  /// No description provided for @moduleProgress.
  ///
  /// In en, this message translates to:
  /// **'Module Progress'**
  String get moduleProgress;

  /// No description provided for @latestScore.
  ///
  /// In en, this message translates to:
  /// **'Latest Score'**
  String get latestScore;

  /// No description provided for @bestScore.
  ///
  /// In en, this message translates to:
  /// **'Best Score'**
  String get bestScore;

  /// No description provided for @startLearning.
  ///
  /// In en, this message translates to:
  /// **'Start Learning'**
  String get startLearning;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Researcher / Developer'**
  String get profileTitle;

  /// No description provided for @profileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'This profile contains researcher information for the application development.'**
  String get profileSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @studentId.
  ///
  /// In en, this message translates to:
  /// **'Student ID / NIM'**
  String get studentId;

  /// No description provided for @studyProgram.
  ///
  /// In en, this message translates to:
  /// **'Study Program'**
  String get studyProgram;

  /// No description provided for @faculty.
  ///
  /// In en, this message translates to:
  /// **'Faculty'**
  String get faculty;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University'**
  String get university;

  /// No description provided for @supervisors.
  ///
  /// In en, this message translates to:
  /// **'Supervisor'**
  String get supervisors;

  /// No description provided for @researchTitle.
  ///
  /// In en, this message translates to:
  /// **'Research Title'**
  String get researchTitle;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @guideTitle.
  ///
  /// In en, this message translates to:
  /// **'How to Use the App'**
  String get guideTitle;

  /// No description provided for @guideSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Learn at your own pace with these simple steps.'**
  String get guideSubtitle;

  /// No description provided for @guideStep1.
  ///
  /// In en, this message translates to:
  /// **'Choose a Module'**
  String get guideStep1;

  /// No description provided for @guideStep2.
  ///
  /// In en, this message translates to:
  /// **'Complete Pre-test'**
  String get guideStep2;

  /// No description provided for @guideStep3.
  ///
  /// In en, this message translates to:
  /// **'Study the Material'**
  String get guideStep3;

  /// No description provided for @guideStep4.
  ///
  /// In en, this message translates to:
  /// **'Explore Vocabulary & Audio'**
  String get guideStep4;

  /// No description provided for @guideStep5.
  ///
  /// In en, this message translates to:
  /// **'Complete Interactive Practice'**
  String get guideStep5;

  /// No description provided for @guideStep6.
  ///
  /// In en, this message translates to:
  /// **'Take Post-test'**
  String get guideStep6;

  /// No description provided for @guideStep7.
  ///
  /// In en, this message translates to:
  /// **'Check Your Progress'**
  String get guideStep7;

  /// No description provided for @outcomesTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Outcomes'**
  String get outcomesTitle;

  /// No description provided for @outcomesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Kurikulum Merdeka · Phase E · Grade X SMK'**
  String get outcomesSubtitle;

  /// No description provided for @outcome1.
  ///
  /// In en, this message translates to:
  /// **'Identify the social function of retail-related texts.'**
  String get outcome1;

  /// No description provided for @outcome2.
  ///
  /// In en, this message translates to:
  /// **'Recognize generic structures and language features.'**
  String get outcome2;

  /// No description provided for @outcome3.
  ///
  /// In en, this message translates to:
  /// **'Understand main ideas and detailed information.'**
  String get outcome3;

  /// No description provided for @outcome4.
  ///
  /// In en, this message translates to:
  /// **'Use retail vocabulary in meaningful contexts.'**
  String get outcome4;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @languageSelector.
  ///
  /// In en, this message translates to:
  /// **'Choose app language'**
  String get languageSelector;

  /// No description provided for @moduleOverview.
  ///
  /// In en, this message translates to:
  /// **'Module Overview'**
  String get moduleOverview;

  /// No description provided for @aboutThisModule.
  ///
  /// In en, this message translates to:
  /// **'About This Module'**
  String get aboutThisModule;

  /// No description provided for @learningJourney.
  ///
  /// In en, this message translates to:
  /// **'Learning Journey'**
  String get learningJourney;

  /// No description provided for @learningObjectives.
  ///
  /// In en, this message translates to:
  /// **'Learning Objectives'**
  String get learningObjectives;

  /// No description provided for @learningObjectivesIntro.
  ///
  /// In en, this message translates to:
  /// **'What you will learn in this module.'**
  String get learningObjectivesIntro;

  /// No description provided for @continueToPretest.
  ///
  /// In en, this message translates to:
  /// **'Continue to Pre-test'**
  String get continueToPretest;

  /// No description provided for @theory.
  ///
  /// In en, this message translates to:
  /// **'Theory'**
  String get theory;

  /// No description provided for @definitionAndPurpose.
  ///
  /// In en, this message translates to:
  /// **'Definition & Purpose'**
  String get definitionAndPurpose;

  /// No description provided for @genericStructure.
  ///
  /// In en, this message translates to:
  /// **'Generic Structure'**
  String get genericStructure;

  /// No description provided for @languageFeatures.
  ///
  /// In en, this message translates to:
  /// **'Language Features'**
  String get languageFeatures;

  /// No description provided for @vocabularyPreview.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary Preview'**
  String get vocabularyPreview;

  /// No description provided for @continueToReading.
  ///
  /// In en, this message translates to:
  /// **'Continue to Reading'**
  String get continueToReading;

  /// No description provided for @reading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get reading;

  /// No description provided for @listenToReading.
  ///
  /// In en, this message translates to:
  /// **'Listen to Reading'**
  String get listenToReading;

  /// No description provided for @localAudio.
  ///
  /// In en, this message translates to:
  /// **'Local audio'**
  String get localAudio;

  /// No description provided for @nextReading.
  ///
  /// In en, this message translates to:
  /// **'Next Reading'**
  String get nextReading;

  /// No description provided for @interactivePractice.
  ///
  /// In en, this message translates to:
  /// **'Interactive Practice'**
  String get interactivePractice;

  /// No description provided for @pretestGatewayDescription.
  ///
  /// In en, this message translates to:
  /// **'Prepare to check your understanding before studying the material.'**
  String get pretestGatewayDescription;

  /// No description provided for @nextLearningActivity.
  ///
  /// In en, this message translates to:
  /// **'Your next learning activity will be available here.'**
  String get nextLearningActivity;

  /// No description provided for @contentUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Content unavailable. Return to modules.'**
  String get contentUnavailable;

  /// No description provided for @progressValue.
  ///
  /// In en, this message translates to:
  /// **'Progress {percent}%'**
  String progressValue(Object percent);

  /// No description provided for @playPronunciation.
  ///
  /// In en, this message translates to:
  /// **'Play pronunciation for {term}'**
  String playPronunciation(Object term);

  /// No description provided for @replayPronunciation.
  ///
  /// In en, this message translates to:
  /// **'Replay pronunciation for {term}'**
  String replayPronunciation(Object term);

  /// No description provided for @pausePronunciation.
  ///
  /// In en, this message translates to:
  /// **'Pause pronunciation for {term}'**
  String pausePronunciation(Object term);

  /// No description provided for @playReadingAudio.
  ///
  /// In en, this message translates to:
  /// **'Play reading audio'**
  String get playReadingAudio;

  /// No description provided for @replayReadingAudio.
  ///
  /// In en, this message translates to:
  /// **'Replay reading audio'**
  String get replayReadingAudio;

  /// No description provided for @pauseReadingAudio.
  ///
  /// In en, this message translates to:
  /// **'Pause reading audio'**
  String get pauseReadingAudio;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @backToObjectives.
  ///
  /// In en, this message translates to:
  /// **'Back to Learning Objectives'**
  String get backToObjectives;

  /// No description provided for @dragSourceHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to match'**
  String get dragSourceHint;

  /// No description provided for @dropTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Tap or drop an item here to match'**
  String get dropTargetHint;

  /// No description provided for @reorderHint.
  ///
  /// In en, this message translates to:
  /// **'Drag to reorder'**
  String get reorderHint;

  /// No description provided for @glossaryHint.
  ///
  /// In en, this message translates to:
  /// **'Open definition for {term}'**
  String glossaryHint(Object term);

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailable;

  /// No description provided for @pretest.
  ///
  /// In en, this message translates to:
  /// **'Pre-test'**
  String get pretest;

  /// No description provided for @posttest.
  ///
  /// In en, this message translates to:
  /// **'Post-test'**
  String get posttest;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @answered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get answered;

  /// No description provided for @unanswered.
  ///
  /// In en, this message translates to:
  /// **'Unanswered'**
  String get unanswered;

  /// No description provided for @submitAnswers.
  ///
  /// In en, this message translates to:
  /// **'Submit answers'**
  String get submitAnswers;

  /// No description provided for @confirmSubmit.
  ///
  /// In en, this message translates to:
  /// **'Review submission'**
  String get confirmSubmit;

  /// No description provided for @continueAnswering.
  ///
  /// In en, this message translates to:
  /// **'Continue answering'**
  String get continueAnswering;

  /// No description provided for @submitConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'You answered {answered} questions and left {unanswered} unanswered.'**
  String submitConfirmMessage(int answered, int unanswered);

  /// No description provided for @pretestResult.
  ///
  /// In en, this message translates to:
  /// **'Pre-test result'**
  String get pretestResult;

  /// No description provided for @posttestResult.
  ///
  /// In en, this message translates to:
  /// **'Post-test result'**
  String get posttestResult;

  /// No description provided for @correctAnswers.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correctAnswers;

  /// No description provided for @incorrectAnswers.
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrectAnswers;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @weightedScore.
  ///
  /// In en, this message translates to:
  /// **'Weighted score'**
  String get weightedScore;

  /// No description provided for @diagnosticNote.
  ///
  /// In en, this message translates to:
  /// **'This diagnostic score does not affect your final score.'**
  String get diagnosticNote;

  /// No description provided for @continueToTheory.
  ///
  /// In en, this message translates to:
  /// **'Continue to theory'**
  String get continueToTheory;

  /// No description provided for @continueToMaterial.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueToMaterial;

  /// No description provided for @finalScore.
  ///
  /// In en, this message translates to:
  /// **'Final result'**
  String get finalScore;

  /// No description provided for @practiceScore.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practiceScore;

  /// No description provided for @learningGain.
  ///
  /// In en, this message translates to:
  /// **'Learning gain'**
  String get learningGain;

  /// No description provided for @tuntas.
  ///
  /// In en, this message translates to:
  /// **'Completed — Passed'**
  String get tuntas;

  /// No description provided for @needsReview.
  ///
  /// In en, this message translates to:
  /// **'Completed — Needs Review'**
  String get needsReview;

  /// No description provided for @activity.
  ///
  /// In en, this message translates to:
  /// **'Activity'**
  String get activity;

  /// No description provided for @ofLabel.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofLabel;

  /// No description provided for @matchSources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get matchSources;

  /// No description provided for @matchTargets.
  ///
  /// In en, this message translates to:
  /// **'Targets'**
  String get matchTargets;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @unpaired.
  ///
  /// In en, this message translates to:
  /// **'Unpaired'**
  String get unpaired;

  /// No description provided for @paired.
  ///
  /// In en, this message translates to:
  /// **'Paired'**
  String get paired;

  /// No description provided for @checkAnswers.
  ///
  /// In en, this message translates to:
  /// **'Check answers'**
  String get checkAnswers;

  /// No description provided for @resetActivity.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetActivity;

  /// No description provided for @nextActivity.
  ///
  /// In en, this message translates to:
  /// **'Next activity'**
  String get nextActivity;

  /// No description provided for @practiceSummary.
  ///
  /// In en, this message translates to:
  /// **'Practice summary'**
  String get practiceSummary;

  /// No description provided for @practiceComplete.
  ///
  /// In en, this message translates to:
  /// **'Practice complete'**
  String get practiceComplete;

  /// No description provided for @practiceTotal.
  ///
  /// In en, this message translates to:
  /// **'Practice total'**
  String get practiceTotal;

  /// No description provided for @continueToPosttest.
  ///
  /// In en, this message translates to:
  /// **'Continue to Post-test'**
  String get continueToPosttest;

  /// No description provided for @practiceRequiredBeforePosttest.
  ///
  /// In en, this message translates to:
  /// **'Complete all three Practice activities before starting the Post-test.'**
  String get practiceRequiredBeforePosttest;

  /// No description provided for @goToPractice.
  ///
  /// In en, this message translates to:
  /// **'Go to Practice'**
  String get goToPractice;

  /// No description provided for @finalResultUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Final results require a completed Pre-test, Practice, and Post-test for this module.'**
  String get finalResultUnavailable;

  /// No description provided for @answerAllQuestions.
  ///
  /// In en, this message translates to:
  /// **'Please answer all questions first.'**
  String get answerAllQuestions;

  /// No description provided for @practiceReadyToCheck.
  ///
  /// In en, this message translates to:
  /// **'All items are ready to check.'**
  String get practiceReadyToCheck;

  /// No description provided for @practiceCompletionStatus.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} items completed'**
  String practiceCompletionStatus(int completed, int total);

  /// No description provided for @theoryVisualStory.
  ///
  /// In en, this message translates to:
  /// **'Business story'**
  String get theoryVisualStory;

  /// No description provided for @theoryVisualRetail.
  ///
  /// In en, this message translates to:
  /// **'Retail setting'**
  String get theoryVisualRetail;

  /// No description provided for @theoryVisualProcess.
  ///
  /// In en, this message translates to:
  /// **'Learning process'**
  String get theoryVisualProcess;

  /// No description provided for @theoryVisualFounder.
  ///
  /// In en, this message translates to:
  /// **'Founder story'**
  String get theoryVisualFounder;

  /// No description provided for @theoryVisualFurniture.
  ///
  /// In en, this message translates to:
  /// **'Furniture retail'**
  String get theoryVisualFurniture;

  /// No description provided for @theoryVisualAssembly.
  ///
  /// In en, this message translates to:
  /// **'Flat-pack assembly'**
  String get theoryVisualAssembly;

  /// No description provided for @theoryVisualPos.
  ///
  /// In en, this message translates to:
  /// **'POS terminal'**
  String get theoryVisualPos;

  /// No description provided for @theoryVisualShelves.
  ///
  /// In en, this message translates to:
  /// **'Gondola shelving'**
  String get theoryVisualShelves;

  /// No description provided for @theoryVisualJacket.
  ///
  /// In en, this message translates to:
  /// **'Leather jacket'**
  String get theoryVisualJacket;

  /// No description provided for @theoryVisualCheckout.
  ///
  /// In en, this message translates to:
  /// **'Checkout flow'**
  String get theoryVisualCheckout;

  /// No description provided for @theoryVisualScan.
  ///
  /// In en, this message translates to:
  /// **'Scan items'**
  String get theoryVisualScan;

  /// No description provided for @theoryVisualPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment step'**
  String get theoryVisualPayment;

  /// No description provided for @theoryVisualReceipt.
  ///
  /// In en, this message translates to:
  /// **'Receipt process'**
  String get theoryVisualReceipt;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @scoreOverview.
  ///
  /// In en, this message translates to:
  /// **'Score overview'**
  String get scoreOverview;

  /// No description provided for @visualGuide.
  ///
  /// In en, this message translates to:
  /// **'Visual guide'**
  String get visualGuide;

  /// No description provided for @diagnosticResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Diagnostic result'**
  String get diagnosticResultTitle;

  /// No description provided for @posttestResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Post-test result'**
  String get posttestResultTitle;

  /// No description provided for @progressTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Progress'**
  String get progressTitle;

  /// No description provided for @modulesCompletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Modules Completed'**
  String get modulesCompletedLabel;

  /// No description provided for @currentAttemptTitle.
  ///
  /// In en, this message translates to:
  /// **'Current attempt'**
  String get currentAttemptTitle;

  /// No description provided for @evaluationHistory.
  ///
  /// In en, this message translates to:
  /// **'Evaluation History'**
  String get evaluationHistory;

  /// No description provided for @noEvaluationResults.
  ///
  /// In en, this message translates to:
  /// **'No evaluation results yet'**
  String get noEvaluationResults;

  /// No description provided for @resultDetails.
  ///
  /// In en, this message translates to:
  /// **'Result Details'**
  String get resultDetails;

  /// No description provided for @attemptLabel.
  ///
  /// In en, this message translates to:
  /// **'Attempt {number}'**
  String attemptLabel(int number);

  /// No description provided for @completedOn.
  ///
  /// In en, this message translates to:
  /// **'Completed on'**
  String get completedOn;

  /// No description provided for @startedOn.
  ///
  /// In en, this message translates to:
  /// **'Started on'**
  String get startedOn;

  /// No description provided for @continueLearningAction.
  ///
  /// In en, this message translates to:
  /// **'Continue Learning'**
  String get continueLearningAction;

  /// No description provided for @retryAction.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get retryAction;

  /// No description provided for @retryConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Start a new attempt?'**
  String get retryConfirmationTitle;

  /// No description provided for @retryConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Your previous results will be kept. A new attempt will start from the beginning.'**
  String get retryConfirmationMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @activeStage.
  ///
  /// In en, this message translates to:
  /// **'Current stage'**
  String get activeStage;

  /// No description provided for @latestBadge.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latestBadge;

  /// No description provided for @bestBadge.
  ///
  /// In en, this message translates to:
  /// **'Best'**
  String get bestBadge;

  /// No description provided for @passedStatus.
  ///
  /// In en, this message translates to:
  /// **'Passed'**
  String get passedStatus;

  /// No description provided for @needsReviewStatus.
  ///
  /// In en, this message translates to:
  /// **'Needs Review'**
  String get needsReviewStatus;

  /// No description provided for @completedAttemptsLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed attempts'**
  String get completedAttemptsLabel;

  /// No description provided for @progressUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Progress details are unavailable.'**
  String get progressUnavailable;

  /// No description provided for @backToProgress.
  ///
  /// In en, this message translates to:
  /// **'Back to Progress'**
  String get backToProgress;

  /// No description provided for @pretestRawLabel.
  ///
  /// In en, this message translates to:
  /// **'Pre-test'**
  String get pretestRawLabel;

  /// No description provided for @practiceRawLabel.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practiceRawLabel;

  /// No description provided for @posttestRawLabel.
  ///
  /// In en, this message translates to:
  /// **'Post-test raw'**
  String get posttestRawLabel;

  /// No description provided for @posttestWeightedLabel.
  ///
  /// In en, this message translates to:
  /// **'Post-test weighted'**
  String get posttestWeightedLabel;

  /// No description provided for @finalScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'Final score'**
  String get finalScoreLabel;

  /// No description provided for @learningGainLabel.
  ///
  /// In en, this message translates to:
  /// **'Learning gain'**
  String get learningGainLabel;
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
      <String>['en', 'id'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
