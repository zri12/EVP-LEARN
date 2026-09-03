import 'package:drift/drift.dart';

class ModuleProgress extends Table {
  IntColumn get moduleId => integer()();
  IntColumn get progressPercent => integer().withDefault(const Constant(0))();
  TextColumn get status => text().withDefault(const Constant('not_started'))();
  TextColumn get currentStage => text().nullable()();
  IntColumn get currentSubIndex => integer().nullable()();
  TextColumn get currentAttemptId => text().nullable()();
  TextColumn get lastRouteKey => text().nullable()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {moduleId};
}
