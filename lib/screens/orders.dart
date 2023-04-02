import 'package:flutter/material.dart';

import '../widgets/side_menu.dart';

import '../services/database_service.dart';

class Orders extends StatefulWidget {
  static const String routeName = '/Orders';
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Text(
                    'Orders List',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: FutureBuilder(
                      future: DatabaseService().getOrders(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return Center(
                            child: Column(
                              children: <Widget>[
                                const Text(
                                  'Something went wrong...',
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {});
                                  },
                                  child: const Text('Refresh'),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            String uid = snapshot.data!.docs[index].id;
                            String orderedBy =
                                snapshot.data!.docs[index]['orderedById'];
                            String? orderId =
                                snapshot.data!.docs[index]['orderId'];
                            String? paymentId =
                                snapshot.data!.docs[index]['paymentId'];
                            int quantity =
                                snapshot.data!.docs[index]['quantity'];
                            bool isOrderDelivered =
                                snapshot.data!.docs[index]['isOrderDelivered'];
                            bool isOrderCancelled =
                                snapshot.data!.docs[index]['isOrderCancelled'];
                            String paymentMethod =
                                snapshot.data!.docs[index]['paymentMethod'];
                            String orderedOn =
                                snapshot.data!.docs[index]['orderDate'];

                            return FutureBuilder(
                                future: DatabaseService().getProductsUsingUid(
                                  snapshot.data!.docs[index]['productId'],
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData ||
                                      snapshot.data == null) {
                                    return Center(
                                      child: Column(
                                        children: <Widget>[
                                          const Text(
                                            'Something went wrong...',
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              setState(() {});
                                            },
                                            child: const Text('Refresh'),
                                          ),
                                        ],
                                      ),
                                    );
                                  }

                                  Map productData =
                                      snapshot.data!.data() as Map;
                                  double productPrice = productData['price'] -
                                      (productData['price'] *
                                          (productData['discount'] / 100));

                                  String orderPrice = (productPrice * quantity)
                                      .toStringAsFixed(2);

                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.transparent,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Product name: ${productData['productName']}',
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Unique Id: $uid',
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'User Id: $orderedBy',
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Order Id: ${orderId ?? 'Pay on delivery'}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Payment Id: ${paymentId ?? 'Pay on delivery'}',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Quantity: ${quantity.toString()}',
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Payment Method: $paymentMethod',
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      'Price paid/to be paid: $orderPrice',
                                                      style: const TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                isOrderCancelled
                                                    ? const Text(
                                                        'Order Cancelled',
                                                        style: TextStyle(
                                                          color:
                                                              Colors.redAccent,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: 1,
                                                        ),
                                                      )
                                                    : ElevatedButton(
                                                        onPressed:
                                                            isOrderDelivered
                                                                ? () {}
                                                                : () async {
                                                                    await DatabaseService()
                                                                        .setDelieveryStatusTrue(
                                                                            uid);

                                                                    setState(
                                                                        () {});
                                                                  },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              isOrderDelivered
                                                                  ? Colors
                                                                      .greenAccent
                                                                  : Colors
                                                                      .redAccent,
                                                        ),
                                                        child: Text(
                                                          isOrderDelivered
                                                              ? 'Delievered'
                                                              : 'Not Delievered',
                                                          style: TextStyle(
                                                            color:
                                                                isOrderDelivered
                                                                    ? Colors
                                                                        .black
                                                                    : null,
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                            const Divider(),
                                            Text(
                                              'Order Date: $orderedOn',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.grey,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
