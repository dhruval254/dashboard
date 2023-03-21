import 'package:flutter/material.dart';

import 'drawer_list_tile.dart';

import '../screens/main_screen.dart';
import '../screens/login_screen.dart';
import '../screens/transactions_screen.dart';
import '../screens/product_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "assets/icons/menu_dashbord.svg",
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  MainScreen.routeName,
                  (route) => false,
                );
              },
            ),
            DrawerListTile(
              title: "Transaction",
              svgSrc: "assets/icons/menu_tran.svg",
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Transactions.routeName,
                  (route) => false,
                );
              },
            ),
            DrawerListTile(
              title: "Orders",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {},
            ),
            DrawerListTile(
              title: "Products",
              svgSrc: "assets/icons/menu_store.svg",
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  ProductScreen.routeName,
                  (route) => false,
                );
              },
            ),
            DrawerListTile(
              title: "Login",
              svgSrc: 'assets/icons/Search.svg',
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  LoginScreen.routeName,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
