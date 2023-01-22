import 'package:dashboard/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
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
              children: [
                const SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  "29.1",
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                const Text("of 128GB"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> pieChartSectiondata = [
  PieChartSectionData(
    value: 25,
    color: primaryColor,
    showTitle: false,
    radius: 25,
  ),
  PieChartSectionData(
    value: 20,
    color: const Color(0xff26e5ff),
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    value: 10,
    color: const Color(0xffffcf26),
    showTitle: false,
    radius: 19,
  ),
  PieChartSectionData(
    value: 15,
    color: const Color(0xffee2727),
    showTitle: false,
    radius: 16,
  ),
  PieChartSectionData(
    value: 25,
    color: primaryColor.withOpacity(0.1),
    showTitle: false,
    radius: 13,
  ),
];
