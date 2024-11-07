import 'package:lab1/model/user.dart';

abstract class UserServiceAbstract {
  Future<User> updateUser(int id, String name);

  Future<User> register(String email, String password, String name);

  Future<User> login(String email, String password);

  void deleteUser(int id);

  Future<User> getUserById(int id);
}
