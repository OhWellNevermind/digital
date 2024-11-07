import 'package:flutter/material.dart';
import 'package:lab1/pages/AccountPage.dart';
import 'package:lab1/pages/BuyTicketPage.dart';
import 'package:lab1/pages/Home.dart';

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
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    print(args.id);

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
