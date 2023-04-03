import 'package:dashboard/screens/product_editor_screen.dart';
import 'package:dashboard/services/database_service.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'stock_card.dart';

class Stock extends StatefulWidget {
  const Stock({
    Key? key,
  }) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Stonks",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: defaultPadding * 1.5,
                  vertical: defaultPadding,
                ),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(
                  ProductEditorScreen.routeName,
                )
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(Icons.add),
              label: const Text("Add New"),
            ),
          ],
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        const FileInfoCardGridView(
          childAspectRatio: 2,
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FutureBuilder(
          future: DatabaseService().getDogProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            int stocks = 0;
            int totalStocks = 0;

            for (var element in snapshot.data!.docs) {
              Map product = element.data() as Map;

              stocks += product['stock'] as int;
            }

            for (var element in snapshot.data!.docs) {
              Map product = element.data() as Map;

              totalStocks += product['totalStock'] as int;
            }
            int remaining = totalStocks - stocks;

            return StockCard(
              category: 'Dog Products',
              color: Colors.blueAccent,
              remaining: remaining,
              totalStock: totalStocks,
            );
          },
        ),
        const SizedBox(height: 5),
        FutureBuilder(
          future: DatabaseService().getCatProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            int stocks = 0;
            int totalStocks = 0;

            for (var element in snapshot.data!.docs) {
              Map product = element.data() as Map;

              stocks += product['stock'] as int;
            }

            for (var element in snapshot.data!.docs) {
              Map product = element.data() as Map;

              totalStocks += product['totalStock'] as int;
            }
            int remaining = totalStocks - stocks;
            return StockCard(
              category: 'Cat Product',
              color: Colors.orangeAccent,
              remaining: remaining,
              totalStock: totalStocks,
            );
          },
        ),
      ],
    );
  }
}
