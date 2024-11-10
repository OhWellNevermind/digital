import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lab1/components/CustomTextButton.dart';
import 'package:lab1/components/DefaultContainer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<dynamic> _streamSubscription;
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();

    _streamSubscription = _connectivity.onConnectivityChanged.listen((result) {
      print(result);
      if (result[0] == ConnectivityResult.none) {
        Fluttertoast.showToast(
          msg: "You're disconnected from internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.red.shade900,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          isDisabled = true;
        });
      } else {
        setState(() {
          isDisabled = false;
        });
      }
    });
    _loadSavedValue();
    _getConnectionStatus();
  }

  @override
  dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void _getConnectionStatus() async {
    final connectionStatus = await Connectivity().checkConnectivity();

    if (connectionStatus[0] == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "You're disconnected from internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red.shade900,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      setState(() {
        isDisabled = true;
      });
    } else {
      setState(() {
        isDisabled = false;
      });
    }
  }

  void _loadSavedValue() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("userId");
    print(userId);
    if (userId != 0 && userId != null) {
      Navigator.pushNamed(context, '/main');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultContainer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Digital Lviv',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Digital Lviv: Effortless Travel, Seamless City Life',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextButton(
                      buttonText: 'Login',
                      onTap: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      disabled: isDisabled,
                    ),
                    const SizedBox(width: 50),
                    CustomTextButton(
                      buttonText: 'Register',
                      onTap: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      disabled: isDisabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
