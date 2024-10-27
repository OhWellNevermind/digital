import 'package:flutter/material.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/FormTextInput.dart';
import 'package:lab1/database/tables/services/UserService.dart';
import 'package:lab1/pages/MainPage.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final service = UserService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String? error;

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

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter name';
    }

    final nameValid = RegExp('[a-zA-Z]').hasMatch(value);

    if (!nameValid) {
      return 'Name may only contain letters';
    }

    return null;
  }

  Future<void> submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        final user = await service.register(
          _emailController.value.text,
          _passwordController.value.text,
          _nameController.value.text,
        );
        print(user.toMap());
        Navigator.pushNamed(
          context,
          '/main',
          arguments: ScreenArguments(user.id!),
        );
      } catch (e) {
        setState(() {
          error = e.toString();
        });
        print(e);
      }
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
              controller: _emailController,
            ),
            const SizedBox(height: 30),
            FormTextInput(
              validator: nameValidator,
              labelText: 'Name',
              controller: _nameController,
            ),
            const SizedBox(height: 30),
            FormTextInput(
              isObscure: true,
              validator: passwordValidator,
              labelText: 'Password',
              controller: _passwordController,
            ),
            const SizedBox(height: 30),
            CustomTextButton(
              buttonText: 'Register',
              padding: const EdgeInsets.symmetric(horizontal: 50),
              onTap: submit,
            ),
            if (error != null)
              Text(
                error!,
                style: TextStyle(color: Colors.red.shade300),
              ),
          ],
        ),
      ),
    );
  }
}
