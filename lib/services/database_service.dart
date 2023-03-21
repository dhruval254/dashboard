import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';

import './storage_service.dart';

class DatabaseService {
  final productCollection = FirebaseFirestore.instance.collection('products');

  Future addProduct(
    String productName,
    String category,
    String detail,
    int stock,
    int price,
    int discount,
    List<Uint8List> productImageList,
    bool isPopular,
    bool isOnSale,
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

    for (Uint8List element in productImageList) {
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
