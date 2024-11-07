import 'package:lab1/model/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initialize();
    return _database!;
  }

  Future<String> get fullPath async {
    const name = 'dev_db.db';
    final path = await getDatabasesPath();
    return join(path, name);
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
    );
    return database;
  }

  Future<void> create(Database database, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const stringType = 'VARCHAR(255) NOT NULL';
    const createdAtType = 'TIMESTAMP DEFAULT CURRENT_TIMESTAMP';

    await database.execute('''
      CREATE TABLE $tableUsers (${UserFields.id} $idType, 
      ${UserFields.email} $stringType, 
      ${UserFields.password} $stringType, 
      ${UserFields.name} TEXT DEFAULT "", 
      ${UserFields.createdAt} $createdAtType
      )
    ''');
  }
}
