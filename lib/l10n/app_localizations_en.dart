// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'EVP LEARN';

  @override
  String get brandDescriptor => 'ENGLISH FOR VOCATIONAL PURPOSES';

  @override
  String get splashRetail => 'Learning for the world of retail';

  @override
  String get navHome => 'Home';

  @override
  String get navModules => 'Modules';

  @override
  String get navProgress => 'Progress';

  @override
  String get navProfile => 'Profile';

  @override
  String get languageTitle => 'Bahasa / Language';

  @override
  String get languageIndonesian => 'Bahasa Indonesia';

  @override
  String get languageEnglish => 'English';

  @override
  String get apply => 'Apply';

  @override
  String get readyToLearn => 'Ready to learn?';

  @override
  String get startJourney =>
      'Start your English-learning journey for the world of retail.';

  @override
  String get exploreModules => 'Explore Modules';

  @override
  String get continueLearning => 'Continue Learning';

  @override
  String get learningProgress => 'Your Learning Progress';

  @override
  String get noProgressYet => 'Your learning journey starts here.';

  @override
  String modulesComplete(int count) {
    return '$count of 3 Modules Completed';
  }

  @override
  String get yourModules => 'Learning Modules';

  @override
  String get seeAll => 'See All';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get howToUse => 'How to Use';

  @override
  String get learningOutcomes => 'Learning Outcomes';

  @override
  String moduleLabel(int number) {
    return 'Module $number';
  }

  @override
  String percentComplete(int percent) {
    return '$percent% complete';
  }

  @override
  String get startModule => 'Start Module';

  @override
  String get continueModule => 'Continue Module';

  @override
  String get reviewModule => 'Review Module';

  @override
  String get notStarted => 'Not Started';

  @override
  String get inProgress => 'In Progress';

  @override
  String get completed => 'Completed';

  @override
  String get learningModules => 'Learning Modules';

  @override
  String get chooseModule => 'Choose any module to start learning.';

  @override
  String get yourProgress => 'Your Learning Progress';

  @override
  String get overallProgress => 'Overall Progress';

  @override
  String get moduleProgress => 'Module Progress';

  @override
  String get latestScore => 'Latest Score';

  @override
  String get bestScore => 'Best Score';

  @override
  String get startLearning => 'Start Learning';

  @override
  String get profileTitle => 'Researcher / Developer';

  @override
  String get profileSubtitle =>
      'This profile contains researcher information for the application development.';

  @override
  String get fullName => 'Full Name';

  @override
  String get studentId => 'Student ID / NIM';

  @override
  String get studyProgram => 'Study Program';

  @override
  String get faculty => 'Faculty';

  @override
  String get university => 'University';

  @override
  String get supervisors => 'Supervisor';

  @override
  String get researchTitle => 'Research Title';

  @override
  String get year => 'Year';

  @override
  String get guideTitle => 'How to Use the App';

  @override
  String get guideSubtitle => 'Learn at your own pace with these simple steps.';

  @override
  String get guideStep1 => 'Choose a Module';

  @override
  String get guideStep2 => 'Complete Pre-test';

  @override
  String get guideStep3 => 'Study the Material';

  @override
  String get guideStep4 => 'Explore Vocabulary & Audio';

  @override
  String get guideStep5 => 'Complete Interactive Practice';

  @override
  String get guideStep6 => 'Take Post-test';

  @override
  String get guideStep7 => 'Check Your Progress';

  @override
  String get outcomesTitle => 'Learning Outcomes';

  @override
  String get outcomesSubtitle => 'Kurikulum Merdeka · Phase E · Grade X SMK';

  @override
  String get outcome1 =>
      'Identify the social function of retail-related texts.';

  @override
  String get outcome2 => 'Recognize generic structures and language features.';

  @override
  String get outcome3 => 'Understand main ideas and detailed information.';

  @override
  String get outcome4 => 'Use retail vocabulary in meaningful contexts.';

  @override
  String get back => 'Back';

  @override
  String get languageSelector => 'Choose app language';

  @override
  String get moduleOverview => 'Module Overview';

  @override
  String get aboutThisModule => 'About This Module';

  @override
  String get learningJourney => 'Learning Journey';

  @override
  String get learningObjectives => 'Learning Objectives';

  @override
  String get learningObjectivesIntro => 'What you will learn in this module.';

  @override
  String get continueToPretest => 'Continue to Pre-test';

  @override
  String get theory => 'Theory';

  @override
  String get definitionAndPurpose => 'Definition & Purpose';

  @override
  String get genericStructure => 'Generic Structure';

  @override
  String get languageFeatures => 'Language Features';

  @override
  String get vocabularyPreview => 'Vocabulary Preview';

  @override
  String get continueToReading => 'Continue to Reading';

  @override
  String get reading => 'Reading';

  @override
  String get listenToReading => 'Listen to Reading';

  @override
  String get localAudio => 'Local audio';

  @override
  String get nextReading => 'Next Reading';

  @override
  String get interactivePractice => 'Interactive Practice';

  @override
  String get pretestGatewayDescription =>
      'Prepare to check your understanding before studying the material.';

  @override
  String get nextLearningActivity =>
      'Your next learning activity will be available here.';

  @override
  String get contentUnavailable => 'Content unavailable. Return to modules.';

  @override
  String get pretest => 'Pre-test';

  @override
  String get posttest => 'Post-test';

  @override
  String get question => 'Question';

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get answered => 'Answered';

  @override
  String get unanswered => 'Unanswered';

  @override
  String get submitAnswers => 'Submit answers';

  @override
  String get confirmSubmit => 'Review submission';

  @override
  String get continueAnswering => 'Continue answering';

  @override
  String submitConfirmMessage(int answered, int unanswered) {
    return 'You answered $answered questions and left $unanswered unanswered.';
  }

  @override
  String get pretestResult => 'Pre-test result';

  @override
  String get posttestResult => 'Post-test result';

  @override
  String get correctAnswers => 'Correct';

  @override
  String get incorrectAnswers => 'Incorrect';

  @override
  String get score => 'Score';

  @override
  String get weightedScore => 'Weighted score';

  @override
  String get diagnosticNote =>
      'This diagnostic score does not affect your final score.';

  @override
  String get continueToTheory => 'Continue to theory';

  @override
  String get continueToMaterial => 'Continue';

  @override
  String get finalScore => 'Final result';

  @override
  String get practiceScore => 'Practice';

  @override
  String get learningGain => 'Learning gain';

  @override
  String get tuntas => 'Completed — Tuntas';

  @override
  String get needsReview => 'Completed — Perlu Review';

  @override
  String get activity => 'Activity';

  @override
  String get ofLabel => 'of';

  @override
  String get matchSources => 'Sources';

  @override
  String get matchTargets => 'Targets';

  @override
  String get selected => 'Selected';

  @override
  String get unpaired => 'Unpaired';

  @override
  String get paired => 'Paired';

  @override
  String get checkAnswers => 'Check answers';

  @override
  String get resetActivity => 'Reset';

  @override
  String get nextActivity => 'Next activity';

  @override
  String get practiceSummary => 'Practice summary';

  @override
  String get practiceComplete => 'Practice complete';

  @override
  String get practiceTotal => 'Practice total';

  @override
  String get continueToPosttest => 'Continue to Post-test';

  @override
  String get practiceRequiredBeforePosttest =>
      'Complete all three Practice activities before starting the Post-test.';

  @override
  String get goToPractice => 'Go to Practice';

  @override
  String get finalResultUnavailable =>
      'Final results require a completed Pre-test, Practice, and Post-test for this module.';

  @override
  String get answerAllQuestions => 'Please answer all questions first.';

  @override
  String get practiceReadyToCheck => 'All items are ready to check.';

  @override
  String practiceCompletionStatus(int completed, int total) {
    return '$completed of $total items completed';
  }

  @override
  String get theoryVisualStory => 'Business story';

  @override
  String get theoryVisualRetail => 'Retail setting';

  @override
  String get theoryVisualProcess => 'Learning process';

  @override
  String get theoryVisualFounder => 'Founder story';

  @override
  String get theoryVisualFurniture => 'Furniture retail';

  @override
  String get theoryVisualAssembly => 'Flat-pack assembly';

  @override
  String get theoryVisualPos => 'POS terminal';

  @override
  String get theoryVisualShelves => 'Gondola shelving';

  @override
  String get theoryVisualJacket => 'Leather jacket';

  @override
  String get theoryVisualCheckout => 'Checkout flow';

  @override
  String get theoryVisualScan => 'Scan items';

  @override
  String get theoryVisualPayment => 'Payment step';

  @override
  String get theoryVisualReceipt => 'Receipt process';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get scoreOverview => 'Score overview';

  @override
  String get visualGuide => 'Visual guide';

  @override
  String get diagnosticResultTitle => 'Diagnostic result';

  @override
  String get posttestResultTitle => 'Post-test result';

  @override
  String get progressTitle => 'Learning Progress';

  @override
  String get modulesCompletedLabel => 'Modules Completed';

  @override
  String get currentAttemptTitle => 'Current attempt';

  @override
  String get evaluationHistory => 'Evaluation History';

  @override
  String get noEvaluationResults => 'No evaluation results yet';

  @override
  String get resultDetails => 'Result Details';

  @override
  String attemptLabel(int number) {
    return 'Attempt $number';
  }

  @override
  String get completedOn => 'Completed on';

  @override
  String get startedOn => 'Started on';

  @override
  String get continueLearningAction => 'Continue Learning';

  @override
  String get retryAction => 'Try Again';

  @override
  String get retryConfirmationTitle => 'Start a new attempt?';

  @override
  String get retryConfirmationMessage =>
      'Your previous results will be kept. A new attempt will start from the beginning.';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirm => 'Confirm';

  @override
  String get activeStage => 'Current stage';

  @override
  String get latestBadge => 'Latest';

  @override
  String get bestBadge => 'Best';

  @override
  String get passedStatus => 'Passed';

  @override
  String get needsReviewStatus => 'Needs Review';

  @override
  String get completedAttemptsLabel => 'Completed attempts';

  @override
  String get progressUnavailable => 'Progress details are unavailable.';

  @override
  String get backToProgress => 'Back to Progress';

  @override
  String get pretestRawLabel => 'Pre-test';

  @override
  String get practiceRawLabel => 'Practice';

  @override
  String get posttestRawLabel => 'Post-test raw';

  @override
  String get posttestWeightedLabel => 'Post-test weighted';

  @override
  String get finalScoreLabel => 'Final score';

  @override
  String get learningGainLabel => 'Learning gain';
}
