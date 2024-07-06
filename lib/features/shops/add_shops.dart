import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

class AddShopDetails extends StatefulWidget {
  const AddShopDetails({super.key});

  @override
  State<AddShopDetails> createState() => _AddShopDetailsState();
}

class _AddShopDetailsState extends State<AddShopDetails> {
  final List<String> machineries = [
    'Tractor',
    'Plow',
    'Harvester',
    'Sprayer',
    'Seeder',
  ];

  final Map<String, bool> selectedMachineries = {};
  XFile? _image;

  @override
  void initState() {
    super.initState();
    for (var machinery in machineries) {
      selectedMachineries[machinery] = false;
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Natural Agri',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload, color: Colors.green),
            onPressed: () {
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
                  : Image.file(File(_image!.path)),
            ),
            CustomSpacers.height20,

            // Product Name Input
            const TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Product Name',
              ),
            ),
            CustomSpacers.height20,
            Row(
              children: [
                const Expanded(
                  flex: 1,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Qty',
                    ),
                  ),
                ),
                CustomSpacers.width14,
                const Expanded(
                  flex: 1,
                  child: TextField(
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Qty Unit',
                    ),
                  ),
                ),
              ],
            ),
            CustomSpacers.height20,

            const TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Price',
              ),
            ),
            CustomSpacers.height20,

            // Description Input
            const TextField(
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
                'Select Product Categories',
                style: TextStyle(fontSize: 18.w, fontWeight: FontWeight.bold),
              ),
            ),
            CustomSpacers.height10,

            Column(
              children: machineries.map((machinery) {
                return CheckboxListTile(
                  title: Text(machinery),
                  value: selectedMachineries[machinery],
                  onChanged: (bool? value) {
                    setState(() {
                      selectedMachineries[machinery] = value ?? false;
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
