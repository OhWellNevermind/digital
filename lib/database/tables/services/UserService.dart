import 'package:lab1/database/database_service.dart';
import 'package:lab1/database/tables/abstract/UserService.dart';
import 'package:lab1/model/user.dart';

class UserService implements UserServiceAbstract {
  final DatabaseService _databaseService = DatabaseService();

  @override
  void deleteUser(int id) async {
    final db = await _databaseService.database;
    await db.delete(tableUsers, where: '${UserFields.id} = ?', whereArgs: [id]);
  }

  @override
  Future<User> login(String email, String password) async {
    final db = await _databaseService.database;
    final result = await db.query(tableUsers,
        where: '${UserFields.email} = ? AND ${UserFields.password} = ?',
        whereArgs: [email, password]);
    print('login');
    print(result);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<User> register(
    String email,
    String password,
    String name,
  ) async {
    final db = await _databaseService.database;

    final existingUser = await db.query(
      tableUsers,
      where: '${UserFields.email} = ?',
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      throw Exception('Email already registered');
    }

    final newUser = User(
      email: email,
      password: password,
      name: name,
    );

    final id = await db.insert(tableUsers, newUser.toMap());
    return newUser.copyWith(id: id);
  }

  @override
  Future<User> updateUser(int id, String name) async {
    final db = await _databaseService.database;

    await db.update(
      tableUsers,
      {UserFields.name: name},
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    final updatedUser = await db
        .query(tableUsers, where: '${UserFields.id} = ?', whereArgs: [id]);
    if (updatedUser.isNotEmpty) {
      return User.fromMap(updatedUser.first);
    } else {
      throw Exception('User not found');
    }
  }

  @override
  Future<User> getUserById(int id) async {
    final db = await _databaseService.database;

    final result = await db.query(
      tableUsers,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
    print('get by id');
    print(result);
    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      throw Exception('User not found');
    }
  }
}
