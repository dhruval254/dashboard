import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../models/recent_file.dart';
import '../responsive.dart';
import '../widgets/header.dart';
import '../widgets/my_files.dart';
import '../widgets/storage_details.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                      const MyFiles(),
                      const SizedBox(
                        height: defaultPadding,
                      ),
                      // Reference to an enclosing class method cannot be extracted. (    extract widget from here , put it in screens/dashboard/components and file name = recent_files.dart and widget name =  RecentFiles()    )
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
                              "Recent Files",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                horizontalMargin: 0,
                                columnSpacing: defaultPadding,
                                columns: const [
                                  DataColumn(
                                    label: Text("File Name"),
                                  ),
                                  DataColumn(
                                    label: Text("Date"),
                                  ),
                                  DataColumn(
                                    label: Text("Size"),
                                  ),
                                ],
                                rows: List.generate(
                                  demoRecentFiles.length,
                                  (index) => recentFileDataRow(
                                    demoRecentFiles[index],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (Responsive.isMobile(context))
                        const SizedBox(
                          height: defaultPadding,
                        ),
                      if (Responsive.isMobile(context)) const StorageDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(
                    width: defaultPadding,
                  ),
                if (!Responsive.isMobile(context))
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

  DataRow recentFileDataRow(RecentFile fileInfo) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              SvgPicture.asset(
                fileInfo.icon,
                height: 30,
                width: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(
                  defaultPadding,
                ),
                child: Text(fileInfo.title),
              ),
            ],
          ),
        ),
        DataCell(
          Text(fileInfo.date),
        ),
        DataCell(
          Text(fileInfo.size),
        ),
      ],
    );
  }
}
