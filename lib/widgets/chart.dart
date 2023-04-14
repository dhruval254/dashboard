import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

import '../services/database_service.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  Future<bool> countGender() async {
    final orderData = await DatabaseService().getOrders();
    int m = 0;
    int f = 0;

    for (var element in orderData.docs) {
      final user =
          await DatabaseService().getUserDataUsingUid(element['orderedById']);
      Map userData = user.data() as Map;

      if (userData['avatar'] == 'm') {
        m++;
      } else {
        f++;
      }
    }

    pieChartSectiondata.add(
      PieChartSectionData(
        value: m.toDouble(),
        color: primaryColor,
        showTitle: true,
        title: 'Males',
        radius: 25,
      ),
    );

    pieChartSectiondata.add(
      PieChartSectionData(
        value: f.toDouble(),
        color: Colors.redAccent,
        showTitle: true,
        title: 'Females',
        radius: 25,
      ),
    );

    return true;
  }

  @override
  void dispose() {
    super.dispose();
    pieChartSectiondata.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: FutureBuilder(
        future: countGender(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data == null) {
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

          return Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: pieChartSectiondata,
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: defaultPadding,
                    ),
                    // Text(
                    //   "29.1",
                    //   style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w600,
                    //         height: 0.5,
                    //       ),
                    // ),
                    // const Text("of 128GB"),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

List<PieChartSectionData> pieChartSectiondata = [
  // PieChartSectionData(
  //   value: 25,
  //   color: primaryColor,
  //   showTitle: false,
  //   radius: 25,
  // ),
  // PieChartSectionData(
  //   value: 20,
  //   color: const Color(0xff26e5ff),
  //   showTitle: false,
  //   radius: 22,
  // ),
  // PieChartSectionData(
  //   value: 10,
  //   color: const Color(0xffffcf26),
  //   showTitle: false,
  //   radius: 19,
  // ),
  // PieChartSectionData(
  //   value: 15,
  //   color: const Color(0xffee2727),
  //   showTitle: false,
  //   radius: 16,
  // ),
  // PieChartSectionData(
  //   value: 25,
  //   color: primaryColor.withOpacity(0.1),
  //   showTitle: false,
  //   radius: 13,
  // ),
];
