import 'package:flutter/material.dart';
import 'package:lab1/components/DefaultContainer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DefaultContainer(child: Center()),
    );
  }
}
