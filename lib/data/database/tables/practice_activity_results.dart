import 'package:drift/drift.dart';

class PracticeActivityResults extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get attemptId => text()();
  IntColumn get activityIndex => integer()();
  TextColumn get activityType => text()();
  IntColumn get correctItems => integer()();
  IntColumn get totalItems => integer()();
  IntColumn get score => integer()();
  BoolColumn get completed => boolean()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {attemptId, activityIndex},
  ];
}
