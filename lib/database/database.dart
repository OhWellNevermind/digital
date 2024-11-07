import 'package:sqflite/sqflite.dart';

class DB {
  final tableName = 'users';

  Future<void> createTable(Database database) async {
    await database.execute('''
      CREATE TABLE IF NOT EXIST $tableName (
      id INTEGER NOT NULL,
      email TEXT NOT NULL,
      password TEXT NOT NULL,
      name TEXT NOT NULL,
      createdAt INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
      PRIMARY KEY('id' AUTOINCREMENT)
      );
''');
  }
}
