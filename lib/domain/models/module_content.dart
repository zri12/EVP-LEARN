enum ContentStatus {
  sourceFinal('source_final'),
  prototypeDerived('prototype_derived'),
  pendingValidation('pending_validation');

  const ContentStatus(this.jsonValue);

  final String jsonValue;

  static ContentStatus fromJson(Object? value) =>
      ContentStatus.values.firstWhere(
        (status) => status.jsonValue == value,
        orElse: () => throw FormatException('Unknown content status: $value'),
      );
}

enum PracticeKind {
  match('match'),
  sequence('sequence');

  const PracticeKind(this.jsonValue);

  final String jsonValue;

  static PracticeKind fromJson(Object? value) => PracticeKind.values.firstWhere(
    (kind) => kind.jsonValue == value,
    orElse: () => throw FormatException('Unknown practice kind: $value'),
  );
}

class ContentDocument {
  const ContentDocument({
    required this.schemaVersion,
    required this.contentVersion,
    required this.academicSource,
    required this.module,
  });

  final int schemaVersion;
  final int contentVersion;
  final String academicSource;
  final LearningModuleContent module;

  factory ContentDocument.fromJson(Map<String, dynamic> json) =>
      ContentDocument(
        schemaVersion: _int(json, 'schemaVersion'),
        contentVersion: _int(json, 'contentVersion'),
        academicSource: _string(json, 'academicSource'),
        module: LearningModuleContent.fromJson(_map(json, 'module')),
      );
}

class LearningModuleContent {
  const LearningModuleContent({
    required this.metadata,
    required this.objectives,
    required this.theory,
    required this.vocabulary,
    required this.readings,
    required this.pretest,
    required this.posttest,
    required this.practices,
  });

  final ModuleMetadata metadata;
  final List<LearningObjective> objectives;
  final TheoryContent theory;
  final List<VocabularyItem> vocabulary;
  final List<ReadingContent> readings;
  final QuestionBank pretest;
  final QuestionBank posttest;
  final List<PracticeDefinition> practices;

  factory LearningModuleContent.fromJson(Map<String, dynamic> json) =>
      LearningModuleContent(
        metadata: ModuleMetadata.fromJson(_map(json, 'metadata')),
        objectives: _maps(
          json,
          'objectives',
        ).map(LearningObjective.fromJson).toList(growable: false),
        theory: TheoryContent.fromJson(_map(json, 'theory')),
        vocabulary: _maps(
          json,
          'vocabulary',
        ).map(VocabularyItem.fromJson).toList(growable: false),
        readings: _maps(
          json,
          'readings',
        ).map(ReadingContent.fromJson).toList(growable: false),
        pretest: QuestionBank.fromJson(_map(json, 'pretest')),
        posttest: QuestionBank.fromJson(_map(json, 'posttest')),
        practices: _maps(
          json,
          'practices',
        ).map(PracticeDefinition.fromJson).toList(growable: false),
      );
}

class ModuleMetadata {
  const ModuleMetadata({
    required this.id,
    required this.number,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.overview,
    required this.contentStatus,
    required this.subtitleStatus,
  });

  final String id;
  final int number;
  final String type;
  final String title;
  final String subtitle;
  final String overview;
  final ContentStatus contentStatus;
  final ContentStatus subtitleStatus;

  factory ModuleMetadata.fromJson(Map<String, dynamic> json) => ModuleMetadata(
    id: _string(json, 'id'),
    number: _int(json, 'number'),
    type: _string(json, 'type'),
    title: _string(json, 'title'),
    subtitle: _string(json, 'subtitle'),
    overview: _string(json, 'overview'),
    contentStatus: ContentStatus.fromJson(json['contentStatus']),
    subtitleStatus: ContentStatus.fromJson(json['subtitleStatus']),
  );
}

class LearningObjective {
  const LearningObjective({
    required this.id,
    required this.text,
    required this.contentStatus,
  });

  final String id;
  final String text;
  final ContentStatus contentStatus;

  factory LearningObjective.fromJson(Map<String, dynamic> json) =>
      LearningObjective(
        id: _string(json, 'id'),
        text: _string(json, 'text'),
        contentStatus: ContentStatus.fromJson(json['contentStatus']),
      );
}

class TheoryContent {
  const TheoryContent({
    required this.contentStatus,
    required this.definition,
    required this.genericStructure,
    required this.languageFeatures,
  });

  final ContentStatus contentStatus;
  final String definition;
  final List<TheorySection> genericStructure;
  final List<TheorySection> languageFeatures;

  factory TheoryContent.fromJson(Map<String, dynamic> json) => TheoryContent(
    contentStatus: ContentStatus.fromJson(json['contentStatus']),
    definition: _string(json, 'definition'),
    genericStructure: _maps(
      json,
      'genericStructure',
    ).map(TheorySection.fromJson).toList(growable: false),
    languageFeatures: _maps(
      json,
      'languageFeatures',
    ).map(TheorySection.fromJson).toList(growable: false),
  );
}

class TheorySection {
  const TheorySection({
    required this.id,
    required this.heading,
    required this.detail,
  });

  final String id;
  final String heading;
  final String detail;

  factory TheorySection.fromJson(Map<String, dynamic> json) => TheorySection(
    id: _string(json, 'id'),
    heading: _string(json, 'heading'),
    detail: _string(json, 'detail'),
  );
}

class VocabularyItem {
  const VocabularyItem({
    required this.id,
    required this.term,
    required this.partOfSpeech,
    required this.meaning,
    required this.audioKey,
    required this.contentStatus,
  });

  final String id;
  final String term;
  final String partOfSpeech;
  final String meaning;
  final String audioKey;
  final ContentStatus contentStatus;

  factory VocabularyItem.fromJson(Map<String, dynamic> json) => VocabularyItem(
    id: _string(json, 'id'),
    term: _string(json, 'term'),
    partOfSpeech: _string(json, 'partOfSpeech'),
    meaning: _string(json, 'meaning'),
    audioKey: _string(json, 'audioKey'),
    contentStatus: ContentStatus.fromJson(json['contentStatus']),
  );
}

class ReadingContent {
  const ReadingContent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.imageKey,
    required this.readingAudioKey,
    required this.contentStatus,
    required this.sections,
    required this.glossary,
  });

  final String id;
  final String title;
  final String subtitle;
  final String category;
  final String? imageKey;
  final String readingAudioKey;
  final ContentStatus contentStatus;
  final List<ReadingSection> sections;
  final List<GlossaryItem> glossary;

  factory ReadingContent.fromJson(Map<String, dynamic> json) => ReadingContent(
    id: _string(json, 'id'),
    title: _string(json, 'title'),
    subtitle: _string(json, 'subtitle'),
    category: _string(json, 'category'),
    imageKey: json['imageKey'] as String?,
    readingAudioKey: _string(json, 'readingAudioKey'),
    contentStatus: ContentStatus.fromJson(json['contentStatus']),
    sections: _maps(
      json,
      'sections',
    ).map(ReadingSection.fromJson).toList(growable: false),
    glossary: _maps(
      json,
      'glossary',
    ).map(GlossaryItem.fromJson).toList(growable: false),
  );
}

class ReadingSection {
  const ReadingSection({
    required this.id,
    required this.heading,
    required this.body,
    required this.glossaryIds,
  });

  final String id;
  final String heading;
  final String body;
  final List<String> glossaryIds;

  factory ReadingSection.fromJson(Map<String, dynamic> json) => ReadingSection(
    id: _string(json, 'id'),
    heading: _string(json, 'heading'),
    body: _string(json, 'body'),
    glossaryIds: _strings(json, 'glossaryIds'),
  );
}

class GlossaryItem {
  const GlossaryItem({
    required this.id,
    required this.term,
    required this.partOfSpeech,
    required this.meaning,
    required this.audioKey,
    required this.contentStatus,
  });

  final String id;
  final String term;
  final String partOfSpeech;
  final String meaning;
  final String audioKey;
  final ContentStatus contentStatus;

  factory GlossaryItem.fromJson(Map<String, dynamic> json) => GlossaryItem(
    id: _string(json, 'id'),
    term: _string(json, 'term'),
    partOfSpeech: _string(json, 'partOfSpeech'),
    meaning: _string(json, 'meaning'),
    audioKey: _string(json, 'audioKey'),
    contentStatus: ContentStatus.fromJson(json['contentStatus']),
  );
}

class QuestionBank {
  const QuestionBank({
    required this.id,
    required this.contentStatus,
    required this.questions,
  });

  final String id;
  final ContentStatus contentStatus;
  final List<AssessmentQuestion> questions;

  factory QuestionBank.fromJson(Map<String, dynamic> json) => QuestionBank(
    id: _string(json, 'id'),
    contentStatus: ContentStatus.fromJson(json['contentStatus']),
    questions: _maps(
      json,
      'questions',
    ).map(AssessmentQuestion.fromJson).toList(growable: false),
  );
}

class AssessmentQuestion {
  const AssessmentQuestion({
    required this.id,
    required this.prompt,
    required this.options,
    required this.correctOptionIndex,
    required this.imageKey,
    required this.feedback,
    required this.contentStatus,
  });

  final String id;
  final String prompt;
  final List<String> options;
  final int correctOptionIndex;
  final String? imageKey;
  final String? feedback;
  final ContentStatus contentStatus;

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) =>
      AssessmentQuestion(
        id: _string(json, 'id'),
        prompt: _string(json, 'prompt'),
        options: _strings(json, 'options'),
        correctOptionIndex: _int(json, 'correctOptionIndex'),
        imageKey: json['imageKey'] as String?,
        feedback: json['feedback'] as String?,
        contentStatus: ContentStatus.fromJson(json['contentStatus']),
      );
}

class PracticeDefinition {
  const PracticeDefinition({
    required this.id,
    required this.kind,
    required this.sourceInteraction,
    required this.title,
    required this.instruction,
    required this.contentStatus,
    required this.sourceItems,
    required this.targetItems,
    required this.answerMappings,
    required this.sequenceItems,
    required this.expectedOrder,
  });

  final String id;
  final PracticeKind kind;
  final String sourceInteraction;
  final String title;
  final String instruction;
  final ContentStatus contentStatus;
  final List<PracticeItem> sourceItems;
  final List<PracticeItem> targetItems;
  final List<PracticeAnswerMapping> answerMappings;
  final List<PracticeItem> sequenceItems;
  final List<String> expectedOrder;

  factory PracticeDefinition.fromJson(Map<String, dynamic> json) =>
      PracticeDefinition(
        id: _string(json, 'id'),
        kind: PracticeKind.fromJson(json['kind']),
        sourceInteraction: _string(json, 'sourceInteraction'),
        title: _string(json, 'title'),
        instruction: _string(json, 'instruction'),
        contentStatus: ContentStatus.fromJson(json['contentStatus']),
        sourceItems: _maps(
          json,
          'sourceItems',
        ).map(PracticeItem.fromJson).toList(growable: false),
        targetItems: _maps(
          json,
          'targetItems',
        ).map(PracticeItem.fromJson).toList(growable: false),
        answerMappings: _maps(
          json,
          'answerMappings',
        ).map(PracticeAnswerMapping.fromJson).toList(growable: false),
        sequenceItems: _maps(
          json,
          'sequenceItems',
        ).map(PracticeItem.fromJson).toList(growable: false),
        expectedOrder: _strings(json, 'expectedOrder'),
      );
}

class PracticeItem {
  const PracticeItem({required this.id, required this.label});

  final String id;
  final String label;

  factory PracticeItem.fromJson(Map<String, dynamic> json) =>
      PracticeItem(id: _string(json, 'id'), label: _string(json, 'label'));
}

class PracticeAnswerMapping {
  const PracticeAnswerMapping({required this.sourceId, required this.targetId});

  final String sourceId;
  final String targetId;

  factory PracticeAnswerMapping.fromJson(Map<String, dynamic> json) =>
      PracticeAnswerMapping(
        sourceId: _string(json, 'sourceId'),
        targetId: _string(json, 'targetId'),
      );
}

String _string(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is String && value.isNotEmpty) return value;
  throw FormatException('Expected a non-empty string at $key.');
}

int _int(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is int) return value;
  throw FormatException('Expected an integer at $key.');
}

Map<String, dynamic> _map(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is Map<String, dynamic>) return value;
  throw FormatException('Expected an object at $key.');
}

List<Map<String, dynamic>> _maps(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List) return value.cast<Map<String, dynamic>>();
  throw FormatException('Expected an array at $key.');
}

List<String> _strings(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value is List &&
      value.every((item) => item is String && item.isNotEmpty)) {
    return value.cast<String>();
  }
  throw FormatException('Expected a non-empty string array at $key.');
}
