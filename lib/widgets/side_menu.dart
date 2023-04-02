import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/orders.dart';
import 'drawer_list_tile.dart';

import '../screens/main_screen.dart';
import '../screens/login_screen.dart';
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
            // DrawerListTile(
            //   title: "Transaction",
            //   svgSrc: "assets/icons/menu_tran.svg",
            //   press: () {
            //     Navigator.of(context).pushNamedAndRemoveUntil(
            //       Transactions.routeName,
            //       (route) => false,
            //     );
            //   },
            // ),
            DrawerListTile(
              title: "Orders",
              svgSrc: "assets/icons/menu_task.svg",
              press: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  Orders.routeName,
                  (route) => false,
                );
              },
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
              title: "Log out",
              svgSrc: 'assets/icons/menu_logout.svg',
              press: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Log out?'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();

                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              LoginScreen.routeName,
                              (route) => false,
                            );
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
