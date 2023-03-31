import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';

import '../services/database_service.dart';
import '../services/storage_service.dart';

import './product_editor_screen.dart';

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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
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
                  return Container(
                    padding: const EdgeInsets.all(18),
                    child: GridView.builder(
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 30.0,
                        mainAxisSpacing: 30.0,
                        mainAxisExtent: 360,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        double discountPrice = snapshot.data!.docs[index]
                                ['price'] -
                            (snapshot.data!.docs[index]['price'] *
                                (snapshot.data!.docs[index]['discount'] / 100));

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 3,
                                blurRadius: 5,
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 200,
                                child: FutureBuilder(
                                  future: StorageService().downloadFile(
                                    snapshot.data!.docs[index]['uid'],
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    if (snapshot.data == null) {
                                      return Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: const <Widget>[
                                            Text(
                                              'Image failed to load...',
                                            ),
                                            // TextButton(
                                            //   onPressed: () {
                                            //     setState(() {});
                                            //   },
                                            //   child: const Text(
                                            //     'Refresh',
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      );
                                    }

                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    const Text('Price: ',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    Text(
                                      snapshot.data!.docs[index]['price']
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Text(discountPrice.toString(),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '${snapshot.data!.docs[index]['productName']}\n',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                          ProductEditorScreen.routeName,
                                          arguments: {
                                            'isEditing': true,
                                            'productId': snapshot
                                                .data!.docs[index]['uid'],
                                            'productName': snapshot.data!
                                                .docs[index]['productName'],
                                            'category': snapshot
                                                .data!.docs[index]['category'],
                                            'productDetail': snapshot
                                                .data!.docs[index]['detail'],
                                            'productDiscount': snapshot
                                                .data!.docs[index]['discount']
                                                .toString(),
                                            'productStock': snapshot
                                                .data!.docs[index]['stock']
                                                .toString(),
                                            'productPrice': snapshot
                                                .data!.docs[index]['price']
                                                .toString(),
                                            'isOnSale': snapshot
                                                .data!.docs[index]['isOnSale'],
                                            'isPopular': snapshot
                                                .data!.docs[index]['isPopular'],
                                          },
                                        ).then((value) {
                                          setState(() {});
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.yellowAccent,
                                      ),
                                      child: const Text(
                                        'Edit',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                'Delete?',
                                              ),
                                              content: const Text(
                                                'Are you sure you want to delete this product?',
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    'No',
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await DatabaseService()
                                                        .deleteProducts(
                                                      snapshot.data!.docs[index]
                                                          ['uid'],
                                                    );

                                                    setState(() {});
                                                  },
                                                  child: const Text(
                                                    'Yes',
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      child: const Text(
                                        'Delete',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ListView.builder(
//               itemCount: snapshot.data!.docs.length,
//               itemBuilder: (context, index) {
//                 return InkWell(
                  // onTap: () {
                  //   Navigator.of(context).pushNamed(
                  //     ProductEditorScreen.routeName,
                  //     arguments: {
                  //       'isEditing': true,
                  //       'productId': snapshot.data!.docs[index]['uid'],
                  //       'productName': snapshot.data!.docs[index]
                  //           ['productName'],
                  //       'category': snapshot.data!.docs[index]['category'],
                  //       'productDetail': snapshot.data!.docs[index]['detail'],
                  //       'productDiscount':
                  //           snapshot.data!.docs[index]['discount'].toString(),
                  //       'productStock':
                  //           snapshot.data!.docs[index]['stock'].toString(),
                  //       'productPrice':
                  //           snapshot.data!.docs[index]['price'].toString(),
                  //       'isOnSale': snapshot.data!.docs[index]['isOnSale'],
                  //       'isPopular': snapshot.data!.docs[index]['isPopular'],
                  //     },
                  //   ).then((value) {
                  //     setState(() {});
                  //   });
                  // },
//                   child: Text(
//                     snapshot.data!.docs[index]['productName'],
//                   ),
//                 );
//               },
//             )
