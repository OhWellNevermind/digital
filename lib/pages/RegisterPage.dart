import 'package:flutter/material.dart';
import 'package:lab1/components/DefaultAppBar.dart';
import 'package:lab1/components/DefaultContainer.dart';
import 'package:lab1/components/RegisterForm.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DefaultAppBar(),
      body: DefaultContainer(
        child: Center(child: RegisterForm()),
      ),
    );
  }
}
