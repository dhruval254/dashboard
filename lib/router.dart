import 'package:dashboard/screens/add_product.dart';
import 'package:dashboard/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProduct(),
      );

    case Transactions.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Transactions(),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist!'),
          ),
        ),
      );
  }
}
