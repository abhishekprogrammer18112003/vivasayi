import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/blog_provider.dart';
import 'package:vivasayi/features/home/screens/edit_blog_screen.dart';

class BlogDetails extends StatefulWidget {
  final dynamic blogData;
  final String title;

  const BlogDetails({super.key, required this.blogData , required this.title});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
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
    final blog = widget.blogData;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomSpacers.width16,
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditBlogScreen(
                      title : widget.title,
                      id: blog['id'],
                      images: 
                          blog['image_url'], // Convert and pass images
                      blogContent: blog['description'],
                      blogTitle: blog['title'],
                    ),
                  ),
                );
              },
              child: const Icon(
                Icons.edit_square,
                color: Color.fromARGB(255, 2, 167, 7),
              ),
            ),
            CustomSpacers.width16,
            InkWell(
              onTap: () async{
                final p = Provider.of<BlogProvider>(context , listen: false);
                await p.deleteBlog( widget.title , blog['id'] );
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            CustomSpacers.width12,
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items:
                  (blog['image_url'] as List<dynamic>).map<Widget>((imageUrl) {
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
            Text(
              blog['title'],
              style: TextStyle(
                fontSize: 24.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomSpacers.height20,
            Text(
              blog['description'],
              style: TextStyle(
                fontSize: 18.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
