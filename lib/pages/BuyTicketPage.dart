import 'package:flutter/material.dart';
import 'package:lab1/components/DefaultContainer.dart';
import 'package:lab1/components/buy-ticket-page/TicketsCountSelector.dart';

class BuyTicketPage extends StatelessWidget {
  const BuyTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultContainer(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: const Row(
              children: [TicketsCountSelector()],
            ),
          )
        ],
      )),
    );
  }
}
