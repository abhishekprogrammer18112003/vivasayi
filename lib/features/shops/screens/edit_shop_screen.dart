import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:osm_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/constants/app_data.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/data/shops_provider.dart';
import 'package:vivasayi/features/shops/screens/map_screen.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';
import 'package:vivasayi/ui/molecules/custom_button.dart';
// import 'package:osm_search_and_pick/osm_map_search_and_pick.dart';

class EditShopScreen extends StatefulWidget {
  dynamic shop;
  EditShopScreen({super.key, required this.shop});

  @override
  State<EditShopScreen> createState() => _EditShopScreenState();
}

class _EditShopScreenState extends State<EditShopScreen> {
  TextEditingController shopController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  List<dynamic> selectedCategories = [];
  String? _image;
  @override
  void initState() {
    super.initState();
    shopController.text = widget.shop['shopName'];
    phoneController.text = widget.shop['phone'];
    whatsappController.text = widget.shop['whatsapp'];
    locationController.text = widget.shop['address'];
    selectedCategories = widget.shop['shopCategory'];
    _image = widget.shop['image_url'];
  }

  // Future<void> _pickImage(ImageSource source) async {
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: source);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = XFile(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopsProvider>(
      builder: (context, value, child) => LoaderWidget(
        isLoading: value.isLoading,
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSpacers.height10,
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_outlined),
                  ),
                  // Profile Photo with Edit Icon
                  CustomSpacers.height20,
                  _buildProfile(),
                  CustomSpacers.height40,
                  _buildForm(),
                  // Select Shop Category
                  CustomSpacers.height26,
                  _buildShopCategory(),
                  CustomSpacers.height26,
                  CustomButton(
                    strButtonText: 'Submit',
                    buttonAction: () async {
                      if (shopController.text.isEmpty ||
                          phoneController.text.isEmpty ||
                          whatsappController.text.isEmpty ||
                          // _image!.path.isEmpty ||
                          selectedCategories.isEmpty ||
                          locationController.text.isEmpty) {
                        OverlayManager.showToast(
                            type: ToastType.Alert,
                            msg: "Please enter the required fields");
                      } else {
                        await value.updateShop(
                            _image!,
                            shopController.text,
                            phoneController.text,
                            whatsappController.text,
                            selectedCategories,
                            data,
                            widget.shop['latitude'],
                            widget.shop['longitude'] , widget.shop['id'] , widget.shop['address']);

                        Navigator.pop(context);
                      }

                      print(selectedCategories);
                    },
                    dHeight: 69.h,
                    dWidth: 369.w,
                    bgColor: Colors.green,
                    dCornerRadius: 12.w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfile() => Center(
        child: Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: _image != null
                  ? NetworkImage(_image!)
                  : AssetImage('assets/nuts.png') as ImageProvider,
            ),
            // Positioned(
            //   top: 70.h,
            //   left: 70.w,
            //   child: GestureDetector(
            //     onTap: () => _showImageSourceActionSheet(),
            //     child: Container(
            //       height: 40.h,
            //       width: 40.w,
            //       decoration: const BoxDecoration(
            //         color: Color.fromARGB(255, 255, 153, 0),
            //         shape: BoxShape.circle,
            //       ),
            //       child: Center(
            //         child: Icon(
            //           Icons.edit,
            //           color: Colors.white,
            //           size: 27.w,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  // void _showImageSourceActionSheet() {
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //         child: Wrap(
  //           children: [
  //             ListTile(
  //               leading: Icon(Icons.photo_library),
  //               title: Text('Photo Library'),
  //               onTap: () {
  //                 _pickImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: Icon(Icons.photo_camera),
  //               title: Text('Camera'),
  //               onTap: () {
  //                 _pickImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  dynamic data;
  GeoPoint? selectedLocation;
  Widget _buildForm() => Column(
        children: [
          TextField(
            controller: shopController,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Shop Name',
            ),
          ),
          CustomSpacers.height26,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "+91(IN)",
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              CustomSpacers.width16,
              Expanded(
                flex: 3,
                child: TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          CustomSpacers.height26,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "+91(IN)",
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.w400),
                  )
                ],
              ),
              CustomSpacers.width16,
              Expanded(
                flex: 3,
                child: TextField(
                  controller: whatsappController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Whatsapp Number',
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
            ],
          ),
          CustomSpacers.height26,
          TextField(
            readOnly: true,
            controller: locationController,
            maxLines: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Enter Address',
            ),
            onTap: () async {
              final pickedData = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyWidget()),
              );

              if (pickedData != null) {
                setState(() {
                  //   latitude = pickedData.latLong.latitude;
                  //   longitude = pickedData.latLong.longitude;
                  locationController.text = pickedData.address;
                  data = pickedData;
                });
              }
            },
          ),
        ],
      );

  Widget _buildShopCategory() => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Select Shop Category',
              style: TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold),
            ),
          ),
          CustomSpacers.height10,
          Column(
            children: AppData.ShopCategory.map((category) {
              return CheckboxListTile(
                title: Text(category['shopCategory']),
                value: selectedCategories.contains(category['shopCategory']),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedCategories.add(category['shopCategory']);
                    } else {
                      selectedCategories.remove(category['shopCategory']);
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      );
}
