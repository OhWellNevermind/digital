import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/FormTextInput.dart';
import 'package:lab1/database/tables/services/UserService.dart';
import 'package:lab1/pages/MainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final service = UserService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  bool isDisabled = false;

  @override
  void initState() {
    super.initState();
    _streamSubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        Fluttertoast.showToast(
            msg: "You're currently offline",
            backgroundColor: Colors.red.shade900,
            textColor: Colors.white);
        isDisabled = true;
      } else {
        isDisabled = false;
      }
    });
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

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

  Future<void> submit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      try {
        final user = await service.login(
          _emailController.value.text,
          _passwordController.value.text,
        );
        Fluttertoast.showToast(
          msg: "You're successfully logged in! Welcome back ${user.name}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 18.0,
        );
        print(user);
        await prefs.setInt('userId', user.id!);
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
              isObscure: true,
              validator: passwordValidator,
              labelText: 'Password',
              controller: _passwordController,
            ),
            const SizedBox(height: 30),
            CustomTextButton(
              buttonText: 'Login',
              padding: const EdgeInsets.symmetric(horizontal: 50),
              onTap: submit,
              disabled: isDisabled,
            ),
            const SizedBox(height: 30),
            if (error != null)
              Text(
                error!,
                style: TextStyle(color: Colors.red.shade800),
              ),
          ],
        ),
      ),
    );
  }
}
