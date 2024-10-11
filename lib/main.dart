import 'package:flutter/material.dart';
import 'package:lab1/pages/AccountPage.dart';
import 'package:lab1/pages/Home.dart';
import 'package:lab1/pages/LoginPage.dart';
import 'package:lab1/pages/MainPage.dart';
import 'package:lab1/pages/RegisterPage.dart';
import 'package:lab1/pages/WelcomePage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/account': (context) => const AccountPage(),
        '/main': (context) => const MainPage(),
        '/buy': (context) => const HomePage(),
      },
    );
  }
}
