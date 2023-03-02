import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dashboard/widgets/custom_textbox.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/side_menu.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController idCtrl = TextEditingController();
  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController detailCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController discountPriceCtrl = TextEditingController();
  TextEditingController serialCodeCtrl = TextEditingController();
  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;

  String? selectedValue;
  final imagePicker = ImagePicker();
  List<XFile> images = [];
  List<String> imageUrls = [];
  bool isSaving = false;
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 5,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: Center(
                    child: Form(
                      child: Column(
                        children: <Widget>[
                          CustomTextbox(
                            textEditingController: productNameCtrl,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "It cannot be empty.";
                              }
                              return null;
                            },
                            labelData: "Product Name",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            textEditingController: detailCtrl,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "It cannot be empty.";
                              }
                              return null;
                            },
                            labelData: "Product Detail",
                            maxLines: 7,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            textEditingController: priceCtrl,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "It cannot be empty.";
                              }
                              return null;
                            },
                            labelData: "Product Price",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            textEditingController: discountPriceCtrl,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "It cannot be empty.";
                              }
                              return null;
                            },
                            labelData: "Discount Price",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            textEditingController: serialCodeCtrl,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "It cannot be empty.";
                              }
                              return null;
                            },
                            labelData: "Product Serial Code",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: lightGrey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonFormField(
                                hint: const Text(
                                  'Choose Category',
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null) {
                                    return "Category cannot be empty.";
                                  }
                                  return null;
                                },
                                value: selectedValue,
                                items: categories
                                    .map((e) => DropdownMenuItem<String>(
                                        value: e, child: Text(e)))
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value.toString();
                                  });
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            title: "Select Images",
                            onPress: () {
                              pickImage();
                            },
                            isLoginButton: true,
                          ),
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                              ),
                              itemCount: images.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black,
                                        ),
                                      ),
                                      child: Image.network(
                                        File(images[index].path).path,
                                        height: 200,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          images.removeAt(index);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.cancel_outlined,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          CustomButton(
                            title: "Save",
                            isLoginButton: true,
                            onPress: () {
                              save();
                            },
                            isLoading: isSaving,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  save() async {
    setState(() {
      isSaving = true;
    });
    await uploadImages();
    await FirebaseFirestore.instance
        .collection("products")
        .add({"images": imageUrls}).whenComplete(() {
      setState(() {
        isSaving = false;
        images.clear();
        imageUrls.clear();
      });
    });
  }

// issues

  pickImage() async {
    final List<XFile>? pickImage = await imagePicker.pickMultiImage();
    if (pickImage != null) {
      setState(() {
        images.addAll(pickImage);
      });
    } else {
      print("no images selected");
    }
  }

  Future postImages(XFile? imageFile) async {
    setState(() {
      isUploading = true;
    });
    String urls;
    Reference ref =
        FirebaseStorage.instance.ref().child("images").child(imageFile!.path);
    if (kIsWeb) {
      await ref.putData(
        await imageFile.readAsBytes(),
        SettableMetadata(contentType: "image/jpeg"),
      );
      urls = await ref.getDownloadURL();
      setState(() {
        isUploading = false;
      });
      return urls;
    }
  }

  uploadImages() async {
    for (var image in images) {
      await postImages(image).then((downLoadUrl) => imageUrls.add(downLoadUrl));
    }
  }
}
