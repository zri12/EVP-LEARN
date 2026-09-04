import 'package:drift/native.dart';
import 'package:evp_learn/data/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('database initializes with schema version 2', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);

    final result = await database.customSelect('SELECT 1 AS value').getSingle();

    expect(database.schemaVersion, 2);
    expect(result.read<int>('value'), 1);
  });
}
