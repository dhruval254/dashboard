import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import './storage_service.dart';

class DatabaseSerivce {
  final productCollection = FirebaseFirestore.instance.collection('products');

  Future adProduct(
    String productName,
    String category,
    String detail,
    int price,
    int discount,
    List<File> productImageList,
  ) async {
    String productImageLink;
    List<String> productImageLinkList = [];
    var index = 0;

    final productDoc = await productCollection.add({
      'uid': null,
      'productName': productName,
      'category': category,
      'detail': detail,
      'imageList': null,
      'price': price,
      'discountPrice': discount,
    });

    for (File element in productImageList) {
      productImageLink = await StorageService().uploadProductsImages(
        productDoc.id,
        element,
        index.toString(),
      );

      productImageLinkList.add(productImageLink);
      index++;
    }

    productDoc.update({
      'uid': productDoc.id,
      'imageList': FieldValue.arrayUnion(productImageLinkList),
    });
  }
}
