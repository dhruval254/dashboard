import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../constants.dart';

import '../services/database_service.dart';

import '../widgets/custom_textbox.dart';
import '../widgets/custom_button.dart';
import '../widgets/side_menu.dart';

class ProductEditorScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const ProductEditorScreen({super.key});

  @override
  State<ProductEditorScreen> createState() => _AddProductState();
}

class _AddProductState extends State<ProductEditorScreen> {
  final _formKey = GlobalKey<FormState>();
  String productName = '';
  String productDetail = '';
  int productStock = 0;
  int productPrice = 0;
  int productDiscount = 0;
  String productCategory = '';
  bool isOnSale = false;
  bool isPopular = false;
  List<Uint8List> productImageList = [];

  bool isSaving = false;
  bool isUploading = false;

  Future selectImage() async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();
    // XFile? xFile;
    // File? image;
    Uint8List? imageBytes;

    // xFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (fileResult != null) {
      imageBytes = fileResult.files.first.bytes;

      if (imageBytes != null) {
        setState(() {
          productImageList.add(imageBytes!);
        });
      }
    }

    // if (image != null) {
    //   setState(() {
    //     productImageList.add(image!);
    //   });
    // }
  }

  Future postProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        isSaving = true;
      });

      if (productImageList.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload atleast one image'),
          ),
        );

        setState(() {
          isSaving = false;
        });

        return;
      }

      await DatabaseService().addProduct(
        productName,
        productCategory,
        productDetail,
        productStock,
        productPrice,
        productDiscount,
        productImageList,
        isPopular,
        isOnSale,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Upload Complete,'),
          ),
        );

        Navigator.of(context).pop();
      }

      setState(() {
        isSaving = false;
      });
    }
  }

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
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          CustomTextbox(
                            labelData: "Product Name",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "It cannot be empty.";
                              }

                              return null;
                            },
                            onSave: (v) {
                              productName = v!;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 250,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: lightGrey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SingleChildScrollView(
                              child: TextFormField(
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                                cursorColor: grey,
                                decoration: const InputDecoration(
                                  label: Text('Product Description'),
                                  labelStyle: TextStyle(
                                    color: lightGrey,
                                  ),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length < 20) {
                                    return 'Please tell us something about your pet';
                                  }

                                  return null;
                                },
                                onSaved: (value) {
                                  productDetail = value!;
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            textInputType: TextInputType.number,
                            labelData: "Product Stock",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Stock cannot be empty.";
                              }

                              if (v.contains(RegExp(r'[a-z A-Z]'))) {
                                return 'Alphabets are not allowed';
                              }
                              return null;
                            },
                            onSave: (v) {
                              productStock = int.parse(v!);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            textInputType: TextInputType.number,
                            labelData: "Product Price",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "It cannot be empty.";
                              }

                              if (v.contains(RegExp(r'[a-z A-Z]'))) {
                                return 'Alphabets are not allowed';
                              }
                              return null;
                            },
                            onSave: (v) {
                              productPrice = int.parse(v!);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextbox(
                            labelData: "Discount Price",
                            textInputType: TextInputType.number,
                            validator: (v) {
                              if (v != null) {
                                if (v.contains(RegExp(r'[a-z A-Z]'))) {
                                  return 'Alphabets are not allowed';
                                }

                                if (int.parse(v) < 1 || int.parse(v) > 100) {
                                  return 'Discount should be between 1% to 100%';
                                }
                              }
                              return null;
                            },
                            onSave: (v) {
                              productDiscount = int.parse(v!);
                            },
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
                                hint: Container(
                                  margin: const EdgeInsets.only(left: 40),
                                  child: const Text(
                                    'Select type',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w100,
                                    ),
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(20),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                items: const [
                                  DropdownMenuItem(
                                    value: 'dog',
                                    child: Text('Dog'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'cat',
                                    child: Text('Cat'),
                                  ),
                                ],
                                validator: (value) {
                                  if (value == null) {
                                    return 'Please choose your pet type';
                                  }

                                  return null;
                                },
                                onChanged: (value) {
                                  productCategory = value!;
                                },
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            title: "Select Images",
                            onPress: selectImage,
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
                              itemCount: productImageList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.transparent,
                                          ),
                                        ),
                                        child: Image.memory(
                                          productImageList[index],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          productImageList.removeAt(index);
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.cancel_outlined,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                          SwitchListTile(
                              title: const Text("Is this on Sale ?"),
                              value: isOnSale,
                              onChanged: (v) {
                                setState(() {
                                  isOnSale = !isOnSale;
                                });
                              }),
                          SwitchListTile(
                              title: const Text("Is this Popular ?"),
                              value: isPopular,
                              onChanged: (v) {
                                setState(() {
                                  isPopular = !isPopular;
                                });
                              }),
                          CustomButton(
                            title: "Save",
                            isLoginButton: true,
                            onPress: postProduct,
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
}
