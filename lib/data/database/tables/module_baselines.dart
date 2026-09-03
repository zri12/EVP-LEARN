import 'package:drift/drift.dart';

class ModuleBaselines extends Table {
  IntColumn get moduleId => integer()();
  TextColumn get attemptId => text()();
  RealColumn get pretestRaw => real()();
  IntColumn get correctCount => integer().nullable()();
  IntColumn get incorrectCount => integer().nullable()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {moduleId};
}
