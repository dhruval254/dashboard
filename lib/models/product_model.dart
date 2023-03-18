import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? category;
  String? id;
  String? productName;
  String? detail;
  // String? brand;
  int? price;
  int? discountPrice;
  String? serialCode;
  List<dynamic>? imageUrls;
  bool? isSale;
  bool? isPopular;
  bool? isFavourite;

  Products({
    required this.category,
    required this.id,
    required this.productName,
    required this.detail,
    required this.price,
    // required this.brand,
    required this.discountPrice,
    required this.serialCode,
    required this.imageUrls,
    required this.isSale,
    required this.isPopular,
    required this.isFavourite,
  });

  static Future<void> addProducts(Products products) async {
  CollectionReference db = FirebaseFirestore.instance.collection("products");
    Map<String, dynamic> data = {
      "category": products.category,
      "productName": products.productName,
      "id": products.id,
      "detail": products.detail,
      "price": products.price,
      "discountPrice": products.discountPrice,
      "serialCode": products.serialCode,
      "imageUrls": products.imageUrls,
      "isSale": products.isSale,
      "isPopular": products.isPopular,
      "isFavourite": products.isFavourite,
    };
    await db.add(data);
  }

  // Future<void> updateProducts(String id, Products updateProducts) async {
  //   CollectionReference db = FirebaseFirestore.instance.collection("products");
  //   Map<String, dynamic> data = {
  //     "category": updateProducts.category,
  //     "productName": updateProducts.productName,
  //     "id": updateProducts.id,
  //     "detail": updateProducts.detail,
  //     "price": updateProducts.price,
  //     "discountPrice": updateProducts.discountPrice,
  //     "serialCode": updateProducts.serialCode,
  //     "imageUrls": updateProducts.imageUrls,
  //     "isSale": updateProducts.isSale,
  //     "isPopular": updateProducts.isPopular,
  //     "isFavourite": updateProducts.isFavourite,
  //   };
  //   await db.doc(id).update(data);
  // }

  // Future<void> deleteProduct(String id) async {
  //   CollectionReference db = FirebaseFirestore.instance.collection("products");
  //   await db.doc(id).delete();
  // }
}
