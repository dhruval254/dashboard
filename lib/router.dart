import 'package:dashboard/screens/add_product.dart';
import 'package:dashboard/screens/login_screen.dart';
import 'package:dashboard/screens/main_screen.dart';
import 'package:dashboard/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AddProduct.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const AddProduct(),
      );

    // case UpdateProduct.routeName:
    //   return MaterialPageRoute(
    //     settings: routeSettings,
    //     builder: (context) => const UpdateProduct(),
    //   );

    case Transactions.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const Transactions(),
      );

    case LoginScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const LoginScreen(),
      );

    case MainScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const MainScreen(),
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
