// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ModuleProgressTable extends ModuleProgress
    with TableInfo<$ModuleProgressTable, ModuleProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModuleProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _moduleIdMeta = const VerificationMeta(
    'moduleId',
  );
  @override
  late final GeneratedColumn<int> moduleId = GeneratedColumn<int>(
    'module_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _progressPercentMeta = const VerificationMeta(
    'progressPercent',
  );
  @override
  late final GeneratedColumn<int> progressPercent = GeneratedColumn<int>(
    'progress_percent',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('not_started'),
  );
  static const VerificationMeta _currentStageMeta = const VerificationMeta(
    'currentStage',
  );
  @override
  late final GeneratedColumn<String> currentStage = GeneratedColumn<String>(
    'current_stage',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentSubIndexMeta = const VerificationMeta(
    'currentSubIndex',
  );
  @override
  late final GeneratedColumn<int> currentSubIndex = GeneratedColumn<int>(
    'current_sub_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentAttemptIdMeta = const VerificationMeta(
    'currentAttemptId',
  );
  @override
  late final GeneratedColumn<String> currentAttemptId = GeneratedColumn<String>(
    'current_attempt_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRouteKeyMeta = const VerificationMeta(
    'lastRouteKey',
  );
  @override
  late final GeneratedColumn<String> lastRouteKey = GeneratedColumn<String>(
    'last_route_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    moduleId,
    progressPercent,
    status,
    currentStage,
    currentSubIndex,
    currentAttemptId,
    lastRouteKey,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'module_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<ModuleProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('module_id')) {
      context.handle(
        _moduleIdMeta,
        moduleId.isAcceptableOrUnknown(data['module_id']!, _moduleIdMeta),
      );
    }
    if (data.containsKey('progress_percent')) {
      context.handle(
        _progressPercentMeta,
        progressPercent.isAcceptableOrUnknown(
          data['progress_percent']!,
          _progressPercentMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('current_stage')) {
      context.handle(
        _currentStageMeta,
        currentStage.isAcceptableOrUnknown(
          data['current_stage']!,
          _currentStageMeta,
        ),
      );
    }
    if (data.containsKey('current_sub_index')) {
      context.handle(
        _currentSubIndexMeta,
        currentSubIndex.isAcceptableOrUnknown(
          data['current_sub_index']!,
          _currentSubIndexMeta,
        ),
      );
    }
    if (data.containsKey('current_attempt_id')) {
      context.handle(
        _currentAttemptIdMeta,
        currentAttemptId.isAcceptableOrUnknown(
          data['current_attempt_id']!,
          _currentAttemptIdMeta,
        ),
      );
    }
    if (data.containsKey('last_route_key')) {
      context.handle(
        _lastRouteKeyMeta,
        lastRouteKey.isAcceptableOrUnknown(
          data['last_route_key']!,
          _lastRouteKeyMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {moduleId};
  @override
  ModuleProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModuleProgressData(
      moduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}module_id'],
      )!,
      progressPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress_percent'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      currentStage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_stage'],
      ),
      currentSubIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_sub_index'],
      ),
      currentAttemptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_attempt_id'],
      ),
      lastRouteKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_route_key'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $ModuleProgressTable createAlias(String alias) {
    return $ModuleProgressTable(attachedDatabase, alias);
  }
}

class ModuleProgressData extends DataClass
    implements Insertable<ModuleProgressData> {
  final int moduleId;
  final int progressPercent;
  final String status;
  final String? currentStage;
  final int? currentSubIndex;
  final String? currentAttemptId;
  final String? lastRouteKey;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const ModuleProgressData({
    required this.moduleId,
    required this.progressPercent,
    required this.status,
    this.currentStage,
    this.currentSubIndex,
    this.currentAttemptId,
    this.lastRouteKey,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['module_id'] = Variable<int>(moduleId);
    map['progress_percent'] = Variable<int>(progressPercent);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || currentStage != null) {
      map['current_stage'] = Variable<String>(currentStage);
    }
    if (!nullToAbsent || currentSubIndex != null) {
      map['current_sub_index'] = Variable<int>(currentSubIndex);
    }
    if (!nullToAbsent || currentAttemptId != null) {
      map['current_attempt_id'] = Variable<String>(currentAttemptId);
    }
    if (!nullToAbsent || lastRouteKey != null) {
      map['last_route_key'] = Variable<String>(lastRouteKey);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  ModuleProgressCompanion toCompanion(bool nullToAbsent) {
    return ModuleProgressCompanion(
      moduleId: Value(moduleId),
      progressPercent: Value(progressPercent),
      status: Value(status),
      currentStage: currentStage == null && nullToAbsent
          ? const Value.absent()
          : Value(currentStage),
      currentSubIndex: currentSubIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(currentSubIndex),
      currentAttemptId: currentAttemptId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentAttemptId),
      lastRouteKey: lastRouteKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRouteKey),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory ModuleProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModuleProgressData(
      moduleId: serializer.fromJson<int>(json['moduleId']),
      progressPercent: serializer.fromJson<int>(json['progressPercent']),
      status: serializer.fromJson<String>(json['status']),
      currentStage: serializer.fromJson<String?>(json['currentStage']),
      currentSubIndex: serializer.fromJson<int?>(json['currentSubIndex']),
      currentAttemptId: serializer.fromJson<String?>(json['currentAttemptId']),
      lastRouteKey: serializer.fromJson<String?>(json['lastRouteKey']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'moduleId': serializer.toJson<int>(moduleId),
      'progressPercent': serializer.toJson<int>(progressPercent),
      'status': serializer.toJson<String>(status),
      'currentStage': serializer.toJson<String?>(currentStage),
      'currentSubIndex': serializer.toJson<int?>(currentSubIndex),
      'currentAttemptId': serializer.toJson<String?>(currentAttemptId),
      'lastRouteKey': serializer.toJson<String?>(lastRouteKey),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  ModuleProgressData copyWith({
    int? moduleId,
    int? progressPercent,
    String? status,
    Value<String?> currentStage = const Value.absent(),
    Value<int?> currentSubIndex = const Value.absent(),
    Value<String?> currentAttemptId = const Value.absent(),
    Value<String?> lastRouteKey = const Value.absent(),
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => ModuleProgressData(
    moduleId: moduleId ?? this.moduleId,
    progressPercent: progressPercent ?? this.progressPercent,
    status: status ?? this.status,
    currentStage: currentStage.present ? currentStage.value : this.currentStage,
    currentSubIndex: currentSubIndex.present
        ? currentSubIndex.value
        : this.currentSubIndex,
    currentAttemptId: currentAttemptId.present
        ? currentAttemptId.value
        : this.currentAttemptId,
    lastRouteKey: lastRouteKey.present ? lastRouteKey.value : this.lastRouteKey,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  ModuleProgressData copyWithCompanion(ModuleProgressCompanion data) {
    return ModuleProgressData(
      moduleId: data.moduleId.present ? data.moduleId.value : this.moduleId,
      progressPercent: data.progressPercent.present
          ? data.progressPercent.value
          : this.progressPercent,
      status: data.status.present ? data.status.value : this.status,
      currentStage: data.currentStage.present
          ? data.currentStage.value
          : this.currentStage,
      currentSubIndex: data.currentSubIndex.present
          ? data.currentSubIndex.value
          : this.currentSubIndex,
      currentAttemptId: data.currentAttemptId.present
          ? data.currentAttemptId.value
          : this.currentAttemptId,
      lastRouteKey: data.lastRouteKey.present
          ? data.lastRouteKey.value
          : this.lastRouteKey,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModuleProgressData(')
          ..write('moduleId: $moduleId, ')
          ..write('progressPercent: $progressPercent, ')
          ..write('status: $status, ')
          ..write('currentStage: $currentStage, ')
          ..write('currentSubIndex: $currentSubIndex, ')
          ..write('currentAttemptId: $currentAttemptId, ')
          ..write('lastRouteKey: $lastRouteKey, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    moduleId,
    progressPercent,
    status,
    currentStage,
    currentSubIndex,
    currentAttemptId,
    lastRouteKey,
    updatedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModuleProgressData &&
          other.moduleId == this.moduleId &&
          other.progressPercent == this.progressPercent &&
          other.status == this.status &&
          other.currentStage == this.currentStage &&
          other.currentSubIndex == this.currentSubIndex &&
          other.currentAttemptId == this.currentAttemptId &&
          other.lastRouteKey == this.lastRouteKey &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class ModuleProgressCompanion extends UpdateCompanion<ModuleProgressData> {
  final Value<int> moduleId;
  final Value<int> progressPercent;
  final Value<String> status;
  final Value<String?> currentStage;
  final Value<int?> currentSubIndex;
  final Value<String?> currentAttemptId;
  final Value<String?> lastRouteKey;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  const ModuleProgressCompanion({
    this.moduleId = const Value.absent(),
    this.progressPercent = const Value.absent(),
    this.status = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.currentSubIndex = const Value.absent(),
    this.currentAttemptId = const Value.absent(),
    this.lastRouteKey = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
  });
  ModuleProgressCompanion.insert({
    this.moduleId = const Value.absent(),
    this.progressPercent = const Value.absent(),
    this.status = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.currentSubIndex = const Value.absent(),
    this.currentAttemptId = const Value.absent(),
    this.lastRouteKey = const Value.absent(),
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
  }) : updatedAt = Value(updatedAt);
  static Insertable<ModuleProgressData> custom({
    Expression<int>? moduleId,
    Expression<int>? progressPercent,
    Expression<String>? status,
    Expression<String>? currentStage,
    Expression<int>? currentSubIndex,
    Expression<String>? currentAttemptId,
    Expression<String>? lastRouteKey,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
  }) {
    return RawValuesInsertable({
      if (moduleId != null) 'module_id': moduleId,
      if (progressPercent != null) 'progress_percent': progressPercent,
      if (status != null) 'status': status,
      if (currentStage != null) 'current_stage': currentStage,
      if (currentSubIndex != null) 'current_sub_index': currentSubIndex,
      if (currentAttemptId != null) 'current_attempt_id': currentAttemptId,
      if (lastRouteKey != null) 'last_route_key': lastRouteKey,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
    });
  }

  ModuleProgressCompanion copyWith({
    Value<int>? moduleId,
    Value<int>? progressPercent,
    Value<String>? status,
    Value<String?>? currentStage,
    Value<int?>? currentSubIndex,
    Value<String?>? currentAttemptId,
    Value<String?>? lastRouteKey,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
  }) {
    return ModuleProgressCompanion(
      moduleId: moduleId ?? this.moduleId,
      progressPercent: progressPercent ?? this.progressPercent,
      status: status ?? this.status,
      currentStage: currentStage ?? this.currentStage,
      currentSubIndex: currentSubIndex ?? this.currentSubIndex,
      currentAttemptId: currentAttemptId ?? this.currentAttemptId,
      lastRouteKey: lastRouteKey ?? this.lastRouteKey,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (moduleId.present) {
      map['module_id'] = Variable<int>(moduleId.value);
    }
    if (progressPercent.present) {
      map['progress_percent'] = Variable<int>(progressPercent.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (currentStage.present) {
      map['current_stage'] = Variable<String>(currentStage.value);
    }
    if (currentSubIndex.present) {
      map['current_sub_index'] = Variable<int>(currentSubIndex.value);
    }
    if (currentAttemptId.present) {
      map['current_attempt_id'] = Variable<String>(currentAttemptId.value);
    }
    if (lastRouteKey.present) {
      map['last_route_key'] = Variable<String>(lastRouteKey.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModuleProgressCompanion(')
          ..write('moduleId: $moduleId, ')
          ..write('progressPercent: $progressPercent, ')
          ..write('status: $status, ')
          ..write('currentStage: $currentStage, ')
          ..write('currentSubIndex: $currentSubIndex, ')
          ..write('currentAttemptId: $currentAttemptId, ')
          ..write('lastRouteKey: $lastRouteKey, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }
}

class $LearningAttemptsTable extends LearningAttempts
    with TableInfo<$LearningAttemptsTable, LearningAttempt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningAttemptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moduleIdMeta = const VerificationMeta(
    'moduleId',
  );
  @override
  late final GeneratedColumn<int> moduleId = GeneratedColumn<int>(
    'module_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptNumberMeta = const VerificationMeta(
    'attemptNumber',
  );
  @override
  late final GeneratedColumn<int> attemptNumber = GeneratedColumn<int>(
    'attempt_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentVersionMeta = const VerificationMeta(
    'contentVersion',
  );
  @override
  late final GeneratedColumn<int> contentVersion = GeneratedColumn<int>(
    'content_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _currentStageMeta = const VerificationMeta(
    'currentStage',
  );
  @override
  late final GeneratedColumn<String> currentStage = GeneratedColumn<String>(
    'current_stage',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('overview'),
  );
  static const VerificationMeta _currentSubIndexMeta = const VerificationMeta(
    'currentSubIndex',
  );
  @override
  late final GeneratedColumn<int> currentSubIndex = GeneratedColumn<int>(
    'current_sub_index',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currentReadingIdMeta = const VerificationMeta(
    'currentReadingId',
  );
  @override
  late final GeneratedColumn<String> currentReadingId = GeneratedColumn<String>(
    'current_reading_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastRouteKeyMeta = const VerificationMeta(
    'lastRouteKey',
  );
  @override
  late final GeneratedColumn<String> lastRouteKey = GeneratedColumn<String>(
    'last_route_key',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pretestRawMeta = const VerificationMeta(
    'pretestRaw',
  );
  @override
  late final GeneratedColumn<double> pretestRaw = GeneratedColumn<double>(
    'pretest_raw',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pretestCorrectMeta = const VerificationMeta(
    'pretestCorrect',
  );
  @override
  late final GeneratedColumn<int> pretestCorrect = GeneratedColumn<int>(
    'pretest_correct',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pretestIncorrectMeta = const VerificationMeta(
    'pretestIncorrect',
  );
  @override
  late final GeneratedColumn<int> pretestIncorrect = GeneratedColumn<int>(
    'pretest_incorrect',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _practiceTotalMeta = const VerificationMeta(
    'practiceTotal',
  );
  @override
  late final GeneratedColumn<double> practiceTotal = GeneratedColumn<double>(
    'practice_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _posttestRawMeta = const VerificationMeta(
    'posttestRaw',
  );
  @override
  late final GeneratedColumn<double> posttestRaw = GeneratedColumn<double>(
    'posttest_raw',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posttestWeightedMeta = const VerificationMeta(
    'posttestWeighted',
  );
  @override
  late final GeneratedColumn<double> posttestWeighted = GeneratedColumn<double>(
    'posttest_weighted',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posttestCorrectMeta = const VerificationMeta(
    'posttestCorrect',
  );
  @override
  late final GeneratedColumn<int> posttestCorrect = GeneratedColumn<int>(
    'posttest_correct',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _posttestIncorrectMeta = const VerificationMeta(
    'posttestIncorrect',
  );
  @override
  late final GeneratedColumn<int> posttestIncorrect = GeneratedColumn<int>(
    'posttest_incorrect',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _finalScoreMeta = const VerificationMeta(
    'finalScore',
  );
  @override
  late final GeneratedColumn<double> finalScore = GeneratedColumn<double>(
    'final_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _learningGainMeta = const VerificationMeta(
    'learningGain',
  );
  @override
  late final GeneratedColumn<double> learningGain = GeneratedColumn<double>(
    'learning_gain',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _passedMeta = const VerificationMeta('passed');
  @override
  late final GeneratedColumn<bool> passed = GeneratedColumn<bool>(
    'passed',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("passed" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    moduleId,
    attemptNumber,
    status,
    contentVersion,
    currentStage,
    currentSubIndex,
    currentReadingId,
    lastRouteKey,
    startedAt,
    completedAt,
    pretestRaw,
    pretestCorrect,
    pretestIncorrect,
    practiceTotal,
    posttestRaw,
    posttestWeighted,
    posttestCorrect,
    posttestIncorrect,
    finalScore,
    learningGain,
    passed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_attempts';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningAttempt> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('module_id')) {
      context.handle(
        _moduleIdMeta,
        moduleId.isAcceptableOrUnknown(data['module_id']!, _moduleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_moduleIdMeta);
    }
    if (data.containsKey('attempt_number')) {
      context.handle(
        _attemptNumberMeta,
        attemptNumber.isAcceptableOrUnknown(
          data['attempt_number']!,
          _attemptNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_attemptNumberMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('content_version')) {
      context.handle(
        _contentVersionMeta,
        contentVersion.isAcceptableOrUnknown(
          data['content_version']!,
          _contentVersionMeta,
        ),
      );
    }
    if (data.containsKey('current_stage')) {
      context.handle(
        _currentStageMeta,
        currentStage.isAcceptableOrUnknown(
          data['current_stage']!,
          _currentStageMeta,
        ),
      );
    }
    if (data.containsKey('current_sub_index')) {
      context.handle(
        _currentSubIndexMeta,
        currentSubIndex.isAcceptableOrUnknown(
          data['current_sub_index']!,
          _currentSubIndexMeta,
        ),
      );
    }
    if (data.containsKey('current_reading_id')) {
      context.handle(
        _currentReadingIdMeta,
        currentReadingId.isAcceptableOrUnknown(
          data['current_reading_id']!,
          _currentReadingIdMeta,
        ),
      );
    }
    if (data.containsKey('last_route_key')) {
      context.handle(
        _lastRouteKeyMeta,
        lastRouteKey.isAcceptableOrUnknown(
          data['last_route_key']!,
          _lastRouteKeyMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('pretest_raw')) {
      context.handle(
        _pretestRawMeta,
        pretestRaw.isAcceptableOrUnknown(data['pretest_raw']!, _pretestRawMeta),
      );
    }
    if (data.containsKey('pretest_correct')) {
      context.handle(
        _pretestCorrectMeta,
        pretestCorrect.isAcceptableOrUnknown(
          data['pretest_correct']!,
          _pretestCorrectMeta,
        ),
      );
    }
    if (data.containsKey('pretest_incorrect')) {
      context.handle(
        _pretestIncorrectMeta,
        pretestIncorrect.isAcceptableOrUnknown(
          data['pretest_incorrect']!,
          _pretestIncorrectMeta,
        ),
      );
    }
    if (data.containsKey('practice_total')) {
      context.handle(
        _practiceTotalMeta,
        practiceTotal.isAcceptableOrUnknown(
          data['practice_total']!,
          _practiceTotalMeta,
        ),
      );
    }
    if (data.containsKey('posttest_raw')) {
      context.handle(
        _posttestRawMeta,
        posttestRaw.isAcceptableOrUnknown(
          data['posttest_raw']!,
          _posttestRawMeta,
        ),
      );
    }
    if (data.containsKey('posttest_weighted')) {
      context.handle(
        _posttestWeightedMeta,
        posttestWeighted.isAcceptableOrUnknown(
          data['posttest_weighted']!,
          _posttestWeightedMeta,
        ),
      );
    }
    if (data.containsKey('posttest_correct')) {
      context.handle(
        _posttestCorrectMeta,
        posttestCorrect.isAcceptableOrUnknown(
          data['posttest_correct']!,
          _posttestCorrectMeta,
        ),
      );
    }
    if (data.containsKey('posttest_incorrect')) {
      context.handle(
        _posttestIncorrectMeta,
        posttestIncorrect.isAcceptableOrUnknown(
          data['posttest_incorrect']!,
          _posttestIncorrectMeta,
        ),
      );
    }
    if (data.containsKey('final_score')) {
      context.handle(
        _finalScoreMeta,
        finalScore.isAcceptableOrUnknown(data['final_score']!, _finalScoreMeta),
      );
    }
    if (data.containsKey('learning_gain')) {
      context.handle(
        _learningGainMeta,
        learningGain.isAcceptableOrUnknown(
          data['learning_gain']!,
          _learningGainMeta,
        ),
      );
    }
    if (data.containsKey('passed')) {
      context.handle(
        _passedMeta,
        passed.isAcceptableOrUnknown(data['passed']!, _passedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningAttempt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningAttempt(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      moduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}module_id'],
      )!,
      attemptNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempt_number'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      contentVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}content_version'],
      )!,
      currentStage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_stage'],
      )!,
      currentSubIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_sub_index'],
      ),
      currentReadingId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}current_reading_id'],
      ),
      lastRouteKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_route_key'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      pretestRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pretest_raw'],
      ),
      pretestCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pretest_correct'],
      ),
      pretestIncorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pretest_incorrect'],
      ),
      practiceTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}practice_total'],
      )!,
      posttestRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}posttest_raw'],
      ),
      posttestWeighted: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}posttest_weighted'],
      ),
      posttestCorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}posttest_correct'],
      ),
      posttestIncorrect: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}posttest_incorrect'],
      ),
      finalScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}final_score'],
      ),
      learningGain: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}learning_gain'],
      ),
      passed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}passed'],
      ),
    );
  }

  @override
  $LearningAttemptsTable createAlias(String alias) {
    return $LearningAttemptsTable(attachedDatabase, alias);
  }
}

class LearningAttempt extends DataClass implements Insertable<LearningAttempt> {
  final String id;
  final int moduleId;
  final int attemptNumber;
  final String status;
  final int contentVersion;
  final String currentStage;
  final int? currentSubIndex;
  final String? currentReadingId;
  final String? lastRouteKey;
  final DateTime startedAt;
  final DateTime? completedAt;
  final double? pretestRaw;
  final int? pretestCorrect;
  final int? pretestIncorrect;
  final double practiceTotal;
  final double? posttestRaw;
  final double? posttestWeighted;
  final int? posttestCorrect;
  final int? posttestIncorrect;
  final double? finalScore;
  final double? learningGain;
  final bool? passed;
  const LearningAttempt({
    required this.id,
    required this.moduleId,
    required this.attemptNumber,
    required this.status,
    required this.contentVersion,
    required this.currentStage,
    this.currentSubIndex,
    this.currentReadingId,
    this.lastRouteKey,
    required this.startedAt,
    this.completedAt,
    this.pretestRaw,
    this.pretestCorrect,
    this.pretestIncorrect,
    required this.practiceTotal,
    this.posttestRaw,
    this.posttestWeighted,
    this.posttestCorrect,
    this.posttestIncorrect,
    this.finalScore,
    this.learningGain,
    this.passed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['module_id'] = Variable<int>(moduleId);
    map['attempt_number'] = Variable<int>(attemptNumber);
    map['status'] = Variable<String>(status);
    map['content_version'] = Variable<int>(contentVersion);
    map['current_stage'] = Variable<String>(currentStage);
    if (!nullToAbsent || currentSubIndex != null) {
      map['current_sub_index'] = Variable<int>(currentSubIndex);
    }
    if (!nullToAbsent || currentReadingId != null) {
      map['current_reading_id'] = Variable<String>(currentReadingId);
    }
    if (!nullToAbsent || lastRouteKey != null) {
      map['last_route_key'] = Variable<String>(lastRouteKey);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    if (!nullToAbsent || pretestRaw != null) {
      map['pretest_raw'] = Variable<double>(pretestRaw);
    }
    if (!nullToAbsent || pretestCorrect != null) {
      map['pretest_correct'] = Variable<int>(pretestCorrect);
    }
    if (!nullToAbsent || pretestIncorrect != null) {
      map['pretest_incorrect'] = Variable<int>(pretestIncorrect);
    }
    map['practice_total'] = Variable<double>(practiceTotal);
    if (!nullToAbsent || posttestRaw != null) {
      map['posttest_raw'] = Variable<double>(posttestRaw);
    }
    if (!nullToAbsent || posttestWeighted != null) {
      map['posttest_weighted'] = Variable<double>(posttestWeighted);
    }
    if (!nullToAbsent || posttestCorrect != null) {
      map['posttest_correct'] = Variable<int>(posttestCorrect);
    }
    if (!nullToAbsent || posttestIncorrect != null) {
      map['posttest_incorrect'] = Variable<int>(posttestIncorrect);
    }
    if (!nullToAbsent || finalScore != null) {
      map['final_score'] = Variable<double>(finalScore);
    }
    if (!nullToAbsent || learningGain != null) {
      map['learning_gain'] = Variable<double>(learningGain);
    }
    if (!nullToAbsent || passed != null) {
      map['passed'] = Variable<bool>(passed);
    }
    return map;
  }

  LearningAttemptsCompanion toCompanion(bool nullToAbsent) {
    return LearningAttemptsCompanion(
      id: Value(id),
      moduleId: Value(moduleId),
      attemptNumber: Value(attemptNumber),
      status: Value(status),
      contentVersion: Value(contentVersion),
      currentStage: Value(currentStage),
      currentSubIndex: currentSubIndex == null && nullToAbsent
          ? const Value.absent()
          : Value(currentSubIndex),
      currentReadingId: currentReadingId == null && nullToAbsent
          ? const Value.absent()
          : Value(currentReadingId),
      lastRouteKey: lastRouteKey == null && nullToAbsent
          ? const Value.absent()
          : Value(lastRouteKey),
      startedAt: Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      pretestRaw: pretestRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(pretestRaw),
      pretestCorrect: pretestCorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(pretestCorrect),
      pretestIncorrect: pretestIncorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(pretestIncorrect),
      practiceTotal: Value(practiceTotal),
      posttestRaw: posttestRaw == null && nullToAbsent
          ? const Value.absent()
          : Value(posttestRaw),
      posttestWeighted: posttestWeighted == null && nullToAbsent
          ? const Value.absent()
          : Value(posttestWeighted),
      posttestCorrect: posttestCorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(posttestCorrect),
      posttestIncorrect: posttestIncorrect == null && nullToAbsent
          ? const Value.absent()
          : Value(posttestIncorrect),
      finalScore: finalScore == null && nullToAbsent
          ? const Value.absent()
          : Value(finalScore),
      learningGain: learningGain == null && nullToAbsent
          ? const Value.absent()
          : Value(learningGain),
      passed: passed == null && nullToAbsent
          ? const Value.absent()
          : Value(passed),
    );
  }

  factory LearningAttempt.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningAttempt(
      id: serializer.fromJson<String>(json['id']),
      moduleId: serializer.fromJson<int>(json['moduleId']),
      attemptNumber: serializer.fromJson<int>(json['attemptNumber']),
      status: serializer.fromJson<String>(json['status']),
      contentVersion: serializer.fromJson<int>(json['contentVersion']),
      currentStage: serializer.fromJson<String>(json['currentStage']),
      currentSubIndex: serializer.fromJson<int?>(json['currentSubIndex']),
      currentReadingId: serializer.fromJson<String?>(json['currentReadingId']),
      lastRouteKey: serializer.fromJson<String?>(json['lastRouteKey']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      pretestRaw: serializer.fromJson<double?>(json['pretestRaw']),
      pretestCorrect: serializer.fromJson<int?>(json['pretestCorrect']),
      pretestIncorrect: serializer.fromJson<int?>(json['pretestIncorrect']),
      practiceTotal: serializer.fromJson<double>(json['practiceTotal']),
      posttestRaw: serializer.fromJson<double?>(json['posttestRaw']),
      posttestWeighted: serializer.fromJson<double?>(json['posttestWeighted']),
      posttestCorrect: serializer.fromJson<int?>(json['posttestCorrect']),
      posttestIncorrect: serializer.fromJson<int?>(json['posttestIncorrect']),
      finalScore: serializer.fromJson<double?>(json['finalScore']),
      learningGain: serializer.fromJson<double?>(json['learningGain']),
      passed: serializer.fromJson<bool?>(json['passed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'moduleId': serializer.toJson<int>(moduleId),
      'attemptNumber': serializer.toJson<int>(attemptNumber),
      'status': serializer.toJson<String>(status),
      'contentVersion': serializer.toJson<int>(contentVersion),
      'currentStage': serializer.toJson<String>(currentStage),
      'currentSubIndex': serializer.toJson<int?>(currentSubIndex),
      'currentReadingId': serializer.toJson<String?>(currentReadingId),
      'lastRouteKey': serializer.toJson<String?>(lastRouteKey),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'pretestRaw': serializer.toJson<double?>(pretestRaw),
      'pretestCorrect': serializer.toJson<int?>(pretestCorrect),
      'pretestIncorrect': serializer.toJson<int?>(pretestIncorrect),
      'practiceTotal': serializer.toJson<double>(practiceTotal),
      'posttestRaw': serializer.toJson<double?>(posttestRaw),
      'posttestWeighted': serializer.toJson<double?>(posttestWeighted),
      'posttestCorrect': serializer.toJson<int?>(posttestCorrect),
      'posttestIncorrect': serializer.toJson<int?>(posttestIncorrect),
      'finalScore': serializer.toJson<double?>(finalScore),
      'learningGain': serializer.toJson<double?>(learningGain),
      'passed': serializer.toJson<bool?>(passed),
    };
  }

  LearningAttempt copyWith({
    String? id,
    int? moduleId,
    int? attemptNumber,
    String? status,
    int? contentVersion,
    String? currentStage,
    Value<int?> currentSubIndex = const Value.absent(),
    Value<String?> currentReadingId = const Value.absent(),
    Value<String?> lastRouteKey = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> completedAt = const Value.absent(),
    Value<double?> pretestRaw = const Value.absent(),
    Value<int?> pretestCorrect = const Value.absent(),
    Value<int?> pretestIncorrect = const Value.absent(),
    double? practiceTotal,
    Value<double?> posttestRaw = const Value.absent(),
    Value<double?> posttestWeighted = const Value.absent(),
    Value<int?> posttestCorrect = const Value.absent(),
    Value<int?> posttestIncorrect = const Value.absent(),
    Value<double?> finalScore = const Value.absent(),
    Value<double?> learningGain = const Value.absent(),
    Value<bool?> passed = const Value.absent(),
  }) => LearningAttempt(
    id: id ?? this.id,
    moduleId: moduleId ?? this.moduleId,
    attemptNumber: attemptNumber ?? this.attemptNumber,
    status: status ?? this.status,
    contentVersion: contentVersion ?? this.contentVersion,
    currentStage: currentStage ?? this.currentStage,
    currentSubIndex: currentSubIndex.present
        ? currentSubIndex.value
        : this.currentSubIndex,
    currentReadingId: currentReadingId.present
        ? currentReadingId.value
        : this.currentReadingId,
    lastRouteKey: lastRouteKey.present ? lastRouteKey.value : this.lastRouteKey,
    startedAt: startedAt ?? this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    pretestRaw: pretestRaw.present ? pretestRaw.value : this.pretestRaw,
    pretestCorrect: pretestCorrect.present
        ? pretestCorrect.value
        : this.pretestCorrect,
    pretestIncorrect: pretestIncorrect.present
        ? pretestIncorrect.value
        : this.pretestIncorrect,
    practiceTotal: practiceTotal ?? this.practiceTotal,
    posttestRaw: posttestRaw.present ? posttestRaw.value : this.posttestRaw,
    posttestWeighted: posttestWeighted.present
        ? posttestWeighted.value
        : this.posttestWeighted,
    posttestCorrect: posttestCorrect.present
        ? posttestCorrect.value
        : this.posttestCorrect,
    posttestIncorrect: posttestIncorrect.present
        ? posttestIncorrect.value
        : this.posttestIncorrect,
    finalScore: finalScore.present ? finalScore.value : this.finalScore,
    learningGain: learningGain.present ? learningGain.value : this.learningGain,
    passed: passed.present ? passed.value : this.passed,
  );
  LearningAttempt copyWithCompanion(LearningAttemptsCompanion data) {
    return LearningAttempt(
      id: data.id.present ? data.id.value : this.id,
      moduleId: data.moduleId.present ? data.moduleId.value : this.moduleId,
      attemptNumber: data.attemptNumber.present
          ? data.attemptNumber.value
          : this.attemptNumber,
      status: data.status.present ? data.status.value : this.status,
      contentVersion: data.contentVersion.present
          ? data.contentVersion.value
          : this.contentVersion,
      currentStage: data.currentStage.present
          ? data.currentStage.value
          : this.currentStage,
      currentSubIndex: data.currentSubIndex.present
          ? data.currentSubIndex.value
          : this.currentSubIndex,
      currentReadingId: data.currentReadingId.present
          ? data.currentReadingId.value
          : this.currentReadingId,
      lastRouteKey: data.lastRouteKey.present
          ? data.lastRouteKey.value
          : this.lastRouteKey,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      pretestRaw: data.pretestRaw.present
          ? data.pretestRaw.value
          : this.pretestRaw,
      pretestCorrect: data.pretestCorrect.present
          ? data.pretestCorrect.value
          : this.pretestCorrect,
      pretestIncorrect: data.pretestIncorrect.present
          ? data.pretestIncorrect.value
          : this.pretestIncorrect,
      practiceTotal: data.practiceTotal.present
          ? data.practiceTotal.value
          : this.practiceTotal,
      posttestRaw: data.posttestRaw.present
          ? data.posttestRaw.value
          : this.posttestRaw,
      posttestWeighted: data.posttestWeighted.present
          ? data.posttestWeighted.value
          : this.posttestWeighted,
      posttestCorrect: data.posttestCorrect.present
          ? data.posttestCorrect.value
          : this.posttestCorrect,
      posttestIncorrect: data.posttestIncorrect.present
          ? data.posttestIncorrect.value
          : this.posttestIncorrect,
      finalScore: data.finalScore.present
          ? data.finalScore.value
          : this.finalScore,
      learningGain: data.learningGain.present
          ? data.learningGain.value
          : this.learningGain,
      passed: data.passed.present ? data.passed.value : this.passed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningAttempt(')
          ..write('id: $id, ')
          ..write('moduleId: $moduleId, ')
          ..write('attemptNumber: $attemptNumber, ')
          ..write('status: $status, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('currentStage: $currentStage, ')
          ..write('currentSubIndex: $currentSubIndex, ')
          ..write('currentReadingId: $currentReadingId, ')
          ..write('lastRouteKey: $lastRouteKey, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('pretestRaw: $pretestRaw, ')
          ..write('pretestCorrect: $pretestCorrect, ')
          ..write('pretestIncorrect: $pretestIncorrect, ')
          ..write('practiceTotal: $practiceTotal, ')
          ..write('posttestRaw: $posttestRaw, ')
          ..write('posttestWeighted: $posttestWeighted, ')
          ..write('posttestCorrect: $posttestCorrect, ')
          ..write('posttestIncorrect: $posttestIncorrect, ')
          ..write('finalScore: $finalScore, ')
          ..write('learningGain: $learningGain, ')
          ..write('passed: $passed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    moduleId,
    attemptNumber,
    status,
    contentVersion,
    currentStage,
    currentSubIndex,
    currentReadingId,
    lastRouteKey,
    startedAt,
    completedAt,
    pretestRaw,
    pretestCorrect,
    pretestIncorrect,
    practiceTotal,
    posttestRaw,
    posttestWeighted,
    posttestCorrect,
    posttestIncorrect,
    finalScore,
    learningGain,
    passed,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningAttempt &&
          other.id == this.id &&
          other.moduleId == this.moduleId &&
          other.attemptNumber == this.attemptNumber &&
          other.status == this.status &&
          other.contentVersion == this.contentVersion &&
          other.currentStage == this.currentStage &&
          other.currentSubIndex == this.currentSubIndex &&
          other.currentReadingId == this.currentReadingId &&
          other.lastRouteKey == this.lastRouteKey &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.pretestRaw == this.pretestRaw &&
          other.pretestCorrect == this.pretestCorrect &&
          other.pretestIncorrect == this.pretestIncorrect &&
          other.practiceTotal == this.practiceTotal &&
          other.posttestRaw == this.posttestRaw &&
          other.posttestWeighted == this.posttestWeighted &&
          other.posttestCorrect == this.posttestCorrect &&
          other.posttestIncorrect == this.posttestIncorrect &&
          other.finalScore == this.finalScore &&
          other.learningGain == this.learningGain &&
          other.passed == this.passed);
}

class LearningAttemptsCompanion extends UpdateCompanion<LearningAttempt> {
  final Value<String> id;
  final Value<int> moduleId;
  final Value<int> attemptNumber;
  final Value<String> status;
  final Value<int> contentVersion;
  final Value<String> currentStage;
  final Value<int?> currentSubIndex;
  final Value<String?> currentReadingId;
  final Value<String?> lastRouteKey;
  final Value<DateTime> startedAt;
  final Value<DateTime?> completedAt;
  final Value<double?> pretestRaw;
  final Value<int?> pretestCorrect;
  final Value<int?> pretestIncorrect;
  final Value<double> practiceTotal;
  final Value<double?> posttestRaw;
  final Value<double?> posttestWeighted;
  final Value<int?> posttestCorrect;
  final Value<int?> posttestIncorrect;
  final Value<double?> finalScore;
  final Value<double?> learningGain;
  final Value<bool?> passed;
  final Value<int> rowid;
  const LearningAttemptsCompanion({
    this.id = const Value.absent(),
    this.moduleId = const Value.absent(),
    this.attemptNumber = const Value.absent(),
    this.status = const Value.absent(),
    this.contentVersion = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.currentSubIndex = const Value.absent(),
    this.currentReadingId = const Value.absent(),
    this.lastRouteKey = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.pretestRaw = const Value.absent(),
    this.pretestCorrect = const Value.absent(),
    this.pretestIncorrect = const Value.absent(),
    this.practiceTotal = const Value.absent(),
    this.posttestRaw = const Value.absent(),
    this.posttestWeighted = const Value.absent(),
    this.posttestCorrect = const Value.absent(),
    this.posttestIncorrect = const Value.absent(),
    this.finalScore = const Value.absent(),
    this.learningGain = const Value.absent(),
    this.passed = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningAttemptsCompanion.insert({
    required String id,
    required int moduleId,
    required int attemptNumber,
    required String status,
    this.contentVersion = const Value.absent(),
    this.currentStage = const Value.absent(),
    this.currentSubIndex = const Value.absent(),
    this.currentReadingId = const Value.absent(),
    this.lastRouteKey = const Value.absent(),
    required DateTime startedAt,
    this.completedAt = const Value.absent(),
    this.pretestRaw = const Value.absent(),
    this.pretestCorrect = const Value.absent(),
    this.pretestIncorrect = const Value.absent(),
    this.practiceTotal = const Value.absent(),
    this.posttestRaw = const Value.absent(),
    this.posttestWeighted = const Value.absent(),
    this.posttestCorrect = const Value.absent(),
    this.posttestIncorrect = const Value.absent(),
    this.finalScore = const Value.absent(),
    this.learningGain = const Value.absent(),
    this.passed = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       moduleId = Value(moduleId),
       attemptNumber = Value(attemptNumber),
       status = Value(status),
       startedAt = Value(startedAt);
  static Insertable<LearningAttempt> custom({
    Expression<String>? id,
    Expression<int>? moduleId,
    Expression<int>? attemptNumber,
    Expression<String>? status,
    Expression<int>? contentVersion,
    Expression<String>? currentStage,
    Expression<int>? currentSubIndex,
    Expression<String>? currentReadingId,
    Expression<String>? lastRouteKey,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<double>? pretestRaw,
    Expression<int>? pretestCorrect,
    Expression<int>? pretestIncorrect,
    Expression<double>? practiceTotal,
    Expression<double>? posttestRaw,
    Expression<double>? posttestWeighted,
    Expression<int>? posttestCorrect,
    Expression<int>? posttestIncorrect,
    Expression<double>? finalScore,
    Expression<double>? learningGain,
    Expression<bool>? passed,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (moduleId != null) 'module_id': moduleId,
      if (attemptNumber != null) 'attempt_number': attemptNumber,
      if (status != null) 'status': status,
      if (contentVersion != null) 'content_version': contentVersion,
      if (currentStage != null) 'current_stage': currentStage,
      if (currentSubIndex != null) 'current_sub_index': currentSubIndex,
      if (currentReadingId != null) 'current_reading_id': currentReadingId,
      if (lastRouteKey != null) 'last_route_key': lastRouteKey,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (pretestRaw != null) 'pretest_raw': pretestRaw,
      if (pretestCorrect != null) 'pretest_correct': pretestCorrect,
      if (pretestIncorrect != null) 'pretest_incorrect': pretestIncorrect,
      if (practiceTotal != null) 'practice_total': practiceTotal,
      if (posttestRaw != null) 'posttest_raw': posttestRaw,
      if (posttestWeighted != null) 'posttest_weighted': posttestWeighted,
      if (posttestCorrect != null) 'posttest_correct': posttestCorrect,
      if (posttestIncorrect != null) 'posttest_incorrect': posttestIncorrect,
      if (finalScore != null) 'final_score': finalScore,
      if (learningGain != null) 'learning_gain': learningGain,
      if (passed != null) 'passed': passed,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningAttemptsCompanion copyWith({
    Value<String>? id,
    Value<int>? moduleId,
    Value<int>? attemptNumber,
    Value<String>? status,
    Value<int>? contentVersion,
    Value<String>? currentStage,
    Value<int?>? currentSubIndex,
    Value<String?>? currentReadingId,
    Value<String?>? lastRouteKey,
    Value<DateTime>? startedAt,
    Value<DateTime?>? completedAt,
    Value<double?>? pretestRaw,
    Value<int?>? pretestCorrect,
    Value<int?>? pretestIncorrect,
    Value<double>? practiceTotal,
    Value<double?>? posttestRaw,
    Value<double?>? posttestWeighted,
    Value<int?>? posttestCorrect,
    Value<int?>? posttestIncorrect,
    Value<double?>? finalScore,
    Value<double?>? learningGain,
    Value<bool?>? passed,
    Value<int>? rowid,
  }) {
    return LearningAttemptsCompanion(
      id: id ?? this.id,
      moduleId: moduleId ?? this.moduleId,
      attemptNumber: attemptNumber ?? this.attemptNumber,
      status: status ?? this.status,
      contentVersion: contentVersion ?? this.contentVersion,
      currentStage: currentStage ?? this.currentStage,
      currentSubIndex: currentSubIndex ?? this.currentSubIndex,
      currentReadingId: currentReadingId ?? this.currentReadingId,
      lastRouteKey: lastRouteKey ?? this.lastRouteKey,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      pretestRaw: pretestRaw ?? this.pretestRaw,
      pretestCorrect: pretestCorrect ?? this.pretestCorrect,
      pretestIncorrect: pretestIncorrect ?? this.pretestIncorrect,
      practiceTotal: practiceTotal ?? this.practiceTotal,
      posttestRaw: posttestRaw ?? this.posttestRaw,
      posttestWeighted: posttestWeighted ?? this.posttestWeighted,
      posttestCorrect: posttestCorrect ?? this.posttestCorrect,
      posttestIncorrect: posttestIncorrect ?? this.posttestIncorrect,
      finalScore: finalScore ?? this.finalScore,
      learningGain: learningGain ?? this.learningGain,
      passed: passed ?? this.passed,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (moduleId.present) {
      map['module_id'] = Variable<int>(moduleId.value);
    }
    if (attemptNumber.present) {
      map['attempt_number'] = Variable<int>(attemptNumber.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (contentVersion.present) {
      map['content_version'] = Variable<int>(contentVersion.value);
    }
    if (currentStage.present) {
      map['current_stage'] = Variable<String>(currentStage.value);
    }
    if (currentSubIndex.present) {
      map['current_sub_index'] = Variable<int>(currentSubIndex.value);
    }
    if (currentReadingId.present) {
      map['current_reading_id'] = Variable<String>(currentReadingId.value);
    }
    if (lastRouteKey.present) {
      map['last_route_key'] = Variable<String>(lastRouteKey.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (pretestRaw.present) {
      map['pretest_raw'] = Variable<double>(pretestRaw.value);
    }
    if (pretestCorrect.present) {
      map['pretest_correct'] = Variable<int>(pretestCorrect.value);
    }
    if (pretestIncorrect.present) {
      map['pretest_incorrect'] = Variable<int>(pretestIncorrect.value);
    }
    if (practiceTotal.present) {
      map['practice_total'] = Variable<double>(practiceTotal.value);
    }
    if (posttestRaw.present) {
      map['posttest_raw'] = Variable<double>(posttestRaw.value);
    }
    if (posttestWeighted.present) {
      map['posttest_weighted'] = Variable<double>(posttestWeighted.value);
    }
    if (posttestCorrect.present) {
      map['posttest_correct'] = Variable<int>(posttestCorrect.value);
    }
    if (posttestIncorrect.present) {
      map['posttest_incorrect'] = Variable<int>(posttestIncorrect.value);
    }
    if (finalScore.present) {
      map['final_score'] = Variable<double>(finalScore.value);
    }
    if (learningGain.present) {
      map['learning_gain'] = Variable<double>(learningGain.value);
    }
    if (passed.present) {
      map['passed'] = Variable<bool>(passed.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningAttemptsCompanion(')
          ..write('id: $id, ')
          ..write('moduleId: $moduleId, ')
          ..write('attemptNumber: $attemptNumber, ')
          ..write('status: $status, ')
          ..write('contentVersion: $contentVersion, ')
          ..write('currentStage: $currentStage, ')
          ..write('currentSubIndex: $currentSubIndex, ')
          ..write('currentReadingId: $currentReadingId, ')
          ..write('lastRouteKey: $lastRouteKey, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('pretestRaw: $pretestRaw, ')
          ..write('pretestCorrect: $pretestCorrect, ')
          ..write('pretestIncorrect: $pretestIncorrect, ')
          ..write('practiceTotal: $practiceTotal, ')
          ..write('posttestRaw: $posttestRaw, ')
          ..write('posttestWeighted: $posttestWeighted, ')
          ..write('posttestCorrect: $posttestCorrect, ')
          ..write('posttestIncorrect: $posttestIncorrect, ')
          ..write('finalScore: $finalScore, ')
          ..write('learningGain: $learningGain, ')
          ..write('passed: $passed, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PracticeActivityResultsTable extends PracticeActivityResults
    with TableInfo<$PracticeActivityResultsTable, PracticeActivityResult> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PracticeActivityResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _attemptIdMeta = const VerificationMeta(
    'attemptId',
  );
  @override
  late final GeneratedColumn<String> attemptId = GeneratedColumn<String>(
    'attempt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityIndexMeta = const VerificationMeta(
    'activityIndex',
  );
  @override
  late final GeneratedColumn<int> activityIndex = GeneratedColumn<int>(
    'activity_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activityTypeMeta = const VerificationMeta(
    'activityType',
  );
  @override
  late final GeneratedColumn<String> activityType = GeneratedColumn<String>(
    'activity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctItemsMeta = const VerificationMeta(
    'correctItems',
  );
  @override
  late final GeneratedColumn<int> correctItems = GeneratedColumn<int>(
    'correct_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalItemsMeta = const VerificationMeta(
    'totalItems',
  );
  @override
  late final GeneratedColumn<int> totalItems = GeneratedColumn<int>(
    'total_items',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<int> score = GeneratedColumn<int>(
    'score',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("completed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _draftJsonMeta = const VerificationMeta(
    'draftJson',
  );
  @override
  late final GeneratedColumn<String> draftJson = GeneratedColumn<String>(
    'draft_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    attemptId,
    activityIndex,
    activityType,
    correctItems,
    totalItems,
    score,
    completed,
    draftJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'practice_activity_results';
  @override
  VerificationContext validateIntegrity(
    Insertable<PracticeActivityResult> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('attempt_id')) {
      context.handle(
        _attemptIdMeta,
        attemptId.isAcceptableOrUnknown(data['attempt_id']!, _attemptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_attemptIdMeta);
    }
    if (data.containsKey('activity_index')) {
      context.handle(
        _activityIndexMeta,
        activityIndex.isAcceptableOrUnknown(
          data['activity_index']!,
          _activityIndexMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityIndexMeta);
    }
    if (data.containsKey('activity_type')) {
      context.handle(
        _activityTypeMeta,
        activityType.isAcceptableOrUnknown(
          data['activity_type']!,
          _activityTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_activityTypeMeta);
    }
    if (data.containsKey('correct_items')) {
      context.handle(
        _correctItemsMeta,
        correctItems.isAcceptableOrUnknown(
          data['correct_items']!,
          _correctItemsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correctItemsMeta);
    }
    if (data.containsKey('total_items')) {
      context.handle(
        _totalItemsMeta,
        totalItems.isAcceptableOrUnknown(data['total_items']!, _totalItemsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalItemsMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
        _scoreMeta,
        score.isAcceptableOrUnknown(data['score']!, _scoreMeta),
      );
    } else if (isInserting) {
      context.missing(_scoreMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('draft_json')) {
      context.handle(
        _draftJsonMeta,
        draftJson.isAcceptableOrUnknown(data['draft_json']!, _draftJsonMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {attemptId, activityIndex},
  ];
  @override
  PracticeActivityResult map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PracticeActivityResult(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      attemptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt_id'],
      )!,
      activityIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}activity_index'],
      )!,
      activityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}activity_type'],
      )!,
      correctItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_items'],
      )!,
      totalItems: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_items'],
      )!,
      score: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score'],
      )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}completed'],
      )!,
      draftJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}draft_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $PracticeActivityResultsTable createAlias(String alias) {
    return $PracticeActivityResultsTable(attachedDatabase, alias);
  }
}

class PracticeActivityResult extends DataClass
    implements Insertable<PracticeActivityResult> {
  final int id;
  final String attemptId;
  final int activityIndex;
  final String activityType;
  final int correctItems;
  final int totalItems;
  final int score;
  final bool completed;
  final String draftJson;
  final DateTime updatedAt;
  const PracticeActivityResult({
    required this.id,
    required this.attemptId,
    required this.activityIndex,
    required this.activityType,
    required this.correctItems,
    required this.totalItems,
    required this.score,
    required this.completed,
    required this.draftJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['attempt_id'] = Variable<String>(attemptId);
    map['activity_index'] = Variable<int>(activityIndex);
    map['activity_type'] = Variable<String>(activityType);
    map['correct_items'] = Variable<int>(correctItems);
    map['total_items'] = Variable<int>(totalItems);
    map['score'] = Variable<int>(score);
    map['completed'] = Variable<bool>(completed);
    map['draft_json'] = Variable<String>(draftJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  PracticeActivityResultsCompanion toCompanion(bool nullToAbsent) {
    return PracticeActivityResultsCompanion(
      id: Value(id),
      attemptId: Value(attemptId),
      activityIndex: Value(activityIndex),
      activityType: Value(activityType),
      correctItems: Value(correctItems),
      totalItems: Value(totalItems),
      score: Value(score),
      completed: Value(completed),
      draftJson: Value(draftJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory PracticeActivityResult.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PracticeActivityResult(
      id: serializer.fromJson<int>(json['id']),
      attemptId: serializer.fromJson<String>(json['attemptId']),
      activityIndex: serializer.fromJson<int>(json['activityIndex']),
      activityType: serializer.fromJson<String>(json['activityType']),
      correctItems: serializer.fromJson<int>(json['correctItems']),
      totalItems: serializer.fromJson<int>(json['totalItems']),
      score: serializer.fromJson<int>(json['score']),
      completed: serializer.fromJson<bool>(json['completed']),
      draftJson: serializer.fromJson<String>(json['draftJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'attemptId': serializer.toJson<String>(attemptId),
      'activityIndex': serializer.toJson<int>(activityIndex),
      'activityType': serializer.toJson<String>(activityType),
      'correctItems': serializer.toJson<int>(correctItems),
      'totalItems': serializer.toJson<int>(totalItems),
      'score': serializer.toJson<int>(score),
      'completed': serializer.toJson<bool>(completed),
      'draftJson': serializer.toJson<String>(draftJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  PracticeActivityResult copyWith({
    int? id,
    String? attemptId,
    int? activityIndex,
    String? activityType,
    int? correctItems,
    int? totalItems,
    int? score,
    bool? completed,
    String? draftJson,
    DateTime? updatedAt,
  }) => PracticeActivityResult(
    id: id ?? this.id,
    attemptId: attemptId ?? this.attemptId,
    activityIndex: activityIndex ?? this.activityIndex,
    activityType: activityType ?? this.activityType,
    correctItems: correctItems ?? this.correctItems,
    totalItems: totalItems ?? this.totalItems,
    score: score ?? this.score,
    completed: completed ?? this.completed,
    draftJson: draftJson ?? this.draftJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  PracticeActivityResult copyWithCompanion(
    PracticeActivityResultsCompanion data,
  ) {
    return PracticeActivityResult(
      id: data.id.present ? data.id.value : this.id,
      attemptId: data.attemptId.present ? data.attemptId.value : this.attemptId,
      activityIndex: data.activityIndex.present
          ? data.activityIndex.value
          : this.activityIndex,
      activityType: data.activityType.present
          ? data.activityType.value
          : this.activityType,
      correctItems: data.correctItems.present
          ? data.correctItems.value
          : this.correctItems,
      totalItems: data.totalItems.present
          ? data.totalItems.value
          : this.totalItems,
      score: data.score.present ? data.score.value : this.score,
      completed: data.completed.present ? data.completed.value : this.completed,
      draftJson: data.draftJson.present ? data.draftJson.value : this.draftJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PracticeActivityResult(')
          ..write('id: $id, ')
          ..write('attemptId: $attemptId, ')
          ..write('activityIndex: $activityIndex, ')
          ..write('activityType: $activityType, ')
          ..write('correctItems: $correctItems, ')
          ..write('totalItems: $totalItems, ')
          ..write('score: $score, ')
          ..write('completed: $completed, ')
          ..write('draftJson: $draftJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    attemptId,
    activityIndex,
    activityType,
    correctItems,
    totalItems,
    score,
    completed,
    draftJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PracticeActivityResult &&
          other.id == this.id &&
          other.attemptId == this.attemptId &&
          other.activityIndex == this.activityIndex &&
          other.activityType == this.activityType &&
          other.correctItems == this.correctItems &&
          other.totalItems == this.totalItems &&
          other.score == this.score &&
          other.completed == this.completed &&
          other.draftJson == this.draftJson &&
          other.updatedAt == this.updatedAt);
}

class PracticeActivityResultsCompanion
    extends UpdateCompanion<PracticeActivityResult> {
  final Value<int> id;
  final Value<String> attemptId;
  final Value<int> activityIndex;
  final Value<String> activityType;
  final Value<int> correctItems;
  final Value<int> totalItems;
  final Value<int> score;
  final Value<bool> completed;
  final Value<String> draftJson;
  final Value<DateTime> updatedAt;
  const PracticeActivityResultsCompanion({
    this.id = const Value.absent(),
    this.attemptId = const Value.absent(),
    this.activityIndex = const Value.absent(),
    this.activityType = const Value.absent(),
    this.correctItems = const Value.absent(),
    this.totalItems = const Value.absent(),
    this.score = const Value.absent(),
    this.completed = const Value.absent(),
    this.draftJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  PracticeActivityResultsCompanion.insert({
    this.id = const Value.absent(),
    required String attemptId,
    required int activityIndex,
    required String activityType,
    required int correctItems,
    required int totalItems,
    required int score,
    required bool completed,
    this.draftJson = const Value.absent(),
    required DateTime updatedAt,
  }) : attemptId = Value(attemptId),
       activityIndex = Value(activityIndex),
       activityType = Value(activityType),
       correctItems = Value(correctItems),
       totalItems = Value(totalItems),
       score = Value(score),
       completed = Value(completed),
       updatedAt = Value(updatedAt);
  static Insertable<PracticeActivityResult> custom({
    Expression<int>? id,
    Expression<String>? attemptId,
    Expression<int>? activityIndex,
    Expression<String>? activityType,
    Expression<int>? correctItems,
    Expression<int>? totalItems,
    Expression<int>? score,
    Expression<bool>? completed,
    Expression<String>? draftJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (attemptId != null) 'attempt_id': attemptId,
      if (activityIndex != null) 'activity_index': activityIndex,
      if (activityType != null) 'activity_type': activityType,
      if (correctItems != null) 'correct_items': correctItems,
      if (totalItems != null) 'total_items': totalItems,
      if (score != null) 'score': score,
      if (completed != null) 'completed': completed,
      if (draftJson != null) 'draft_json': draftJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  PracticeActivityResultsCompanion copyWith({
    Value<int>? id,
    Value<String>? attemptId,
    Value<int>? activityIndex,
    Value<String>? activityType,
    Value<int>? correctItems,
    Value<int>? totalItems,
    Value<int>? score,
    Value<bool>? completed,
    Value<String>? draftJson,
    Value<DateTime>? updatedAt,
  }) {
    return PracticeActivityResultsCompanion(
      id: id ?? this.id,
      attemptId: attemptId ?? this.attemptId,
      activityIndex: activityIndex ?? this.activityIndex,
      activityType: activityType ?? this.activityType,
      correctItems: correctItems ?? this.correctItems,
      totalItems: totalItems ?? this.totalItems,
      score: score ?? this.score,
      completed: completed ?? this.completed,
      draftJson: draftJson ?? this.draftJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (attemptId.present) {
      map['attempt_id'] = Variable<String>(attemptId.value);
    }
    if (activityIndex.present) {
      map['activity_index'] = Variable<int>(activityIndex.value);
    }
    if (activityType.present) {
      map['activity_type'] = Variable<String>(activityType.value);
    }
    if (correctItems.present) {
      map['correct_items'] = Variable<int>(correctItems.value);
    }
    if (totalItems.present) {
      map['total_items'] = Variable<int>(totalItems.value);
    }
    if (score.present) {
      map['score'] = Variable<int>(score.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (draftJson.present) {
      map['draft_json'] = Variable<String>(draftJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PracticeActivityResultsCompanion(')
          ..write('id: $id, ')
          ..write('attemptId: $attemptId, ')
          ..write('activityIndex: $activityIndex, ')
          ..write('activityType: $activityType, ')
          ..write('correctItems: $correctItems, ')
          ..write('totalItems: $totalItems, ')
          ..write('score: $score, ')
          ..write('completed: $completed, ')
          ..write('draftJson: $draftJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AssessmentSessionsTable extends AssessmentSessions
    with TableInfo<$AssessmentSessionsTable, AssessmentSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AssessmentSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptIdMeta = const VerificationMeta(
    'attemptId',
  );
  @override
  late final GeneratedColumn<String> attemptId = GeneratedColumn<String>(
    'attempt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assessmentTypeMeta = const VerificationMeta(
    'assessmentType',
  );
  @override
  late final GeneratedColumn<String> assessmentType = GeneratedColumn<String>(
    'assessment_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _answersJsonMeta = const VerificationMeta(
    'answersJson',
  );
  @override
  late final GeneratedColumn<String> answersJson = GeneratedColumn<String>(
    'answers_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _questionOrderJsonMeta = const VerificationMeta(
    'questionOrderJson',
  );
  @override
  late final GeneratedColumn<String> questionOrderJson =
      GeneratedColumn<String>(
        'question_order_json',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('[]'),
      );
  static const VerificationMeta _currentQuestionIndexMeta =
      const VerificationMeta('currentQuestionIndex');
  @override
  late final GeneratedColumn<int> currentQuestionIndex = GeneratedColumn<int>(
    'current_question_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _submittedMeta = const VerificationMeta(
    'submitted',
  );
  @override
  late final GeneratedColumn<bool> submitted = GeneratedColumn<bool>(
    'submitted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("submitted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _rawScoreMeta = const VerificationMeta(
    'rawScore',
  );
  @override
  late final GeneratedColumn<double> rawScore = GeneratedColumn<double>(
    'raw_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightedScoreMeta = const VerificationMeta(
    'weightedScore',
  );
  @override
  late final GeneratedColumn<double> weightedScore = GeneratedColumn<double>(
    'weighted_score',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incorrectCountMeta = const VerificationMeta(
    'incorrectCount',
  );
  @override
  late final GeneratedColumn<int> incorrectCount = GeneratedColumn<int>(
    'incorrect_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _submittedAtMeta = const VerificationMeta(
    'submittedAt',
  );
  @override
  late final GeneratedColumn<DateTime> submittedAt = GeneratedColumn<DateTime>(
    'submitted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    attemptId,
    assessmentType,
    answersJson,
    questionOrderJson,
    currentQuestionIndex,
    submitted,
    rawScore,
    weightedScore,
    correctCount,
    incorrectCount,
    startedAt,
    submittedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'assessment_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<AssessmentSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('attempt_id')) {
      context.handle(
        _attemptIdMeta,
        attemptId.isAcceptableOrUnknown(data['attempt_id']!, _attemptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_attemptIdMeta);
    }
    if (data.containsKey('assessment_type')) {
      context.handle(
        _assessmentTypeMeta,
        assessmentType.isAcceptableOrUnknown(
          data['assessment_type']!,
          _assessmentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_assessmentTypeMeta);
    }
    if (data.containsKey('answers_json')) {
      context.handle(
        _answersJsonMeta,
        answersJson.isAcceptableOrUnknown(
          data['answers_json']!,
          _answersJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_answersJsonMeta);
    }
    if (data.containsKey('question_order_json')) {
      context.handle(
        _questionOrderJsonMeta,
        questionOrderJson.isAcceptableOrUnknown(
          data['question_order_json']!,
          _questionOrderJsonMeta,
        ),
      );
    }
    if (data.containsKey('current_question_index')) {
      context.handle(
        _currentQuestionIndexMeta,
        currentQuestionIndex.isAcceptableOrUnknown(
          data['current_question_index']!,
          _currentQuestionIndexMeta,
        ),
      );
    }
    if (data.containsKey('submitted')) {
      context.handle(
        _submittedMeta,
        submitted.isAcceptableOrUnknown(data['submitted']!, _submittedMeta),
      );
    }
    if (data.containsKey('raw_score')) {
      context.handle(
        _rawScoreMeta,
        rawScore.isAcceptableOrUnknown(data['raw_score']!, _rawScoreMeta),
      );
    }
    if (data.containsKey('weighted_score')) {
      context.handle(
        _weightedScoreMeta,
        weightedScore.isAcceptableOrUnknown(
          data['weighted_score']!,
          _weightedScoreMeta,
        ),
      );
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('incorrect_count')) {
      context.handle(
        _incorrectCountMeta,
        incorrectCount.isAcceptableOrUnknown(
          data['incorrect_count']!,
          _incorrectCountMeta,
        ),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('submitted_at')) {
      context.handle(
        _submittedAtMeta,
        submittedAt.isAcceptableOrUnknown(
          data['submitted_at']!,
          _submittedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AssessmentSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AssessmentSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      attemptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt_id'],
      )!,
      assessmentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}assessment_type'],
      )!,
      answersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}answers_json'],
      )!,
      questionOrderJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}question_order_json'],
      )!,
      currentQuestionIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_question_index'],
      )!,
      submitted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}submitted'],
      )!,
      rawScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}raw_score'],
      ),
      weightedScore: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weighted_score'],
      ),
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      ),
      incorrectCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}incorrect_count'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      )!,
      submittedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}submitted_at'],
      ),
    );
  }

  @override
  $AssessmentSessionsTable createAlias(String alias) {
    return $AssessmentSessionsTable(attachedDatabase, alias);
  }
}

class AssessmentSession extends DataClass
    implements Insertable<AssessmentSession> {
  final String id;
  final String attemptId;
  final String assessmentType;
  final String answersJson;
  final String questionOrderJson;
  final int currentQuestionIndex;
  final bool submitted;
  final double? rawScore;
  final double? weightedScore;
  final int? correctCount;
  final int? incorrectCount;
  final DateTime startedAt;
  final DateTime? submittedAt;
  const AssessmentSession({
    required this.id,
    required this.attemptId,
    required this.assessmentType,
    required this.answersJson,
    required this.questionOrderJson,
    required this.currentQuestionIndex,
    required this.submitted,
    this.rawScore,
    this.weightedScore,
    this.correctCount,
    this.incorrectCount,
    required this.startedAt,
    this.submittedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['attempt_id'] = Variable<String>(attemptId);
    map['assessment_type'] = Variable<String>(assessmentType);
    map['answers_json'] = Variable<String>(answersJson);
    map['question_order_json'] = Variable<String>(questionOrderJson);
    map['current_question_index'] = Variable<int>(currentQuestionIndex);
    map['submitted'] = Variable<bool>(submitted);
    if (!nullToAbsent || rawScore != null) {
      map['raw_score'] = Variable<double>(rawScore);
    }
    if (!nullToAbsent || weightedScore != null) {
      map['weighted_score'] = Variable<double>(weightedScore);
    }
    if (!nullToAbsent || correctCount != null) {
      map['correct_count'] = Variable<int>(correctCount);
    }
    if (!nullToAbsent || incorrectCount != null) {
      map['incorrect_count'] = Variable<int>(incorrectCount);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    if (!nullToAbsent || submittedAt != null) {
      map['submitted_at'] = Variable<DateTime>(submittedAt);
    }
    return map;
  }

  AssessmentSessionsCompanion toCompanion(bool nullToAbsent) {
    return AssessmentSessionsCompanion(
      id: Value(id),
      attemptId: Value(attemptId),
      assessmentType: Value(assessmentType),
      answersJson: Value(answersJson),
      questionOrderJson: Value(questionOrderJson),
      currentQuestionIndex: Value(currentQuestionIndex),
      submitted: Value(submitted),
      rawScore: rawScore == null && nullToAbsent
          ? const Value.absent()
          : Value(rawScore),
      weightedScore: weightedScore == null && nullToAbsent
          ? const Value.absent()
          : Value(weightedScore),
      correctCount: correctCount == null && nullToAbsent
          ? const Value.absent()
          : Value(correctCount),
      incorrectCount: incorrectCount == null && nullToAbsent
          ? const Value.absent()
          : Value(incorrectCount),
      startedAt: Value(startedAt),
      submittedAt: submittedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(submittedAt),
    );
  }

  factory AssessmentSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AssessmentSession(
      id: serializer.fromJson<String>(json['id']),
      attemptId: serializer.fromJson<String>(json['attemptId']),
      assessmentType: serializer.fromJson<String>(json['assessmentType']),
      answersJson: serializer.fromJson<String>(json['answersJson']),
      questionOrderJson: serializer.fromJson<String>(json['questionOrderJson']),
      currentQuestionIndex: serializer.fromJson<int>(
        json['currentQuestionIndex'],
      ),
      submitted: serializer.fromJson<bool>(json['submitted']),
      rawScore: serializer.fromJson<double?>(json['rawScore']),
      weightedScore: serializer.fromJson<double?>(json['weightedScore']),
      correctCount: serializer.fromJson<int?>(json['correctCount']),
      incorrectCount: serializer.fromJson<int?>(json['incorrectCount']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      submittedAt: serializer.fromJson<DateTime?>(json['submittedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'attemptId': serializer.toJson<String>(attemptId),
      'assessmentType': serializer.toJson<String>(assessmentType),
      'answersJson': serializer.toJson<String>(answersJson),
      'questionOrderJson': serializer.toJson<String>(questionOrderJson),
      'currentQuestionIndex': serializer.toJson<int>(currentQuestionIndex),
      'submitted': serializer.toJson<bool>(submitted),
      'rawScore': serializer.toJson<double?>(rawScore),
      'weightedScore': serializer.toJson<double?>(weightedScore),
      'correctCount': serializer.toJson<int?>(correctCount),
      'incorrectCount': serializer.toJson<int?>(incorrectCount),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'submittedAt': serializer.toJson<DateTime?>(submittedAt),
    };
  }

  AssessmentSession copyWith({
    String? id,
    String? attemptId,
    String? assessmentType,
    String? answersJson,
    String? questionOrderJson,
    int? currentQuestionIndex,
    bool? submitted,
    Value<double?> rawScore = const Value.absent(),
    Value<double?> weightedScore = const Value.absent(),
    Value<int?> correctCount = const Value.absent(),
    Value<int?> incorrectCount = const Value.absent(),
    DateTime? startedAt,
    Value<DateTime?> submittedAt = const Value.absent(),
  }) => AssessmentSession(
    id: id ?? this.id,
    attemptId: attemptId ?? this.attemptId,
    assessmentType: assessmentType ?? this.assessmentType,
    answersJson: answersJson ?? this.answersJson,
    questionOrderJson: questionOrderJson ?? this.questionOrderJson,
    currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
    submitted: submitted ?? this.submitted,
    rawScore: rawScore.present ? rawScore.value : this.rawScore,
    weightedScore: weightedScore.present
        ? weightedScore.value
        : this.weightedScore,
    correctCount: correctCount.present ? correctCount.value : this.correctCount,
    incorrectCount: incorrectCount.present
        ? incorrectCount.value
        : this.incorrectCount,
    startedAt: startedAt ?? this.startedAt,
    submittedAt: submittedAt.present ? submittedAt.value : this.submittedAt,
  );
  AssessmentSession copyWithCompanion(AssessmentSessionsCompanion data) {
    return AssessmentSession(
      id: data.id.present ? data.id.value : this.id,
      attemptId: data.attemptId.present ? data.attemptId.value : this.attemptId,
      assessmentType: data.assessmentType.present
          ? data.assessmentType.value
          : this.assessmentType,
      answersJson: data.answersJson.present
          ? data.answersJson.value
          : this.answersJson,
      questionOrderJson: data.questionOrderJson.present
          ? data.questionOrderJson.value
          : this.questionOrderJson,
      currentQuestionIndex: data.currentQuestionIndex.present
          ? data.currentQuestionIndex.value
          : this.currentQuestionIndex,
      submitted: data.submitted.present ? data.submitted.value : this.submitted,
      rawScore: data.rawScore.present ? data.rawScore.value : this.rawScore,
      weightedScore: data.weightedScore.present
          ? data.weightedScore.value
          : this.weightedScore,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      incorrectCount: data.incorrectCount.present
          ? data.incorrectCount.value
          : this.incorrectCount,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      submittedAt: data.submittedAt.present
          ? data.submittedAt.value
          : this.submittedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentSession(')
          ..write('id: $id, ')
          ..write('attemptId: $attemptId, ')
          ..write('assessmentType: $assessmentType, ')
          ..write('answersJson: $answersJson, ')
          ..write('questionOrderJson: $questionOrderJson, ')
          ..write('currentQuestionIndex: $currentQuestionIndex, ')
          ..write('submitted: $submitted, ')
          ..write('rawScore: $rawScore, ')
          ..write('weightedScore: $weightedScore, ')
          ..write('correctCount: $correctCount, ')
          ..write('incorrectCount: $incorrectCount, ')
          ..write('startedAt: $startedAt, ')
          ..write('submittedAt: $submittedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    attemptId,
    assessmentType,
    answersJson,
    questionOrderJson,
    currentQuestionIndex,
    submitted,
    rawScore,
    weightedScore,
    correctCount,
    incorrectCount,
    startedAt,
    submittedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AssessmentSession &&
          other.id == this.id &&
          other.attemptId == this.attemptId &&
          other.assessmentType == this.assessmentType &&
          other.answersJson == this.answersJson &&
          other.questionOrderJson == this.questionOrderJson &&
          other.currentQuestionIndex == this.currentQuestionIndex &&
          other.submitted == this.submitted &&
          other.rawScore == this.rawScore &&
          other.weightedScore == this.weightedScore &&
          other.correctCount == this.correctCount &&
          other.incorrectCount == this.incorrectCount &&
          other.startedAt == this.startedAt &&
          other.submittedAt == this.submittedAt);
}

class AssessmentSessionsCompanion extends UpdateCompanion<AssessmentSession> {
  final Value<String> id;
  final Value<String> attemptId;
  final Value<String> assessmentType;
  final Value<String> answersJson;
  final Value<String> questionOrderJson;
  final Value<int> currentQuestionIndex;
  final Value<bool> submitted;
  final Value<double?> rawScore;
  final Value<double?> weightedScore;
  final Value<int?> correctCount;
  final Value<int?> incorrectCount;
  final Value<DateTime> startedAt;
  final Value<DateTime?> submittedAt;
  final Value<int> rowid;
  const AssessmentSessionsCompanion({
    this.id = const Value.absent(),
    this.attemptId = const Value.absent(),
    this.assessmentType = const Value.absent(),
    this.answersJson = const Value.absent(),
    this.questionOrderJson = const Value.absent(),
    this.currentQuestionIndex = const Value.absent(),
    this.submitted = const Value.absent(),
    this.rawScore = const Value.absent(),
    this.weightedScore = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.incorrectCount = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.submittedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AssessmentSessionsCompanion.insert({
    required String id,
    required String attemptId,
    required String assessmentType,
    required String answersJson,
    this.questionOrderJson = const Value.absent(),
    this.currentQuestionIndex = const Value.absent(),
    this.submitted = const Value.absent(),
    this.rawScore = const Value.absent(),
    this.weightedScore = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.incorrectCount = const Value.absent(),
    required DateTime startedAt,
    this.submittedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       attemptId = Value(attemptId),
       assessmentType = Value(assessmentType),
       answersJson = Value(answersJson),
       startedAt = Value(startedAt);
  static Insertable<AssessmentSession> custom({
    Expression<String>? id,
    Expression<String>? attemptId,
    Expression<String>? assessmentType,
    Expression<String>? answersJson,
    Expression<String>? questionOrderJson,
    Expression<int>? currentQuestionIndex,
    Expression<bool>? submitted,
    Expression<double>? rawScore,
    Expression<double>? weightedScore,
    Expression<int>? correctCount,
    Expression<int>? incorrectCount,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? submittedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (attemptId != null) 'attempt_id': attemptId,
      if (assessmentType != null) 'assessment_type': assessmentType,
      if (answersJson != null) 'answers_json': answersJson,
      if (questionOrderJson != null) 'question_order_json': questionOrderJson,
      if (currentQuestionIndex != null)
        'current_question_index': currentQuestionIndex,
      if (submitted != null) 'submitted': submitted,
      if (rawScore != null) 'raw_score': rawScore,
      if (weightedScore != null) 'weighted_score': weightedScore,
      if (correctCount != null) 'correct_count': correctCount,
      if (incorrectCount != null) 'incorrect_count': incorrectCount,
      if (startedAt != null) 'started_at': startedAt,
      if (submittedAt != null) 'submitted_at': submittedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AssessmentSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? attemptId,
    Value<String>? assessmentType,
    Value<String>? answersJson,
    Value<String>? questionOrderJson,
    Value<int>? currentQuestionIndex,
    Value<bool>? submitted,
    Value<double?>? rawScore,
    Value<double?>? weightedScore,
    Value<int?>? correctCount,
    Value<int?>? incorrectCount,
    Value<DateTime>? startedAt,
    Value<DateTime?>? submittedAt,
    Value<int>? rowid,
  }) {
    return AssessmentSessionsCompanion(
      id: id ?? this.id,
      attemptId: attemptId ?? this.attemptId,
      assessmentType: assessmentType ?? this.assessmentType,
      answersJson: answersJson ?? this.answersJson,
      questionOrderJson: questionOrderJson ?? this.questionOrderJson,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      submitted: submitted ?? this.submitted,
      rawScore: rawScore ?? this.rawScore,
      weightedScore: weightedScore ?? this.weightedScore,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      startedAt: startedAt ?? this.startedAt,
      submittedAt: submittedAt ?? this.submittedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (attemptId.present) {
      map['attempt_id'] = Variable<String>(attemptId.value);
    }
    if (assessmentType.present) {
      map['assessment_type'] = Variable<String>(assessmentType.value);
    }
    if (answersJson.present) {
      map['answers_json'] = Variable<String>(answersJson.value);
    }
    if (questionOrderJson.present) {
      map['question_order_json'] = Variable<String>(questionOrderJson.value);
    }
    if (currentQuestionIndex.present) {
      map['current_question_index'] = Variable<int>(currentQuestionIndex.value);
    }
    if (submitted.present) {
      map['submitted'] = Variable<bool>(submitted.value);
    }
    if (rawScore.present) {
      map['raw_score'] = Variable<double>(rawScore.value);
    }
    if (weightedScore.present) {
      map['weighted_score'] = Variable<double>(weightedScore.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (incorrectCount.present) {
      map['incorrect_count'] = Variable<int>(incorrectCount.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (submittedAt.present) {
      map['submitted_at'] = Variable<DateTime>(submittedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AssessmentSessionsCompanion(')
          ..write('id: $id, ')
          ..write('attemptId: $attemptId, ')
          ..write('assessmentType: $assessmentType, ')
          ..write('answersJson: $answersJson, ')
          ..write('questionOrderJson: $questionOrderJson, ')
          ..write('currentQuestionIndex: $currentQuestionIndex, ')
          ..write('submitted: $submitted, ')
          ..write('rawScore: $rawScore, ')
          ..write('weightedScore: $weightedScore, ')
          ..write('correctCount: $correctCount, ')
          ..write('incorrectCount: $incorrectCount, ')
          ..write('startedAt: $startedAt, ')
          ..write('submittedAt: $submittedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ModuleBaselinesTable extends ModuleBaselines
    with TableInfo<$ModuleBaselinesTable, ModuleBaseline> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModuleBaselinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _moduleIdMeta = const VerificationMeta(
    'moduleId',
  );
  @override
  late final GeneratedColumn<int> moduleId = GeneratedColumn<int>(
    'module_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attemptIdMeta = const VerificationMeta(
    'attemptId',
  );
  @override
  late final GeneratedColumn<String> attemptId = GeneratedColumn<String>(
    'attempt_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pretestRawMeta = const VerificationMeta(
    'pretestRaw',
  );
  @override
  late final GeneratedColumn<double> pretestRaw = GeneratedColumn<double>(
    'pretest_raw',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correctCountMeta = const VerificationMeta(
    'correctCount',
  );
  @override
  late final GeneratedColumn<int> correctCount = GeneratedColumn<int>(
    'correct_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _incorrectCountMeta = const VerificationMeta(
    'incorrectCount',
  );
  @override
  late final GeneratedColumn<int> incorrectCount = GeneratedColumn<int>(
    'incorrect_count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    moduleId,
    attemptId,
    pretestRaw,
    correctCount,
    incorrectCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'module_baselines';
  @override
  VerificationContext validateIntegrity(
    Insertable<ModuleBaseline> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('module_id')) {
      context.handle(
        _moduleIdMeta,
        moduleId.isAcceptableOrUnknown(data['module_id']!, _moduleIdMeta),
      );
    }
    if (data.containsKey('attempt_id')) {
      context.handle(
        _attemptIdMeta,
        attemptId.isAcceptableOrUnknown(data['attempt_id']!, _attemptIdMeta),
      );
    } else if (isInserting) {
      context.missing(_attemptIdMeta);
    }
    if (data.containsKey('pretest_raw')) {
      context.handle(
        _pretestRawMeta,
        pretestRaw.isAcceptableOrUnknown(data['pretest_raw']!, _pretestRawMeta),
      );
    } else if (isInserting) {
      context.missing(_pretestRawMeta);
    }
    if (data.containsKey('correct_count')) {
      context.handle(
        _correctCountMeta,
        correctCount.isAcceptableOrUnknown(
          data['correct_count']!,
          _correctCountMeta,
        ),
      );
    }
    if (data.containsKey('incorrect_count')) {
      context.handle(
        _incorrectCountMeta,
        incorrectCount.isAcceptableOrUnknown(
          data['incorrect_count']!,
          _incorrectCountMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {moduleId};
  @override
  ModuleBaseline map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModuleBaseline(
      moduleId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}module_id'],
      )!,
      attemptId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attempt_id'],
      )!,
      pretestRaw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pretest_raw'],
      )!,
      correctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correct_count'],
      ),
      incorrectCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}incorrect_count'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ModuleBaselinesTable createAlias(String alias) {
    return $ModuleBaselinesTable(attachedDatabase, alias);
  }
}

class ModuleBaseline extends DataClass implements Insertable<ModuleBaseline> {
  final int moduleId;
  final String attemptId;
  final double pretestRaw;
  final int? correctCount;
  final int? incorrectCount;
  final DateTime createdAt;
  const ModuleBaseline({
    required this.moduleId,
    required this.attemptId,
    required this.pretestRaw,
    this.correctCount,
    this.incorrectCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['module_id'] = Variable<int>(moduleId);
    map['attempt_id'] = Variable<String>(attemptId);
    map['pretest_raw'] = Variable<double>(pretestRaw);
    if (!nullToAbsent || correctCount != null) {
      map['correct_count'] = Variable<int>(correctCount);
    }
    if (!nullToAbsent || incorrectCount != null) {
      map['incorrect_count'] = Variable<int>(incorrectCount);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ModuleBaselinesCompanion toCompanion(bool nullToAbsent) {
    return ModuleBaselinesCompanion(
      moduleId: Value(moduleId),
      attemptId: Value(attemptId),
      pretestRaw: Value(pretestRaw),
      correctCount: correctCount == null && nullToAbsent
          ? const Value.absent()
          : Value(correctCount),
      incorrectCount: incorrectCount == null && nullToAbsent
          ? const Value.absent()
          : Value(incorrectCount),
      createdAt: Value(createdAt),
    );
  }

  factory ModuleBaseline.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModuleBaseline(
      moduleId: serializer.fromJson<int>(json['moduleId']),
      attemptId: serializer.fromJson<String>(json['attemptId']),
      pretestRaw: serializer.fromJson<double>(json['pretestRaw']),
      correctCount: serializer.fromJson<int?>(json['correctCount']),
      incorrectCount: serializer.fromJson<int?>(json['incorrectCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'moduleId': serializer.toJson<int>(moduleId),
      'attemptId': serializer.toJson<String>(attemptId),
      'pretestRaw': serializer.toJson<double>(pretestRaw),
      'correctCount': serializer.toJson<int?>(correctCount),
      'incorrectCount': serializer.toJson<int?>(incorrectCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ModuleBaseline copyWith({
    int? moduleId,
    String? attemptId,
    double? pretestRaw,
    Value<int?> correctCount = const Value.absent(),
    Value<int?> incorrectCount = const Value.absent(),
    DateTime? createdAt,
  }) => ModuleBaseline(
    moduleId: moduleId ?? this.moduleId,
    attemptId: attemptId ?? this.attemptId,
    pretestRaw: pretestRaw ?? this.pretestRaw,
    correctCount: correctCount.present ? correctCount.value : this.correctCount,
    incorrectCount: incorrectCount.present
        ? incorrectCount.value
        : this.incorrectCount,
    createdAt: createdAt ?? this.createdAt,
  );
  ModuleBaseline copyWithCompanion(ModuleBaselinesCompanion data) {
    return ModuleBaseline(
      moduleId: data.moduleId.present ? data.moduleId.value : this.moduleId,
      attemptId: data.attemptId.present ? data.attemptId.value : this.attemptId,
      pretestRaw: data.pretestRaw.present
          ? data.pretestRaw.value
          : this.pretestRaw,
      correctCount: data.correctCount.present
          ? data.correctCount.value
          : this.correctCount,
      incorrectCount: data.incorrectCount.present
          ? data.incorrectCount.value
          : this.incorrectCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModuleBaseline(')
          ..write('moduleId: $moduleId, ')
          ..write('attemptId: $attemptId, ')
          ..write('pretestRaw: $pretestRaw, ')
          ..write('correctCount: $correctCount, ')
          ..write('incorrectCount: $incorrectCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    moduleId,
    attemptId,
    pretestRaw,
    correctCount,
    incorrectCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModuleBaseline &&
          other.moduleId == this.moduleId &&
          other.attemptId == this.attemptId &&
          other.pretestRaw == this.pretestRaw &&
          other.correctCount == this.correctCount &&
          other.incorrectCount == this.incorrectCount &&
          other.createdAt == this.createdAt);
}

class ModuleBaselinesCompanion extends UpdateCompanion<ModuleBaseline> {
  final Value<int> moduleId;
  final Value<String> attemptId;
  final Value<double> pretestRaw;
  final Value<int?> correctCount;
  final Value<int?> incorrectCount;
  final Value<DateTime> createdAt;
  const ModuleBaselinesCompanion({
    this.moduleId = const Value.absent(),
    this.attemptId = const Value.absent(),
    this.pretestRaw = const Value.absent(),
    this.correctCount = const Value.absent(),
    this.incorrectCount = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ModuleBaselinesCompanion.insert({
    this.moduleId = const Value.absent(),
    required String attemptId,
    required double pretestRaw,
    this.correctCount = const Value.absent(),
    this.incorrectCount = const Value.absent(),
    required DateTime createdAt,
  }) : attemptId = Value(attemptId),
       pretestRaw = Value(pretestRaw),
       createdAt = Value(createdAt);
  static Insertable<ModuleBaseline> custom({
    Expression<int>? moduleId,
    Expression<String>? attemptId,
    Expression<double>? pretestRaw,
    Expression<int>? correctCount,
    Expression<int>? incorrectCount,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (moduleId != null) 'module_id': moduleId,
      if (attemptId != null) 'attempt_id': attemptId,
      if (pretestRaw != null) 'pretest_raw': pretestRaw,
      if (correctCount != null) 'correct_count': correctCount,
      if (incorrectCount != null) 'incorrect_count': incorrectCount,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ModuleBaselinesCompanion copyWith({
    Value<int>? moduleId,
    Value<String>? attemptId,
    Value<double>? pretestRaw,
    Value<int?>? correctCount,
    Value<int?>? incorrectCount,
    Value<DateTime>? createdAt,
  }) {
    return ModuleBaselinesCompanion(
      moduleId: moduleId ?? this.moduleId,
      attemptId: attemptId ?? this.attemptId,
      pretestRaw: pretestRaw ?? this.pretestRaw,
      correctCount: correctCount ?? this.correctCount,
      incorrectCount: incorrectCount ?? this.incorrectCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (moduleId.present) {
      map['module_id'] = Variable<int>(moduleId.value);
    }
    if (attemptId.present) {
      map['attempt_id'] = Variable<String>(attemptId.value);
    }
    if (pretestRaw.present) {
      map['pretest_raw'] = Variable<double>(pretestRaw.value);
    }
    if (correctCount.present) {
      map['correct_count'] = Variable<int>(correctCount.value);
    }
    if (incorrectCount.present) {
      map['incorrect_count'] = Variable<int>(incorrectCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModuleBaselinesCompanion(')
          ..write('moduleId: $moduleId, ')
          ..write('attemptId: $attemptId, ')
          ..write('pretestRaw: $pretestRaw, ')
          ..write('correctCount: $correctCount, ')
          ..write('incorrectCount: $incorrectCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ModuleProgressTable moduleProgress = $ModuleProgressTable(this);
  late final $LearningAttemptsTable learningAttempts = $LearningAttemptsTable(
    this,
  );
  late final $PracticeActivityResultsTable practiceActivityResults =
      $PracticeActivityResultsTable(this);
  late final $AssessmentSessionsTable assessmentSessions =
      $AssessmentSessionsTable(this);
  late final $ModuleBaselinesTable moduleBaselines = $ModuleBaselinesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    moduleProgress,
    learningAttempts,
    practiceActivityResults,
    assessmentSessions,
    moduleBaselines,
  ];
}

typedef $$ModuleProgressTableCreateCompanionBuilder =
    ModuleProgressCompanion Function({
      Value<int> moduleId,
      Value<int> progressPercent,
      Value<String> status,
      Value<String?> currentStage,
      Value<int?> currentSubIndex,
      Value<String?> currentAttemptId,
      Value<String?> lastRouteKey,
      required DateTime updatedAt,
      Value<DateTime?> completedAt,
    });
typedef $$ModuleProgressTableUpdateCompanionBuilder =
    ModuleProgressCompanion Function({
      Value<int> moduleId,
      Value<int> progressPercent,
      Value<String> status,
      Value<String?> currentStage,
      Value<int?> currentSubIndex,
      Value<String?> currentAttemptId,
      Value<String?> lastRouteKey,
      Value<DateTime> updatedAt,
      Value<DateTime?> completedAt,
    });

class $$ModuleProgressTableFilterComposer
    extends Composer<_$AppDatabase, $ModuleProgressTable> {
  $$ModuleProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progressPercent => $composableBuilder(
    column: $table.progressPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentSubIndex => $composableBuilder(
    column: $table.currentSubIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentAttemptId => $composableBuilder(
    column: $table.currentAttemptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastRouteKey => $composableBuilder(
    column: $table.lastRouteKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ModuleProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $ModuleProgressTable> {
  $$ModuleProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progressPercent => $composableBuilder(
    column: $table.progressPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentSubIndex => $composableBuilder(
    column: $table.currentSubIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentAttemptId => $composableBuilder(
    column: $table.currentAttemptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastRouteKey => $composableBuilder(
    column: $table.lastRouteKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ModuleProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModuleProgressTable> {
  $$ModuleProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get moduleId =>
      $composableBuilder(column: $table.moduleId, builder: (column) => column);

  GeneratedColumn<int> get progressPercent => $composableBuilder(
    column: $table.progressPercent,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentSubIndex => $composableBuilder(
    column: $table.currentSubIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentAttemptId => $composableBuilder(
    column: $table.currentAttemptId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastRouteKey => $composableBuilder(
    column: $table.lastRouteKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );
}

class $$ModuleProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModuleProgressTable,
          ModuleProgressData,
          $$ModuleProgressTableFilterComposer,
          $$ModuleProgressTableOrderingComposer,
          $$ModuleProgressTableAnnotationComposer,
          $$ModuleProgressTableCreateCompanionBuilder,
          $$ModuleProgressTableUpdateCompanionBuilder,
          (
            ModuleProgressData,
            BaseReferences<
              _$AppDatabase,
              $ModuleProgressTable,
              ModuleProgressData
            >,
          ),
          ModuleProgressData,
          PrefetchHooks Function()
        > {
  $$ModuleProgressTableTableManager(
    _$AppDatabase db,
    $ModuleProgressTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModuleProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModuleProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModuleProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> moduleId = const Value.absent(),
                Value<int> progressPercent = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> currentStage = const Value.absent(),
                Value<int?> currentSubIndex = const Value.absent(),
                Value<String?> currentAttemptId = const Value.absent(),
                Value<String?> lastRouteKey = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
              }) => ModuleProgressCompanion(
                moduleId: moduleId,
                progressPercent: progressPercent,
                status: status,
                currentStage: currentStage,
                currentSubIndex: currentSubIndex,
                currentAttemptId: currentAttemptId,
                lastRouteKey: lastRouteKey,
                updatedAt: updatedAt,
                completedAt: completedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> moduleId = const Value.absent(),
                Value<int> progressPercent = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> currentStage = const Value.absent(),
                Value<int?> currentSubIndex = const Value.absent(),
                Value<String?> currentAttemptId = const Value.absent(),
                Value<String?> lastRouteKey = const Value.absent(),
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
              }) => ModuleProgressCompanion.insert(
                moduleId: moduleId,
                progressPercent: progressPercent,
                status: status,
                currentStage: currentStage,
                currentSubIndex: currentSubIndex,
                currentAttemptId: currentAttemptId,
                lastRouteKey: lastRouteKey,
                updatedAt: updatedAt,
                completedAt: completedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ModuleProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModuleProgressTable,
      ModuleProgressData,
      $$ModuleProgressTableFilterComposer,
      $$ModuleProgressTableOrderingComposer,
      $$ModuleProgressTableAnnotationComposer,
      $$ModuleProgressTableCreateCompanionBuilder,
      $$ModuleProgressTableUpdateCompanionBuilder,
      (
        ModuleProgressData,
        BaseReferences<_$AppDatabase, $ModuleProgressTable, ModuleProgressData>,
      ),
      ModuleProgressData,
      PrefetchHooks Function()
    >;
typedef $$LearningAttemptsTableCreateCompanionBuilder =
    LearningAttemptsCompanion Function({
      required String id,
      required int moduleId,
      required int attemptNumber,
      required String status,
      Value<int> contentVersion,
      Value<String> currentStage,
      Value<int?> currentSubIndex,
      Value<String?> currentReadingId,
      Value<String?> lastRouteKey,
      required DateTime startedAt,
      Value<DateTime?> completedAt,
      Value<double?> pretestRaw,
      Value<int?> pretestCorrect,
      Value<int?> pretestIncorrect,
      Value<double> practiceTotal,
      Value<double?> posttestRaw,
      Value<double?> posttestWeighted,
      Value<int?> posttestCorrect,
      Value<int?> posttestIncorrect,
      Value<double?> finalScore,
      Value<double?> learningGain,
      Value<bool?> passed,
      Value<int> rowid,
    });
typedef $$LearningAttemptsTableUpdateCompanionBuilder =
    LearningAttemptsCompanion Function({
      Value<String> id,
      Value<int> moduleId,
      Value<int> attemptNumber,
      Value<String> status,
      Value<int> contentVersion,
      Value<String> currentStage,
      Value<int?> currentSubIndex,
      Value<String?> currentReadingId,
      Value<String?> lastRouteKey,
      Value<DateTime> startedAt,
      Value<DateTime?> completedAt,
      Value<double?> pretestRaw,
      Value<int?> pretestCorrect,
      Value<int?> pretestIncorrect,
      Value<double> practiceTotal,
      Value<double?> posttestRaw,
      Value<double?> posttestWeighted,
      Value<int?> posttestCorrect,
      Value<int?> posttestIncorrect,
      Value<double?> finalScore,
      Value<double?> learningGain,
      Value<bool?> passed,
      Value<int> rowid,
    });

class $$LearningAttemptsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningAttemptsTable> {
  $$LearningAttemptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentSubIndex => $composableBuilder(
    column: $table.currentSubIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currentReadingId => $composableBuilder(
    column: $table.currentReadingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastRouteKey => $composableBuilder(
    column: $table.lastRouteKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pretestRaw => $composableBuilder(
    column: $table.pretestRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pretestCorrect => $composableBuilder(
    column: $table.pretestCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pretestIncorrect => $composableBuilder(
    column: $table.pretestIncorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get practiceTotal => $composableBuilder(
    column: $table.practiceTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get posttestRaw => $composableBuilder(
    column: $table.posttestRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get posttestWeighted => $composableBuilder(
    column: $table.posttestWeighted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get posttestCorrect => $composableBuilder(
    column: $table.posttestCorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get posttestIncorrect => $composableBuilder(
    column: $table.posttestIncorrect,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get finalScore => $composableBuilder(
    column: $table.finalScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get learningGain => $composableBuilder(
    column: $table.learningGain,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get passed => $composableBuilder(
    column: $table.passed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$LearningAttemptsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningAttemptsTable> {
  $$LearningAttemptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentSubIndex => $composableBuilder(
    column: $table.currentSubIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currentReadingId => $composableBuilder(
    column: $table.currentReadingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastRouteKey => $composableBuilder(
    column: $table.lastRouteKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pretestRaw => $composableBuilder(
    column: $table.pretestRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pretestCorrect => $composableBuilder(
    column: $table.pretestCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pretestIncorrect => $composableBuilder(
    column: $table.pretestIncorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get practiceTotal => $composableBuilder(
    column: $table.practiceTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get posttestRaw => $composableBuilder(
    column: $table.posttestRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get posttestWeighted => $composableBuilder(
    column: $table.posttestWeighted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get posttestCorrect => $composableBuilder(
    column: $table.posttestCorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get posttestIncorrect => $composableBuilder(
    column: $table.posttestIncorrect,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get finalScore => $composableBuilder(
    column: $table.finalScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get learningGain => $composableBuilder(
    column: $table.learningGain,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get passed => $composableBuilder(
    column: $table.passed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningAttemptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningAttemptsTable> {
  $$LearningAttemptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get moduleId =>
      $composableBuilder(column: $table.moduleId, builder: (column) => column);

  GeneratedColumn<int> get attemptNumber => $composableBuilder(
    column: $table.attemptNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get contentVersion => $composableBuilder(
    column: $table.contentVersion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentStage => $composableBuilder(
    column: $table.currentStage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentSubIndex => $composableBuilder(
    column: $table.currentSubIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currentReadingId => $composableBuilder(
    column: $table.currentReadingId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastRouteKey => $composableBuilder(
    column: $table.lastRouteKey,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pretestRaw => $composableBuilder(
    column: $table.pretestRaw,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pretestCorrect => $composableBuilder(
    column: $table.pretestCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pretestIncorrect => $composableBuilder(
    column: $table.pretestIncorrect,
    builder: (column) => column,
  );

  GeneratedColumn<double> get practiceTotal => $composableBuilder(
    column: $table.practiceTotal,
    builder: (column) => column,
  );

  GeneratedColumn<double> get posttestRaw => $composableBuilder(
    column: $table.posttestRaw,
    builder: (column) => column,
  );

  GeneratedColumn<double> get posttestWeighted => $composableBuilder(
    column: $table.posttestWeighted,
    builder: (column) => column,
  );

  GeneratedColumn<int> get posttestCorrect => $composableBuilder(
    column: $table.posttestCorrect,
    builder: (column) => column,
  );

  GeneratedColumn<int> get posttestIncorrect => $composableBuilder(
    column: $table.posttestIncorrect,
    builder: (column) => column,
  );

  GeneratedColumn<double> get finalScore => $composableBuilder(
    column: $table.finalScore,
    builder: (column) => column,
  );

  GeneratedColumn<double> get learningGain => $composableBuilder(
    column: $table.learningGain,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get passed =>
      $composableBuilder(column: $table.passed, builder: (column) => column);
}

class $$LearningAttemptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningAttemptsTable,
          LearningAttempt,
          $$LearningAttemptsTableFilterComposer,
          $$LearningAttemptsTableOrderingComposer,
          $$LearningAttemptsTableAnnotationComposer,
          $$LearningAttemptsTableCreateCompanionBuilder,
          $$LearningAttemptsTableUpdateCompanionBuilder,
          (
            LearningAttempt,
            BaseReferences<
              _$AppDatabase,
              $LearningAttemptsTable,
              LearningAttempt
            >,
          ),
          LearningAttempt,
          PrefetchHooks Function()
        > {
  $$LearningAttemptsTableTableManager(
    _$AppDatabase db,
    $LearningAttemptsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningAttemptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningAttemptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningAttemptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> moduleId = const Value.absent(),
                Value<int> attemptNumber = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> contentVersion = const Value.absent(),
                Value<String> currentStage = const Value.absent(),
                Value<int?> currentSubIndex = const Value.absent(),
                Value<String?> currentReadingId = const Value.absent(),
                Value<String?> lastRouteKey = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<double?> pretestRaw = const Value.absent(),
                Value<int?> pretestCorrect = const Value.absent(),
                Value<int?> pretestIncorrect = const Value.absent(),
                Value<double> practiceTotal = const Value.absent(),
                Value<double?> posttestRaw = const Value.absent(),
                Value<double?> posttestWeighted = const Value.absent(),
                Value<int?> posttestCorrect = const Value.absent(),
                Value<int?> posttestIncorrect = const Value.absent(),
                Value<double?> finalScore = const Value.absent(),
                Value<double?> learningGain = const Value.absent(),
                Value<bool?> passed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningAttemptsCompanion(
                id: id,
                moduleId: moduleId,
                attemptNumber: attemptNumber,
                status: status,
                contentVersion: contentVersion,
                currentStage: currentStage,
                currentSubIndex: currentSubIndex,
                currentReadingId: currentReadingId,
                lastRouteKey: lastRouteKey,
                startedAt: startedAt,
                completedAt: completedAt,
                pretestRaw: pretestRaw,
                pretestCorrect: pretestCorrect,
                pretestIncorrect: pretestIncorrect,
                practiceTotal: practiceTotal,
                posttestRaw: posttestRaw,
                posttestWeighted: posttestWeighted,
                posttestCorrect: posttestCorrect,
                posttestIncorrect: posttestIncorrect,
                finalScore: finalScore,
                learningGain: learningGain,
                passed: passed,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int moduleId,
                required int attemptNumber,
                required String status,
                Value<int> contentVersion = const Value.absent(),
                Value<String> currentStage = const Value.absent(),
                Value<int?> currentSubIndex = const Value.absent(),
                Value<String?> currentReadingId = const Value.absent(),
                Value<String?> lastRouteKey = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<double?> pretestRaw = const Value.absent(),
                Value<int?> pretestCorrect = const Value.absent(),
                Value<int?> pretestIncorrect = const Value.absent(),
                Value<double> practiceTotal = const Value.absent(),
                Value<double?> posttestRaw = const Value.absent(),
                Value<double?> posttestWeighted = const Value.absent(),
                Value<int?> posttestCorrect = const Value.absent(),
                Value<int?> posttestIncorrect = const Value.absent(),
                Value<double?> finalScore = const Value.absent(),
                Value<double?> learningGain = const Value.absent(),
                Value<bool?> passed = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningAttemptsCompanion.insert(
                id: id,
                moduleId: moduleId,
                attemptNumber: attemptNumber,
                status: status,
                contentVersion: contentVersion,
                currentStage: currentStage,
                currentSubIndex: currentSubIndex,
                currentReadingId: currentReadingId,
                lastRouteKey: lastRouteKey,
                startedAt: startedAt,
                completedAt: completedAt,
                pretestRaw: pretestRaw,
                pretestCorrect: pretestCorrect,
                pretestIncorrect: pretestIncorrect,
                practiceTotal: practiceTotal,
                posttestRaw: posttestRaw,
                posttestWeighted: posttestWeighted,
                posttestCorrect: posttestCorrect,
                posttestIncorrect: posttestIncorrect,
                finalScore: finalScore,
                learningGain: learningGain,
                passed: passed,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$LearningAttemptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningAttemptsTable,
      LearningAttempt,
      $$LearningAttemptsTableFilterComposer,
      $$LearningAttemptsTableOrderingComposer,
      $$LearningAttemptsTableAnnotationComposer,
      $$LearningAttemptsTableCreateCompanionBuilder,
      $$LearningAttemptsTableUpdateCompanionBuilder,
      (
        LearningAttempt,
        BaseReferences<_$AppDatabase, $LearningAttemptsTable, LearningAttempt>,
      ),
      LearningAttempt,
      PrefetchHooks Function()
    >;
typedef $$PracticeActivityResultsTableCreateCompanionBuilder =
    PracticeActivityResultsCompanion Function({
      Value<int> id,
      required String attemptId,
      required int activityIndex,
      required String activityType,
      required int correctItems,
      required int totalItems,
      required int score,
      required bool completed,
      Value<String> draftJson,
      required DateTime updatedAt,
    });
typedef $$PracticeActivityResultsTableUpdateCompanionBuilder =
    PracticeActivityResultsCompanion Function({
      Value<int> id,
      Value<String> attemptId,
      Value<int> activityIndex,
      Value<String> activityType,
      Value<int> correctItems,
      Value<int> totalItems,
      Value<int> score,
      Value<bool> completed,
      Value<String> draftJson,
      Value<DateTime> updatedAt,
    });

class $$PracticeActivityResultsTableFilterComposer
    extends Composer<_$AppDatabase, $PracticeActivityResultsTable> {
  $$PracticeActivityResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get activityIndex => $composableBuilder(
    column: $table.activityIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctItems => $composableBuilder(
    column: $table.correctItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get draftJson => $composableBuilder(
    column: $table.draftJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PracticeActivityResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $PracticeActivityResultsTable> {
  $$PracticeActivityResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get activityIndex => $composableBuilder(
    column: $table.activityIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctItems => $composableBuilder(
    column: $table.correctItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get score => $composableBuilder(
    column: $table.score,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get draftJson => $composableBuilder(
    column: $table.draftJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PracticeActivityResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PracticeActivityResultsTable> {
  $$PracticeActivityResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get attemptId =>
      $composableBuilder(column: $table.attemptId, builder: (column) => column);

  GeneratedColumn<int> get activityIndex => $composableBuilder(
    column: $table.activityIndex,
    builder: (column) => column,
  );

  GeneratedColumn<String> get activityType => $composableBuilder(
    column: $table.activityType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctItems => $composableBuilder(
    column: $table.correctItems,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalItems => $composableBuilder(
    column: $table.totalItems,
    builder: (column) => column,
  );

  GeneratedColumn<int> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<String> get draftJson =>
      $composableBuilder(column: $table.draftJson, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$PracticeActivityResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PracticeActivityResultsTable,
          PracticeActivityResult,
          $$PracticeActivityResultsTableFilterComposer,
          $$PracticeActivityResultsTableOrderingComposer,
          $$PracticeActivityResultsTableAnnotationComposer,
          $$PracticeActivityResultsTableCreateCompanionBuilder,
          $$PracticeActivityResultsTableUpdateCompanionBuilder,
          (
            PracticeActivityResult,
            BaseReferences<
              _$AppDatabase,
              $PracticeActivityResultsTable,
              PracticeActivityResult
            >,
          ),
          PracticeActivityResult,
          PrefetchHooks Function()
        > {
  $$PracticeActivityResultsTableTableManager(
    _$AppDatabase db,
    $PracticeActivityResultsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PracticeActivityResultsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PracticeActivityResultsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PracticeActivityResultsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> attemptId = const Value.absent(),
                Value<int> activityIndex = const Value.absent(),
                Value<String> activityType = const Value.absent(),
                Value<int> correctItems = const Value.absent(),
                Value<int> totalItems = const Value.absent(),
                Value<int> score = const Value.absent(),
                Value<bool> completed = const Value.absent(),
                Value<String> draftJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => PracticeActivityResultsCompanion(
                id: id,
                attemptId: attemptId,
                activityIndex: activityIndex,
                activityType: activityType,
                correctItems: correctItems,
                totalItems: totalItems,
                score: score,
                completed: completed,
                draftJson: draftJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String attemptId,
                required int activityIndex,
                required String activityType,
                required int correctItems,
                required int totalItems,
                required int score,
                required bool completed,
                Value<String> draftJson = const Value.absent(),
                required DateTime updatedAt,
              }) => PracticeActivityResultsCompanion.insert(
                id: id,
                attemptId: attemptId,
                activityIndex: activityIndex,
                activityType: activityType,
                correctItems: correctItems,
                totalItems: totalItems,
                score: score,
                completed: completed,
                draftJson: draftJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PracticeActivityResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PracticeActivityResultsTable,
      PracticeActivityResult,
      $$PracticeActivityResultsTableFilterComposer,
      $$PracticeActivityResultsTableOrderingComposer,
      $$PracticeActivityResultsTableAnnotationComposer,
      $$PracticeActivityResultsTableCreateCompanionBuilder,
      $$PracticeActivityResultsTableUpdateCompanionBuilder,
      (
        PracticeActivityResult,
        BaseReferences<
          _$AppDatabase,
          $PracticeActivityResultsTable,
          PracticeActivityResult
        >,
      ),
      PracticeActivityResult,
      PrefetchHooks Function()
    >;
typedef $$AssessmentSessionsTableCreateCompanionBuilder =
    AssessmentSessionsCompanion Function({
      required String id,
      required String attemptId,
      required String assessmentType,
      required String answersJson,
      Value<String> questionOrderJson,
      Value<int> currentQuestionIndex,
      Value<bool> submitted,
      Value<double?> rawScore,
      Value<double?> weightedScore,
      Value<int?> correctCount,
      Value<int?> incorrectCount,
      required DateTime startedAt,
      Value<DateTime?> submittedAt,
      Value<int> rowid,
    });
typedef $$AssessmentSessionsTableUpdateCompanionBuilder =
    AssessmentSessionsCompanion Function({
      Value<String> id,
      Value<String> attemptId,
      Value<String> assessmentType,
      Value<String> answersJson,
      Value<String> questionOrderJson,
      Value<int> currentQuestionIndex,
      Value<bool> submitted,
      Value<double?> rawScore,
      Value<double?> weightedScore,
      Value<int?> correctCount,
      Value<int?> incorrectCount,
      Value<DateTime> startedAt,
      Value<DateTime?> submittedAt,
      Value<int> rowid,
    });

class $$AssessmentSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $AssessmentSessionsTable> {
  $$AssessmentSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assessmentType => $composableBuilder(
    column: $table.assessmentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get questionOrderJson => $composableBuilder(
    column: $table.questionOrderJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentQuestionIndex => $composableBuilder(
    column: $table.currentQuestionIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get submitted => $composableBuilder(
    column: $table.submitted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rawScore => $composableBuilder(
    column: $table.rawScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightedScore => $composableBuilder(
    column: $table.weightedScore,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AssessmentSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $AssessmentSessionsTable> {
  $$AssessmentSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assessmentType => $composableBuilder(
    column: $table.assessmentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get questionOrderJson => $composableBuilder(
    column: $table.questionOrderJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentQuestionIndex => $composableBuilder(
    column: $table.currentQuestionIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get submitted => $composableBuilder(
    column: $table.submitted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rawScore => $composableBuilder(
    column: $table.rawScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightedScore => $composableBuilder(
    column: $table.weightedScore,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AssessmentSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AssessmentSessionsTable> {
  $$AssessmentSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get attemptId =>
      $composableBuilder(column: $table.attemptId, builder: (column) => column);

  GeneratedColumn<String> get assessmentType => $composableBuilder(
    column: $table.assessmentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get answersJson => $composableBuilder(
    column: $table.answersJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get questionOrderJson => $composableBuilder(
    column: $table.questionOrderJson,
    builder: (column) => column,
  );

  GeneratedColumn<int> get currentQuestionIndex => $composableBuilder(
    column: $table.currentQuestionIndex,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get submitted =>
      $composableBuilder(column: $table.submitted, builder: (column) => column);

  GeneratedColumn<double> get rawScore =>
      $composableBuilder(column: $table.rawScore, builder: (column) => column);

  GeneratedColumn<double> get weightedScore => $composableBuilder(
    column: $table.weightedScore,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get submittedAt => $composableBuilder(
    column: $table.submittedAt,
    builder: (column) => column,
  );
}

class $$AssessmentSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AssessmentSessionsTable,
          AssessmentSession,
          $$AssessmentSessionsTableFilterComposer,
          $$AssessmentSessionsTableOrderingComposer,
          $$AssessmentSessionsTableAnnotationComposer,
          $$AssessmentSessionsTableCreateCompanionBuilder,
          $$AssessmentSessionsTableUpdateCompanionBuilder,
          (
            AssessmentSession,
            BaseReferences<
              _$AppDatabase,
              $AssessmentSessionsTable,
              AssessmentSession
            >,
          ),
          AssessmentSession,
          PrefetchHooks Function()
        > {
  $$AssessmentSessionsTableTableManager(
    _$AppDatabase db,
    $AssessmentSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AssessmentSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AssessmentSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AssessmentSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> attemptId = const Value.absent(),
                Value<String> assessmentType = const Value.absent(),
                Value<String> answersJson = const Value.absent(),
                Value<String> questionOrderJson = const Value.absent(),
                Value<int> currentQuestionIndex = const Value.absent(),
                Value<bool> submitted = const Value.absent(),
                Value<double?> rawScore = const Value.absent(),
                Value<double?> weightedScore = const Value.absent(),
                Value<int?> correctCount = const Value.absent(),
                Value<int?> incorrectCount = const Value.absent(),
                Value<DateTime> startedAt = const Value.absent(),
                Value<DateTime?> submittedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssessmentSessionsCompanion(
                id: id,
                attemptId: attemptId,
                assessmentType: assessmentType,
                answersJson: answersJson,
                questionOrderJson: questionOrderJson,
                currentQuestionIndex: currentQuestionIndex,
                submitted: submitted,
                rawScore: rawScore,
                weightedScore: weightedScore,
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                startedAt: startedAt,
                submittedAt: submittedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String attemptId,
                required String assessmentType,
                required String answersJson,
                Value<String> questionOrderJson = const Value.absent(),
                Value<int> currentQuestionIndex = const Value.absent(),
                Value<bool> submitted = const Value.absent(),
                Value<double?> rawScore = const Value.absent(),
                Value<double?> weightedScore = const Value.absent(),
                Value<int?> correctCount = const Value.absent(),
                Value<int?> incorrectCount = const Value.absent(),
                required DateTime startedAt,
                Value<DateTime?> submittedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AssessmentSessionsCompanion.insert(
                id: id,
                attemptId: attemptId,
                assessmentType: assessmentType,
                answersJson: answersJson,
                questionOrderJson: questionOrderJson,
                currentQuestionIndex: currentQuestionIndex,
                submitted: submitted,
                rawScore: rawScore,
                weightedScore: weightedScore,
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                startedAt: startedAt,
                submittedAt: submittedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AssessmentSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AssessmentSessionsTable,
      AssessmentSession,
      $$AssessmentSessionsTableFilterComposer,
      $$AssessmentSessionsTableOrderingComposer,
      $$AssessmentSessionsTableAnnotationComposer,
      $$AssessmentSessionsTableCreateCompanionBuilder,
      $$AssessmentSessionsTableUpdateCompanionBuilder,
      (
        AssessmentSession,
        BaseReferences<
          _$AppDatabase,
          $AssessmentSessionsTable,
          AssessmentSession
        >,
      ),
      AssessmentSession,
      PrefetchHooks Function()
    >;
typedef $$ModuleBaselinesTableCreateCompanionBuilder =
    ModuleBaselinesCompanion Function({
      Value<int> moduleId,
      required String attemptId,
      required double pretestRaw,
      Value<int?> correctCount,
      Value<int?> incorrectCount,
      required DateTime createdAt,
    });
typedef $$ModuleBaselinesTableUpdateCompanionBuilder =
    ModuleBaselinesCompanion Function({
      Value<int> moduleId,
      Value<String> attemptId,
      Value<double> pretestRaw,
      Value<int?> correctCount,
      Value<int?> incorrectCount,
      Value<DateTime> createdAt,
    });

class $$ModuleBaselinesTableFilterComposer
    extends Composer<_$AppDatabase, $ModuleBaselinesTable> {
  $$ModuleBaselinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pretestRaw => $composableBuilder(
    column: $table.pretestRaw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ModuleBaselinesTableOrderingComposer
    extends Composer<_$AppDatabase, $ModuleBaselinesTable> {
  $$ModuleBaselinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get moduleId => $composableBuilder(
    column: $table.moduleId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attemptId => $composableBuilder(
    column: $table.attemptId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pretestRaw => $composableBuilder(
    column: $table.pretestRaw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ModuleBaselinesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModuleBaselinesTable> {
  $$ModuleBaselinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get moduleId =>
      $composableBuilder(column: $table.moduleId, builder: (column) => column);

  GeneratedColumn<String> get attemptId =>
      $composableBuilder(column: $table.attemptId, builder: (column) => column);

  GeneratedColumn<double> get pretestRaw => $composableBuilder(
    column: $table.pretestRaw,
    builder: (column) => column,
  );

  GeneratedColumn<int> get correctCount => $composableBuilder(
    column: $table.correctCount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get incorrectCount => $composableBuilder(
    column: $table.incorrectCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ModuleBaselinesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModuleBaselinesTable,
          ModuleBaseline,
          $$ModuleBaselinesTableFilterComposer,
          $$ModuleBaselinesTableOrderingComposer,
          $$ModuleBaselinesTableAnnotationComposer,
          $$ModuleBaselinesTableCreateCompanionBuilder,
          $$ModuleBaselinesTableUpdateCompanionBuilder,
          (
            ModuleBaseline,
            BaseReferences<
              _$AppDatabase,
              $ModuleBaselinesTable,
              ModuleBaseline
            >,
          ),
          ModuleBaseline,
          PrefetchHooks Function()
        > {
  $$ModuleBaselinesTableTableManager(
    _$AppDatabase db,
    $ModuleBaselinesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModuleBaselinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModuleBaselinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModuleBaselinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> moduleId = const Value.absent(),
                Value<String> attemptId = const Value.absent(),
                Value<double> pretestRaw = const Value.absent(),
                Value<int?> correctCount = const Value.absent(),
                Value<int?> incorrectCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ModuleBaselinesCompanion(
                moduleId: moduleId,
                attemptId: attemptId,
                pretestRaw: pretestRaw,
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> moduleId = const Value.absent(),
                required String attemptId,
                required double pretestRaw,
                Value<int?> correctCount = const Value.absent(),
                Value<int?> incorrectCount = const Value.absent(),
                required DateTime createdAt,
              }) => ModuleBaselinesCompanion.insert(
                moduleId: moduleId,
                attemptId: attemptId,
                pretestRaw: pretestRaw,
                correctCount: correctCount,
                incorrectCount: incorrectCount,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ModuleBaselinesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModuleBaselinesTable,
      ModuleBaseline,
      $$ModuleBaselinesTableFilterComposer,
      $$ModuleBaselinesTableOrderingComposer,
      $$ModuleBaselinesTableAnnotationComposer,
      $$ModuleBaselinesTableCreateCompanionBuilder,
      $$ModuleBaselinesTableUpdateCompanionBuilder,
      (
        ModuleBaseline,
        BaseReferences<_$AppDatabase, $ModuleBaselinesTable, ModuleBaseline>,
      ),
      ModuleBaseline,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ModuleProgressTableTableManager get moduleProgress =>
      $$ModuleProgressTableTableManager(_db, _db.moduleProgress);
  $$LearningAttemptsTableTableManager get learningAttempts =>
      $$LearningAttemptsTableTableManager(_db, _db.learningAttempts);
  $$PracticeActivityResultsTableTableManager get practiceActivityResults =>
      $$PracticeActivityResultsTableTableManager(
        _db,
        _db.practiceActivityResults,
      );
  $$AssessmentSessionsTableTableManager get assessmentSessions =>
      $$AssessmentSessionsTableTableManager(_db, _db.assessmentSessions);
  $$ModuleBaselinesTableTableManager get moduleBaselines =>
      $$ModuleBaselinesTableTableManager(_db, _db.moduleBaselines);
}
