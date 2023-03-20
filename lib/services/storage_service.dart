import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final productsFolder = FirebaseStorage.instance.ref().child('products');

  Future<String> uploadProductsImages(
    String productId,
    File image,
    String fileName,
  ) async {
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    final uniqueFolder = productsFolder.child(productId);
    final ref = uniqueFolder.child(fileName);
    final uploadTask = ref.putFile(image, metadata);
    String imageUrl = '';

    final taskSnapshot = await uploadTask.whenComplete(() => null);

    imageUrl = await taskSnapshot.ref.getDownloadURL();

    return imageUrl;
  }

  Future removeProductsImages(String productsId) async {
    await FirebaseStorage.instance
        .ref('products/$productsId')
        .listAll()
        .then((value) {
      for (var element in value.items) {
        FirebaseStorage.instance.ref(element.fullPath).delete();
      }
    });
  }
}
