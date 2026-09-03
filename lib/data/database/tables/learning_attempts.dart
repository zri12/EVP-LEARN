import 'package:drift/drift.dart';

class LearningAttempts extends Table {
  TextColumn get id => text()();
  IntColumn get moduleId => integer()();
  IntColumn get attemptNumber => integer()();
  TextColumn get status => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  RealColumn get pretestRaw => real().nullable()();
  IntColumn get pretestCorrect => integer().nullable()();
  IntColumn get pretestIncorrect => integer().nullable()();
  RealColumn get practiceTotal => real().withDefault(const Constant(0))();
  RealColumn get posttestRaw => real().nullable()();
  RealColumn get posttestWeighted => real().nullable()();
  IntColumn get posttestCorrect => integer().nullable()();
  IntColumn get posttestIncorrect => integer().nullable()();
  RealColumn get finalScore => real().nullable()();
  RealColumn get learningGain => real().nullable()();
  BoolColumn get passed => boolean().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
