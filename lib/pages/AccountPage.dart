import 'package:flutter/material.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/DefaultContainer.dart';
import 'package:lab1/components/Input.dart';
import 'package:lab1/database/tables/services/UserService.dart';
import 'package:lab1/model/user.dart';
import 'package:lab1/pages/MainPage.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({int? userId, super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final service = UserService();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
    final _nameController = TextEditingController();
    String? error;

    Future<User> getUser() async {
      var user = await service.getUserById(args.id);
      _nameController.text = user.name;
      return user;
    }

    Future<void> submit() async {
      try {
        service.updateUser(args.id, _nameController.text);
      } catch (e) {
        setState(() {
          error = e.toString();
        });
        print(e);
      }
    }

    return FutureBuilder(
      future: getUser(),
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
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
