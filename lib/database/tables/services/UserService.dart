import 'package:lab1/database/tables/abstract/UserService.dart';
import 'package:lab1/model/user.dart';

class UserService implements UserServiceAbstract {
  @override
  void deleteUser(int id) {
    // TODO: implement deleteUser
  }

  @override
  Future<User> getUserById(int id) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password, String name) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> updateUser(int id, String name) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }
}
