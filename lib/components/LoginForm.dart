import 'package:flutter/material.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/FormTextInput.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    final bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(value);

    if (!emailValid) {
      return 'Please enter valid email';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  void submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormTextInput(
              validator: emailValidator,
              labelText: 'Email',
            ),
            const SizedBox(height: 30),
            FormTextInput(
              isObscure: true,
              validator: passwordValidator,
              labelText: 'Password',
            ),
            const SizedBox(height: 30),
            CustomTextButton(
              buttonText: 'Login',
              padding: const EdgeInsets.symmetric(horizontal: 50),
              onTap: submit,
            ),
          ],
        ),
      ),
    );
  }
}
