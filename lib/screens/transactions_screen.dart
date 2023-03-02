import 'package:dashboard/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class Transactions extends StatelessWidget {
  static const String routeName = '/transactions';
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Expanded(
            child: SideMenu(),
          ),
          Expanded(
            flex: 5,
            child: Text("transactions"),
          ),
        ],
      )),
    );
  }
}
