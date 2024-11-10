import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab1/pages/AccountPage.dart';
import 'package:lab1/pages/BuyTicketPage.dart';
import 'package:lab1/pages/Home.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenArguments {
  final int id;

  ScreenArguments(this.id);
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPageIndex = 0;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
    _loadSavedValue();
    _getConnectionStatus();
    _streamSubscription = _connectivity.onConnectivityChanged.listen((result) {
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
        Navigator.pushNamed(context, '/');
      }
    });
  }

  void _loadSavedValue() async {
    print("load");
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');
    print(userId);
    if (userId == 0 || userId == null) {
      Navigator.pushNamed(context, '/');
    }
  }

  void _getConnectionStatus() async {
    final connectionStatus = await Connectivity().checkConnectivity();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

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
      await prefs.setInt('userId', 0);
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  final _tabs = [
    const Center(
      child: HomePage(),
    ),
    const Center(
      child: BuyTicketPage(),
    ),
    const Center(
      child: AccountPage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.qr_code_2),
            label: 'Buy QR-ticket',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
      body: _tabs[currentPageIndex],
    );
  }
}
