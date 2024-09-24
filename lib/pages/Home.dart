import 'package:flutter/material.dart';
import 'package:lab1/components/Input.dart';

class User {
  User({
    required this.password,
    required this.username,
  });

  final String username;
  final String password;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> users = [];

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void addUserToList() {
    users.add(
      User(
        username: usernameController.text,
        password: passwordController.text,
      ),
    );
    setState(() {
      users = users;
    });
    usernameController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Column(
          children: [
            Input(
              controller: usernameController,
              label: 'Login',
              margin: const EdgeInsets.only(bottom: 10),
            ),
            Input(
              controller: passwordController,
              label: 'Password',
              isObscure: true,
            ),
            TextButton(
              onPressed: addUserToList,
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.blueAccent,
              ),
              child: const Text(
                'Add user',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            Column(
              children: users
                  .map<Widget>((User e) => Text(
                        e.username,
                        style: const TextStyle(color: Colors.black),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
