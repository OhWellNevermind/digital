import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lab1/api/UserApi.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/FormTextInput.dart';
import 'package:lab1/database/tables/services/UserService.dart';
import 'package:lab1/pages/MainPage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

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
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_formKey.currentState!.validate()) {
      try {
        final user = await registerUser(
          _emailController.value.text,
          _passwordController.value.text,
          _nameController.value.text,
        );
        Fluttertoast.showToast(
          msg:
              "You're successfully registered! Welcome to Digital Lviv ${_nameController.value.text}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.white,
          textColor: Colors.black,
          fontSize: 16.0,
        );
        await prefs.setInt('userId', user.id!);
        await prefs.setString('token', user.token!);
        Navigator.pushNamed(
          context,
          '/main',
          arguments: ScreenArguments(user.id!),
        );
      } catch (e) {
        setState(() {
          error = e.toString();
        });
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
              disabled: isDisabled,
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
