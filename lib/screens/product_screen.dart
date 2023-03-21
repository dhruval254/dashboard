import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';

import '../services/database_service.dart';

class ProductScreen extends StatefulWidget {
  static const routeName = '/product';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
        child: FutureBuilder(
          future: DatabaseService().getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.data == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Something Went Wrong...',
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text(
                        'Refresh',
                      ),
                    ),
                  ],
                ),
              );
            }

            return const Text('UI here');
          },
        ),
      ),
    );
  }
}

// ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: () {
//                     Navigator.of(context).pushNamed(
//                       ProductEditorScreen.routeName,
//                       arguments: {
//                         'isEditing': true,
//                         'productId': snapshot.data!.docs[index]['uid'],
//                         'productName': snapshot.data!.docs[index]
//                             ['productName'],
//                         'category': snapshot.data!.docs[index]['category'],
//                         'productDetail': snapshot.data!.docs[index]['detail'],
//                         'productDiscount':
//                             snapshot.data!.docs[index]['discount'].toString(),
//                         'productStock':
//                             snapshot.data!.docs[index]['stock'].toString(),
//                         'productPrice':
//                             snapshot.data!.docs[index]['price'].toString(),
//                         'isOnSale': snapshot.data!.docs[index]['isOnSale'],
//                         'isPopular': snapshot.data!.docs[index]['isPopular'],
//                       },
//                     ).then((value) {
//                       setState(() {});
//                     });
//                   },
//                   child: Text(
//                     snapshot.data!.docs[index]['productName'],
//                   ),
//                 );
//               },
//             )