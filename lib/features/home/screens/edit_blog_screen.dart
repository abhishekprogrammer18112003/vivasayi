import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/blog_provider.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';

class EditBlogScreen extends StatefulWidget {
  final List<dynamic>? images; // List of dynamic images (URLs or paths)
  final String blogTitle;
  final String blogContent;
  final String title;
  final String id;

  EditBlogScreen({
    Key? key,
    this.images,
    this.blogTitle = "",
    this.blogContent = "",
    required this.title,
    required this.id,
  }) : super(key: key);

  @override
  State<EditBlogScreen> createState() => _EditBlogScreenState();
}

class _EditBlogScreenState extends State<EditBlogScreen> {
  late List<dynamic>
      _images; // Use List<dynamic> to handle different image types
  late TextEditingController blogTitleController;
  late TextEditingController blogContentController;
  // List<XFile> img = [];
  @override
  void initState() {
    super.initState();

    _images = widget.images ?? [];
    blogTitleController = TextEditingController(text: widget.blogTitle);
    blogContentController = TextEditingController(text: widget.blogContent);
    // img = convertToXFileList(widget.images!);
  }

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      setState(() {
        _images.addAll(images); // Add XFile objects directly
      });
    }
  }

  void _deleteImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  List<XFile> convertToXFileList(List<dynamic> dynamicImages) {
    // Convert dynamic images to File objects
    List<File> files = dynamicImages.map((image) {
      if (image is String) {
        return File(image); // Convert file path string to File object
      }
      // Add additional handling if necessary (e.g., URL to File conversion)
      throw ArgumentError("Unsupported image type");
    }).toList();

    // Convert File objects to XFile objects
    return files.map((file) => XFile(file.path)).toList();
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
              "Edit Blog",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.w),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.cloud_upload, color: Colors.green),
                onPressed: () async {
                  if (blogContentController.text.isEmpty ||
                      blogTitleController.text.isEmpty ||
                      _images.isEmpty) {
                    OverlayManager.showToast(
                        type: ToastType.Alert,
                        msg: "Please enter all the fields to proceed");
                  } else {
                    // Convert XFile objects to paths
                    final imagePaths = _images.map((image) {
                      if (image is XFile) {
                        return image.path;
                      } else if (image is String) {
                        return image; // Already a path or URL
                      }
                      return '';
                    }).toList();

                    await value.updateBlog(
                        widget.images!,
                        widget.title,
                        blogTitleController.text,
                        blogContentController.text,
                        widget.id);
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
                  // Center(
                  //   child: GestureDetector(
                  //     onTap: _pickImages,
                  //     child: _images.isEmpty
                  //         ? Container(
                  //             height: 200.h,
                  //             width: 300.w,
                  //             color: Colors.grey[200],
                  //             child: Icon(Icons.camera_alt,
                  //                 size: 50, color: Colors.grey[700]),
                  //           )
                  //         : Stack(
                  //             children: [
                  //               CarouselSlider.builder(
                  //                 itemCount: _images.length,
                  //                 options: CarouselOptions(
                  //                   height: 200.h,
                  //                   enlargeCenterPage: true,
                  //                   enableInfiniteScroll: false,
                  //                   autoPlay: true,
                  //                   onPageChanged: (index, reason) {
                  //                     setState(() {});
                  //                   },
                  //                 ),
                  //                 itemBuilder: (context, index, realIndex) {
                  //                   final image = _images[index];
                  //                   return Stack(
                  //                     children: [
                  //                       Container(
                  //                         margin: EdgeInsets.all(5.0),
                  //                         decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(10.0),
                  //                           image: DecorationImage(
                  //                             image: image is XFile
                  //                                 ? FileImage(File(image.path))
                  //                                 : NetworkImage(image)
                  //                                     as ImageProvider,
                  //                             fit: BoxFit.cover,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       Positioned(
                  //                         top: 15.h,
                  //                         right: 20.w,
                  //                         child: GestureDetector(
                  //                           onTap: () => _deleteImage(index),
                  //                           child: Container(
                  //                             decoration: BoxDecoration(
                  //                               color:
                  //                                   Colors.red.withOpacity(0.7),
                  //                               shape: BoxShape.circle,
                  //                             ),
                  //                             child: Padding(
                  //                               padding:
                  //                                   const EdgeInsets.all(4.0),
                  //                               child: Icon(
                  //                                 Icons.delete,
                  //                                 color: Colors.white,
                  //                                 size: 18.w,
                  //                               ),
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ],
                  //                   );
                  //                 },
                  //               ),
                  //               Positioned(
                  //                 bottom: 15.h,
                  //                 child: IconButton(
                  //                   icon: Icon(Icons.add_a_photo,
                  //                       color: Colors.orange),
                  //                   onPressed: _pickImages,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //   ),
                  // ),

                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200.0,
                      autoPlay: true,
                      enlargeCenterPage: true,
                    ),
                    items: (widget.images as List<dynamic>)
                        .map<Widget>((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                            ),
                            child: Image.network(
                              imageUrl.toString(),
                              height: 30.h,
                              width: 200.w,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  CustomSpacers.height20,

                  // Blog Title Input
                  Text(
                    "Blog Title",
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.w600),
                  ),
                  CustomSpacers.height10,
                  TextField(
                    controller: blogTitleController,
                    maxLines: 1,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                  CustomSpacers.height20,

                  // Blog Content Input
                  Text(
                    "Description",
                    style:
                        TextStyle(fontSize: 18.w, fontWeight: FontWeight.w600),
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
          ),
        ),
      ),
    );
  }
}
