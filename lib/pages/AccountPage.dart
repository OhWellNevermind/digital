import 'package:flutter/material.dart';
import 'package:lab1/api/UserApi.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/DefaultContainer.dart';
import 'package:lab1/components/Input.dart';
import 'package:lab1/database/tables/services/UserService.dart';
import 'package:lab1/model/user.dart';
import 'package:lab1/services/auth_service.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({int? userId, super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final service = UserService();

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();
    final _nameController = TextEditingController();
    String? error;

    Future<User?> getUser() async {
      try {
        final id = await authService.getUserId();

        var user = await getUserById(id);
        print(user);
        _nameController.text = user.name;
        return user;
      } catch (e) {
        print(e);
        Navigator.pushNamed(context, "/");
      }
      return null;
    }

    Future<void> submit() async {
      try {
        final id = await authService.getUserId();
        service.updateUser(id, _nameController.text);
      } catch (e) {
        setState(() {
          error = e.toString();
        });
        print(e);
      }
    }

    Future<void> logout() async {
      try {
        Navigator.pushNamed(context, '/');
        await authService.saveUserId(0);
      } catch (e) {
        Navigator.pushNamed(context, '/');
      }
    }

    return FutureBuilder(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: Text('Please wait its loading...'));
        } else {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return DefaultContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Input(label: 'Name', controller: _nameController),
                  ),
                  const SizedBox(height: 30),
                  CustomTextButton(
                    buttonText: 'Update',
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    onTap: submit,
                  ),
                  const SizedBox(height: 30),
                  CustomTextButton(
                    buttonText: 'Log out',
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Are you sure you want to logout?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: logout,
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('No'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (error != null)
                    Text(
                      error!,
                      style: TextStyle(color: Colors.red.shade800),
                    ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}
