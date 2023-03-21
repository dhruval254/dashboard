import 'package:dashboard/screens/product_editor_screen.dart';
import 'package:dashboard/screens/login_screen.dart';
import 'package:dashboard/screens/main_screen.dart';
import 'package:dashboard/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

import './screens/product_screen.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case ProductEditorScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const ProductEditorScreen(),
      );

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

    case ProductScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => const ProductScreen(),
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
