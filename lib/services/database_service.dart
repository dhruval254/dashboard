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
      'stock': stock,
      'price': price,
      'discount': discount,
      'isOnSale': isOnSale,
      'isPopular': isPopular,
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

    await productDoc.update({
      'uid': productDoc.id,
      'imageList': FieldValue.arrayUnion(productImageLinkList),
    });
  }

  Future updateProducts(
    String productId,
    String productName,
    String category,
    String detail,
    int stock,
    int price,
    int discount,
    bool isPopular,
    bool isOnSale,
  ) async {
    await productCollection.doc(productId).update({
      'productName': productName,
      'category': category,
      'detail': detail,
      'stock': stock,
      'price': price,
      'discount': discount,
      'isOnSale': isOnSale,
      'isPopular': isPopular,
    });
  }

  Future<QuerySnapshot> getProducts() async {
    QuerySnapshot productData = await productCollection.get();

    return productData;
  }
}
