import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
// import 'package:universal_io/io.dart';

class StorageService {
  final productsFolder = FirebaseStorage.instance.ref().child('products');

  Future<String> uploadProductsImages(
    String productId,
    Uint8List image,
    String fileName,
  ) async {
    SettableMetadata metadata = SettableMetadata(contentType: 'image/jpeg');
    final uniqueFolder = productsFolder.child(productId);
    final ref = uniqueFolder.child(fileName);
    final uploadTask = ref.putData(image, metadata);
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

  Future<Uint8List?> downloadFile(String productId) async {
    final uniqueFolder = productsFolder.child(productId);
    final ref = uniqueFolder.child('0');

    Uint8List? imageFile = await ref.getData();

    return imageFile;
  }
}
