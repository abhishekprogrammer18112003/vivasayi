import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/data/shops_provider.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';

class AddShopScreen extends StatefulWidget {
  String shopName;
  String shopCategory;

  AddShopScreen(
      {super.key, required this.shopName, required this.shopCategory});

  @override
  State<AddShopScreen> createState() => _AddShopScreenState();
}

class _AddShopScreenState extends State<AddShopScreen> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  // TextEditingController unitController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();



  final Map<String, bool> selectedMachineries = {};
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, value, child) => LoaderWidget(
        isLoading: value.isLoading,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: Text(
              widget.shopName,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.cloud_upload, color: Colors.green),
                onPressed: () async {
                  if (productNameController.text.isEmpty ||
                      qtyController.text.isEmpty ||
                      // unitController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      descriptionController.text.isEmpty ||
                      _image!.path.isEmpty) {
                    OverlayManager.showToast(
                        type: ToastType.Alert, msg: "Enter all the fields !");
                  } else {
                    await value.addProducts(
                        productNameController.text,
                        qtyController.text,
                        // unitController.text,
                        priceController.text,
                        descriptionController.text,
                        _image,
                        widget.shopCategory,
                        widget.shopName);
                  Navigator.pop(context);
                  }
                  // Handle upload action
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Image Picker
                GestureDetector(
                  onTap: _pickImage,
                  child: _image == null
                      ? Container(
                          height: 200.h,
                          width: 300.w,
                          color: Colors.grey[200],
                          child: Icon(Icons.camera_alt,
                              size: 50, color: Colors.grey[700]),
                        )
                      : Image.file(
                          File(_image!.path),
                        ),
                ),
                CustomSpacers.height20,

                // Product Name Input
                TextField(
                  controller: productNameController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Product Name',
                  ),
                ),
                CustomSpacers.height20,
                Row(
                  children: [
                    Expanded(
                      // flex: 1,
                      child: TextField(
                        controller: qtyController,
                        maxLines: 1,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Qty',
                        ),
                      ),
                    ),
                    CustomSpacers.width14,
                    // Expanded(
                    //   flex: 1,
                    //   child: TextField(
                    //     controller: unitController,
                    //     maxLines: 1,
                    //     decoration: InputDecoration(
                    //       border: OutlineInputBorder(),
                    //       labelText: 'Qty Unit',
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                CustomSpacers.height20,

                TextField(
                  controller: priceController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                  ),
                ),
                CustomSpacers.height20,

                // Description Input
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Description',
                  ),
                ),
                CustomSpacers.height20,

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Selected Product Categories',
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold),
                  ),
                ),
                CustomSpacers.height10,

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 10.r,
                        backgroundColor: Colors.red,
                        child: CircleAvatar(
                          radius: 8.r,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 6.r,
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      CustomSpacers.width16,
                      Text(
                        widget.shopCategory,
                        style: TextStyle(
                            fontSize: 18.w, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
