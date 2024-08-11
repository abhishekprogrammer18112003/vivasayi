import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/blog_provider.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';

class CreateBlogScreen extends StatefulWidget {
  final String title;

  CreateBlogScreen({super.key, required this.title});

  @override
  State<CreateBlogScreen> createState() => _CreateBlogScreenState();
}

class _CreateBlogScreenState extends State<CreateBlogScreen> {
  List<XFile> _images = [];
  TextEditingController blogTitleController = TextEditingController();
  TextEditingController blogContentController = TextEditingController();

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _images.addAll(images);
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BlogProvider>(
      builder: (context, value, child) => LoaderWidget(
        isLoading: value.isLoading,
        child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              title: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.w),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.cloud_upload, color: Colors.green),
                  onPressed: () async {
                    // Handle upload action
                    if (blogContentController.text.isEmpty ||
                        blogTitleController.text.isEmpty || _images.isEmpty) {
                      OverlayManager.showToast(
                          type: ToastType.Alert,
                          msg:
                              "Please enter all the fields to proceed");
                    } else {
                      await value.createBlog(_images, widget.title,
                          blogTitleController.text, blogContentController.text);

                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Picker
                    Center(
                      child: GestureDetector(
                        onTap: _pickImages,
                        child: _images.isEmpty
                            ? Container(
                                height: 200.h,
                                width: 300.w,
                                color: Colors.grey[200],
                                child: Icon(Icons.camera_alt,
                                    size: 50, color: Colors.grey[700]),
                              )
                            : Stack(
                                children: [
                                  CarouselSlider.builder(
                                    itemCount: _images.length,
                                    options: CarouselOptions(
                                      height: 200.h,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      autoPlay: true,
                                      // autoPlayInterval: Duration(seconds: 3),
                                      onPageChanged: (index, reason) {
                                        setState(() {});
                                      },
                                    ),
                                    itemBuilder: (context, index, realIndex) {
                                      return Stack(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.all(5.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              image: DecorationImage(
                                                image: FileImage(
                                                    File(_images[index].path)),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 15.h,
                                            right: 20.w,
                                            child: GestureDetector(
                                              onTap: () => _deleteImage(index),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red
                                                      .withOpacity(0.7),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Icon(
                                                    Icons.delete,
                                                    color: Colors.white,
                                                    size: 18.w,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 15.h,
                                    // right: 3.w,
                                    child: IconButton(
                                      icon: Icon(Icons.add_a_photo,
                                          color: Colors.orange),
                                      onPressed: _pickImages,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                    CustomSpacers.height20,

                    // Product Name Input
                    Text(
                      "Blog Title",
                      style: TextStyle(
                          fontSize: 18.w, fontWeight: FontWeight.w600),
                    ),
                    CustomSpacers.height10,
                    TextField(
                      controller: blogTitleController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: 'Blog Title',
                      ),
                    ),
                    CustomSpacers.height20,

                    // Description Input
                    Text(
                      "Description",
                      style: TextStyle(
                          fontSize: 18.w, fontWeight: FontWeight.w600),
                    ),
                    CustomSpacers.height10,
                    TextField(
                      controller: blogContentController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                    CustomSpacers.height20,
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
