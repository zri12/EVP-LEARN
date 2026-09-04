import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/models/module_content.dart';
import '../../../domain/scoring/practice_scoring.dart';
import '../../../data/repositories/persistence_repository.dart';

class PracticeSessionKey {
  const PracticeSessionKey({required this.moduleId, required this.activities});
  final String moduleId;
  final List<PracticeDefinition> activities;

  @override
  bool operator ==(Object other) =>
      other is PracticeSessionKey &&
      other.moduleId == moduleId &&
      other.activities.map((item) => item.id).join('|') ==
          activities.map((item) => item.id).join('|');
  @override
  int get hashCode =>
      Object.hash(moduleId, activities.map((item) => item.id).join('|'));
}

class PracticeActivityResult {
  const PracticeActivityResult({
    required this.activityId,
    required this.correctItems,
    required this.totalItems,
    required this.score,
  });
  final String activityId;
  final int correctItems;
  final int totalItems;
  final int score;
}

class PracticeSessionState {
  const PracticeSessionState({
    required this.moduleId,
    required this.activities,
    this.currentActivityIndex = 0,
    this.pairings = const <String, String>{},
    this.sequenceOrder = const <String>[],
    this.selectedSourceId,
    this.results = const <String, PracticeActivityResult>{},
    this.summaryVisible = false,
  });

  final String moduleId;
  final List<PracticeDefinition> activities;
  final int currentActivityIndex;
  final Map<String, String> pairings;
  final List<String> sequenceOrder;
  final String? selectedSourceId;
  final Map<String, PracticeActivityResult> results;
  final bool summaryVisible;
  PracticeDefinition get currentActivity => activities[currentActivityIndex];
  PracticeActivityResult? get currentResult => results[currentActivity.id];
  int get currentItemCount => currentActivity.kind == PracticeKind.match
      ? pairings.length
      : sequenceOrder.length;
  int get currentTotalItems => currentActivity.kind == PracticeKind.match
      ? currentActivity.sourceItems.length
      : currentActivity.sequenceItems.length;
  bool get isReadyForCheck {
    if (currentActivity.kind == PracticeKind.match) {
      return pairings.length == currentActivity.sourceItems.length &&
          currentActivity.sourceItems.every(
            (item) => pairings.containsKey(item.id),
          );
    }
    final expected = currentActivity.expectedOrder.toSet();
    return sequenceOrder.length == currentActivity.sequenceItems.length &&
        sequenceOrder.toSet().length == sequenceOrder.length &&
        sequenceOrder.toSet().containsAll(expected) &&
        expected.length == sequenceOrder.length;
  }

  int get completedActivityCount => results.length;
  bool get isComplete => results.length == 3;
  PracticeScoreSummary? get practiceSummary => isComplete
      ? PracticeScoreSummary(
          results.values.map(
            (result) => PracticeActivityScore.fromScore(
              correctItems: result.correctItems,
              totalItems: result.totalItems,
              score: result.score,
            ),
          ),
        )
      : null;
  int get practiceTotal => practiceSummary?.totalScore ?? 0;

  PracticeSessionState copyWith({
    int? currentActivityIndex,
    Map<String, String>? pairings,
    List<String>? sequenceOrder,
    String? selectedSourceId,
    bool clearSelectedSource = false,
    Map<String, PracticeActivityResult>? results,
    bool? summaryVisible,
  }) => PracticeSessionState(
    moduleId: moduleId,
    activities: activities,
    currentActivityIndex: currentActivityIndex ?? this.currentActivityIndex,
    pairings: pairings ?? this.pairings,
    sequenceOrder: sequenceOrder ?? this.sequenceOrder,
    selectedSourceId: clearSelectedSource
        ? null
        : selectedSourceId ?? this.selectedSourceId,
    results: results ?? this.results,
    summaryVisible: summaryVisible ?? this.summaryVisible,
  );
}

class PracticeSessionController extends StateNotifier<PracticeSessionState> {
  PracticeSessionController({
    required String moduleId,
    required List<PracticeDefinition> activities,
  }) : super(
         PracticeSessionState(
           moduleId: moduleId,
           activities: List.unmodifiable(activities),
         ),
       ) {
    if (activities.length != 3)
      throw ArgumentError.value(
        activities.length,
        'activities',
        'exactly 3 activities are required',
      );
    _initializeCurrentActivity();
  }

  AttemptRepository? _repository;
  String? _attemptId;
  bool get isPersistenceAttached => _repository != null && _attemptId != null;

  void attachPersistence(AttemptRepository repository, String attemptId) {
    _repository = repository;
    _attemptId = attemptId;
    unawaited(restoreSession());
  }

  Future<void> restoreSession() async {
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository == null || attemptId == null) return;
    final rows = await repository.getPracticeResults(attemptId);
    if (!mounted) return;
    final restored = <String, PracticeActivityResult>{};
    for (final row in rows.where((row) => row.completed)) {
      if (row.activityIndex < 0 ||
          row.activityIndex >= state.activities.length) {
        continue;
      }
      restored[state.activities[row.activityIndex].id] = PracticeActivityResult(
        activityId: state.activities[row.activityIndex].id,
        correctItems: row.correctItems,
        totalItems: row.totalItems,
        score: row.score,
      );
    }
    final nextIndex = state.activities.indexed
        .firstWhere(
          (entry) => !restored.containsKey(entry.$2.id),
          orElse: () => (state.activities.length - 1, state.activities.last),
        )
        .$1;
    state = state.copyWith(
      currentActivityIndex: nextIndex,
      results: Map.unmodifiable(restored),
    );
    _initializeCurrentActivity();
    await restoreCurrentDraft();
  }

  Future<void> restoreCurrentDraft() async {
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository == null || attemptId == null) return;
    final draft = await repository.getPracticeDraft(
      attemptId,
      state.currentActivityIndex,
    );
    if (draft == null || state.currentResult != null) return;
    state = state.copyWith(
      pairings: Map.unmodifiable(draft.pairings),
      sequenceOrder: List.unmodifiable(draft.sequenceOrder),
    );
  }

  Future<void> _persistDraft() async {
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository == null || attemptId == null || state.currentResult != null)
      return;
    await repository.savePracticeDraft(
      attemptId: attemptId,
      activityIndex: state.currentActivityIndex,
      activityType: state.currentActivity.kind.name,
      pairings: state.pairings,
      sequenceOrder: state.sequenceOrder,
    );
  }

  void selectSource(String sourceId) {
    if (state.currentResult != null ||
        !state.currentActivity.sourceItems.any((item) => item.id == sourceId))
      return;
    state = state.copyWith(selectedSourceId: sourceId);
  }

  void pair(String sourceId, String targetId) {
    final activity = state.currentActivity;
    if (state.currentResult != null ||
        !activity.sourceItems.any((item) => item.id == sourceId) ||
        !activity.targetItems.any((item) => item.id == targetId))
      return;
    final pairings = Map<String, String>.from(state.pairings)
      ..removeWhere(
        (source, target) => source == sourceId || target == targetId,
      )
      ..[sourceId] = targetId;
    state = state.copyWith(
      pairings: Map.unmodifiable(pairings),
      clearSelectedSource: true,
    );
    unawaited(_persistDraft());
  }

  void reorder(int oldIndex, int newIndex) {
    if (state.currentResult != null ||
        state.currentActivity.kind != PracticeKind.sequence)
      return;
    if (oldIndex < 0 || oldIndex >= state.sequenceOrder.length) return;
    if (newIndex > oldIndex) newIndex--;
    final order = List<String>.from(state.sequenceOrder);
    final item = order.removeAt(oldIndex);
    order.insert(newIndex, item);
    state = state.copyWith(sequenceOrder: List.unmodifiable(order));
    unawaited(_persistDraft());
  }

  PracticeActivityResult checkCurrentActivity() {
    final existing = state.currentResult;
    if (existing != null) return existing;
    if (!state.isReadyForCheck) {
      throw StateError('Complete the current activity before checking');
    }
    final activity = state.currentActivity;
    final total = activity.kind == PracticeKind.match
        ? activity.answerMappings.length
        : activity.expectedOrder.length;
    final correct = activity.kind == PracticeKind.match
        ? activity.answerMappings
              .where(
                (mapping) =>
                    state.pairings[mapping.sourceId] == mapping.targetId,
              )
              .length
        : state.sequenceOrder.indexed
              .where(
                (entry) =>
                    entry.$1 < activity.expectedOrder.length &&
                    entry.$2 == activity.expectedOrder[entry.$1],
              )
              .length;
    final score = PracticeActivityScore(
      correctItems: correct,
      totalItems: total,
    );
    final result = PracticeActivityResult(
      activityId: activity.id,
      correctItems: correct,
      totalItems: total,
      score: score.score,
    );
    final results = Map<String, PracticeActivityResult>.from(state.results)
      ..[activity.id] = result;
    state = state.copyWith(results: Map.unmodifiable(results));
    final repository = _repository;
    final attemptId = _attemptId;
    if (repository != null && attemptId != null) {
      unawaited(
        repository.savePracticeResult(
          attemptId: attemptId,
          activityIndex: state.currentActivityIndex,
          activityType: activity.kind.name,
          correctItems: correct,
          totalItems: total,
          score: score.score,
        ),
      );
    }
    return result;
  }

  bool nextActivity() {
    if (state.currentResult == null ||
        state.currentActivityIndex >= state.activities.length - 1) {
      return false;
    }
    state = state.copyWith(
      currentActivityIndex: state.currentActivityIndex + 1,
      pairings: const {},
      sequenceOrder: const [],
      clearSelectedSource: true,
    );
    _initializeCurrentActivity();
    unawaited(restoreCurrentDraft());
    return true;
  }

  void openSummary() {
    if (state.isComplete) state = state.copyWith(summaryVisible: true);
  }

  void resetCurrentActivity() {
    if (state.currentResult != null) return;
    state = state.copyWith(
      pairings: const {},
      sequenceOrder: const [],
      clearSelectedSource: true,
    );
    _initializeCurrentActivity();
    unawaited(_persistDraft());
  }

  void _initializeCurrentActivity() {
    final activity = state.currentActivity;
    if (activity.kind != PracticeKind.sequence) return;
    var order = activity.sequenceItems.map((item) => item.id).toList();
    if (_sameOrder(order, activity.expectedOrder) && order.length > 1) {
      order = [...order.skip(1), order.first];
    }
    state = state.copyWith(sequenceOrder: List.unmodifiable(order));
  }

  bool _sameOrder(List<String> first, List<String> second) =>
      first.length == second.length &&
      first.indexed.every((entry) => entry.$2 == second[entry.$1]);
}

final practiceSessionProvider =
    StateNotifierProvider.family<
      PracticeSessionController,
      PracticeSessionState,
      PracticeSessionKey
    >(
      (ref, key) => PracticeSessionController(
        moduleId: key.moduleId,
        activities: key.activities,
      ),
    );
