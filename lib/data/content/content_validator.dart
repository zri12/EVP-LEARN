import '../../domain/models/module_content.dart';

class ContentValidationReport {
  const ContentValidationReport(this.errors);

  final List<String> errors;

  bool get isValid => errors.isEmpty;

  void throwIfInvalid() {
    if (!isValid) throw ContentValidationException(errors);
  }
}

class ContentValidationException implements Exception {
  const ContentValidationException(this.errors);

  final List<String> errors;

  @override
  String toString() => 'Content validation failed:\n${errors.join('\n')}';
}

class ContentValidator {
  static const schemaVersion = 1;
  static const contentVersion = 1;
  static const canonicalAcademicSource =
      'UI-APK PEMB B.INGGRIS/src/imports/MATERI_AFRIDA.docx';

  ContentValidationReport validate(List<ContentDocument> documents) {
    final errors = <String>[];
    final modules = documents.map((document) => document.module).toList();

    _validateDocuments(documents, errors);
    _validateModuleInventory(modules, errors);
    _validateContentCounts(modules, errors);
    _validateIds(modules, errors);
    _validateAssessments(modules, errors);
    _validatePractices(modules, errors);
    _validateStatuses(modules, errors);
    _validateGlossaryAndAudio(modules, errors);
    _validateRequiredTerms(modules, errors);

    return ContentValidationReport(List.unmodifiable(errors));
  }

  void _validateDocuments(
    List<ContentDocument> documents,
    List<String> errors,
  ) {
    for (final document in documents) {
      if (document.schemaVersion != schemaVersion) {
        errors.add(
          'Unexpected schema version for ${document.module.metadata.id}.',
        );
      }
      if (document.contentVersion != contentVersion) {
        errors.add(
          'Unexpected content version for ${document.module.metadata.id}.',
        );
      }
      if (document.academicSource != canonicalAcademicSource) {
        errors.add(
          'Unexpected academic source for ${document.module.metadata.id}.',
        );
      }
    }
  }

  void _validateModuleInventory(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    if (modules.length != 3) errors.add('Expected exactly 3 modules.');
    final moduleIds = modules.map((module) => module.metadata.id).toSet();
    if (moduleIds.length != modules.length) {
      errors.add('Module IDs are not unique.');
    }
    final numbers = modules.map((module) => module.metadata.number).toSet();
    if (!numbers.containsAll({1, 2, 3}) || numbers.length != 3) {
      errors.add('Module numbers must be exactly 1, 2, and 3.');
    }
  }

  void _validateContentCounts(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    if (modules.any((module) => module.vocabulary.length != 5)) {
      errors.add('Each module must contain 5 vocabulary items.');
    }
    if (modules.fold<int>(
          0,
          (total, module) => total + module.vocabulary.length,
        ) !=
        15) {
      errors.add('Expected 15 vocabulary items.');
    }

    final expectedReadingCounts = {'module_1': 1, 'module_2': 3, 'module_3': 1};
    for (final module in modules) {
      if (module.readings.length != expectedReadingCounts[module.metadata.id]) {
        errors.add('Unexpected reading count for ${module.metadata.id}.');
      }
      if (module.pretest.questions.length != 10 ||
          module.posttest.questions.length != 10) {
        errors.add(
          '${module.metadata.id} must contain 10 Pre-test and 10 Post-test questions.',
        );
      }
      if (module.practices.length != 3) {
        errors.add('${module.metadata.id} must contain 3 practices.');
      }
    }

    if (modules.fold<int>(
          0,
          (total, module) => total + module.readings.length,
        ) !=
        5) {
      errors.add('Expected 5 readings.');
    }
    if (modules.fold<int>(
          0,
          (total, module) => total + module.pretest.questions.length,
        ) !=
        30) {
      errors.add('Expected 30 Pre-test questions.');
    }
    if (modules.fold<int>(
          0,
          (total, module) => total + module.posttest.questions.length,
        ) !=
        30) {
      errors.add('Expected 30 Post-test questions.');
    }
    if (modules.fold<int>(
          0,
          (total, module) => total + module.practices.length,
        ) !=
        9) {
      errors.add('Expected 9 practices.');
    }
  }

  void _validateIds(List<LearningModuleContent> modules, List<String> errors) {
    final ids = <String>[];
    for (final module in modules) {
      ids.add(module.metadata.id);
      ids.addAll(module.objectives.map((item) => item.id));
      ids.addAll(module.theory.genericStructure.map((item) => item.id));
      ids.addAll(module.theory.languageFeatures.map((item) => item.id));
      ids.addAll(module.vocabulary.map((item) => item.id));
      ids.add(module.pretest.id);
      ids.add(module.posttest.id);
      ids.addAll(module.pretest.questions.map((item) => item.id));
      ids.addAll(module.posttest.questions.map((item) => item.id));
      for (final reading in module.readings) {
        ids.add(reading.id);
        ids.addAll(reading.sections.map((item) => item.id));
        ids.addAll(reading.glossary.map((item) => item.id));
      }
      for (final practice in module.practices) {
        ids.add(practice.id);
        ids.addAll(practice.sourceItems.map((item) => item.id));
        ids.addAll(practice.targetItems.map((item) => item.id));
        ids.addAll(practice.sequenceItems.map((item) => item.id));
      }
    }
    if (ids.toSet().length != ids.length) {
      errors.add('All content IDs must be unique.');
    }
  }

  void _validateAssessments(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    for (final module in modules) {
      for (final question in [
        ...module.pretest.questions,
        ...module.posttest.questions,
      ]) {
        if (question.prompt.trim().isEmpty) {
          errors.add('Question ${question.id} has an empty prompt.');
        }
        if (question.options.length != 4 ||
            question.options.any((option) => option.trim().isEmpty)) {
          errors.add(
            'Question ${question.id} must have exactly four non-empty options.',
          );
        }
        if (question.correctOptionIndex < 0 ||
            question.correctOptionIndex > 3) {
          errors.add(
            'Question ${question.id} has an invalid correct option index.',
          );
        }
      }
    }
  }

  void _validatePractices(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    for (final practice in modules.expand((module) => module.practices)) {
      if (practice.kind == PracticeKind.match) {
        final sourceIds = practice.sourceItems.map((item) => item.id).toSet();
        final targetIds = practice.targetItems.map((item) => item.id).toSet();
        final mappedSources = practice.answerMappings
            .map((mapping) => mapping.sourceId)
            .toSet();
        final mappedTargets = practice.answerMappings
            .map((mapping) => mapping.targetId)
            .toSet();
        if (sourceIds.isEmpty ||
            targetIds.isEmpty ||
            !sourceIds.containsAll(mappedSources) ||
            !targetIds.containsAll(mappedTargets) ||
            mappedSources.length != sourceIds.length ||
            mappedTargets.length != practice.answerMappings.length) {
          errors.add(
            'Matching practice ${practice.id} has invalid answer mappings.',
          );
        }
      } else {
        final itemIds = practice.sequenceItems.map((item) => item.id).toSet();
        final expectedIds = practice.expectedOrder.toSet();
        if (itemIds.isEmpty ||
            itemIds.length != practice.sequenceItems.length ||
            expectedIds.length != practice.expectedOrder.length ||
            itemIds.length != expectedIds.length ||
            !itemIds.containsAll(expectedIds)) {
          errors.add(
            'Sequence practice ${practice.id} has an invalid expected order.',
          );
        }
      }
    }
  }

  void _validateStatuses(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    for (final module in modules) {
      if (module.objectives.any(
        (objective) => objective.contentStatus == ContentStatus.sourceFinal,
      )) {
        errors.add('${module.metadata.id} objectives cannot be source-final.');
      }
      if (module.pretest.contentStatus != ContentStatus.prototypeDerived ||
          module.posttest.contentStatus != ContentStatus.prototypeDerived ||
          module.pretest.questions.any(
            (question) =>
                question.contentStatus != ContentStatus.prototypeDerived,
          ) ||
          module.posttest.questions.any(
            (question) =>
                question.contentStatus != ContentStatus.prototypeDerived,
          )) {
        errors.add(
          '${module.metadata.id} assessment banks must be prototype-derived.',
        );
      }
    }
  }

  void _validateGlossaryAndAudio(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    final glossary = modules.expand(
      (module) => module.readings.expand((reading) => reading.glossary),
    );
    final glossaryItems = glossary.toList();
    final uniqueTerms = glossaryItems
        .map((item) => item.term.toLowerCase())
        .toSet();
    final glossaryKeys = glossaryItems.map((item) => item.audioKey).toSet();
    final vocabulary = modules.expand((module) => module.vocabulary).toList();
    final readings = modules.expand((module) => module.readings).toList();

    if (glossaryItems.length != 27) {
      errors.add('Expected 27 glossary occurrences.');
    }
    if (uniqueTerms.length != 26) {
      errors.add('Expected 26 unique glossary terms.');
    }
    if (glossaryKeys.length != 26 ||
        glossaryKeys.contains('') ||
        !glossaryKeys.containsAll({'premium', 'revolutionary'})) {
      errors.add(
        'Glossary audio keys must contain 26 unique keys including premium and revolutionary.',
      );
    }
    if (vocabulary.length != 15 ||
        vocabulary.any((item) => item.audioKey.isEmpty)) {
      errors.add('All 15 vocabulary items require logical audio keys.');
    }
    if (readings.length != 5 ||
        readings.map((reading) => reading.readingAudioKey).toSet().length !=
            5) {
      errors.add('All 5 readings require unique logical audio keys.');
    }

    final adjustable = glossaryItems
        .where((item) => item.term.toLowerCase() == 'adjustable')
        .toList();
    if (adjustable.length != 2 ||
        adjustable.map((item) => item.audioKey).toSet().length != 1) {
      errors.add('Adjustable must have two occurrences sharing one audio key.');
    }
  }

  void _validateRequiredTerms(
    List<LearningModuleContent> modules,
    List<String> errors,
  ) {
    LearningModuleContent? moduleById(String id) {
      for (final module in modules) {
        if (module.metadata.id == id) return module;
      }
      return null;
    }

    final module2 = moduleById('module_2');
    final jacketGlossary = module2?.readings
        .where((reading) => reading.id == 'm2_reading_03')
        .expand((reading) => reading.glossary.map((item) => item.term))
        .toSet();
    const expectedJacket = {
      'Premium',
      'Asymmetrical',
      'Adjustable',
      'Eye-catching',
      'Centerpiece',
    };
    if (jacketGlossary == null ||
        jacketGlossary.length != expectedJacket.length ||
        !jacketGlossary.containsAll(expectedJacket) ||
        jacketGlossary.contains('Genuine')) {
      errors.add(
        'M2 Jacket glossary must retain Premium and must not substitute Genuine.',
      );
    }

    final module3 = moduleById('module_3');
    final procedureGlossary = module3?.readings
        .expand((reading) => reading.glossary.map((item) => item.term))
        .toSet();
    const expectedProcedure = {
      'Greet',
      'Scan',
      'Verify',
      'Payment method',
      'Insert',
      'Attach',
    };
    if (procedureGlossary == null ||
        procedureGlossary.length != expectedProcedure.length ||
        !procedureGlossary.containsAll(expectedProcedure)) {
      errors.add(
        'M3 formal glossary must match the canonical six targets exactly.',
      );
    }
  }
}
