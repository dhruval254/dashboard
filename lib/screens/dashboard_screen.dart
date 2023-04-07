import 'package:dashboard/services/database_service.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/recent_file.dart';
import '../widgets/header.dart';
import '../widgets/stock.dart';
import '../widgets/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            const Header(),
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      const Stock(),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        decoration: const BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Recent Orders",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text('Order uid'),
                                Text('Order Date'),
                                Text('City')
                              ],
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: FutureBuilder(
                                future: DatabaseService().getOrders(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }

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
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    width: double.infinity,
                                    child: ListView.builder(
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 50,
                                          width: double.infinity,
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          child: Card(
                                            elevation: 2,
                                            color: Colors.transparent,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text(
                                                      '${snapshot.data!.docs[index]['uid']}'),
                                                  Text(
                                                      '${snapshot.data!.docs[index]['orderDate']}'),
                                                  Text(
                                                      '${snapshot.data!.docs[index]['city']}')
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              // child: DataTable(
                              //   horizontalMargin: 0,
                              //   columnSpacing: defaultPadding,
                              //   columns: const [
                              //     DataColumn(
                              //       label: Text("Order Id"),
                              //     ),
                              //     DataColumn(
                              //       label: Text("Date"),
                              //     ),
                              //     DataColumn(
                              //       label: Text("City"),
                              //     ),
                              //   ],
                              //   rows:
                              //   // List.generate(
                              //   //   demoRecentFiles.length,
                              //   //   (index) => recentFileDataRow(
                              //   //     demoRecentFiles[index],
                              //   //   ),
                              //   // ),
                              // ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: defaultPadding,
                ),
                const Expanded(
                  flex: 2,
                  child: StorageDetails(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  DataRow recentFileDataRow(RecentFile orderInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                orderInfo.icon,
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  defaultPadding,
                ),
                child: Text(orderInfo.title),
              ),
            ],
          ),
        ),
        DataCell(
          Text(orderInfo.date),
        ),
        DataCell(
          Text(orderInfo.size),
        ),
      ],
    );
  }
}
