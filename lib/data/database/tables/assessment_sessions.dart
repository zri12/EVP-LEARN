import 'package:drift/drift.dart';

class AssessmentSessions extends Table {
  TextColumn get id => text()();
  TextColumn get attemptId => text()();
  TextColumn get assessmentType => text()();
  TextColumn get answersJson => text()();
  BoolColumn get submitted => boolean().withDefault(const Constant(false))();
  RealColumn get rawScore => real().nullable()();
  RealColumn get weightedScore => real().nullable()();
  IntColumn get correctCount => integer().nullable()();
  IntColumn get incorrectCount => integer().nullable()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get submittedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
