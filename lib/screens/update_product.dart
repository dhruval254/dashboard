// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import '../widgets/side_menu.dart';

// class UpdateProduct extends StatefulWidget {
//   static const String routeName = '/update-product';
//   const UpdateProduct({super.key});

//   @override
//   State<UpdateProduct> createState() => _UpdateProductState();
// }

// class _UpdateProductState extends State<UpdateProduct> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const SideMenu(),
//       body: SafeArea(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Expanded(
//             //   child: SideMenu(),
//             // ),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Container(
//                     child: Center(
//                       child: Column(
//                         children: [
//                           Text(
//                             "UPDATE",
//                           ),
//                           StreamBuilder(
//                             stream: FirebaseFirestore.instance
//                                 .collection('products')
//                                 .snapshots(),
//                             builder: (BuildContext context,
//                                 AsyncSnapshot<QuerySnapshot> snapshot) {
//                               if (!snapshot.hasData) {
//                                 return Center(
//                                     child: CircularProgressIndicator());
//                               }
//                               if (snapshot.data == null) {
//                                 return Center(
//                                   child: Text('No data exists'),
//                                 );
//                               }
//                               final data = snapshot.data!.docs;
//                               return Expanded(
//                                 child: ListView.builder(
//                                   itemCount: snapshot.data!.docs.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Container(
//                                         color: Colors.primaries[
//                                             Random().nextInt(data.length)],
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: ListTile(
//                                             title: Text(
//                                                 data[index]['productName']),
//                                             trailing: IconButton(
//                                                 onPressed: () {},
//                                                 icon: Icon(Icons.edit)),
//                                           ),
//                                         ));
//                                   },
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
