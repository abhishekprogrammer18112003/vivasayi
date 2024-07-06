import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/blogs_page.dart';

class BlogDetails extends StatefulWidget {
  final Blog blog;

  const BlogDetails({super.key, required this.blog});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  Widget build(BuildContext context) {
    final blog = widget.blog;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Custom arrow icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          CustomSpacers.width16,
          const Icon(
            Icons.edit_square,
            color: Color.fromARGB(255, 2, 167, 7),
          ),
          CustomSpacers.width16,
          const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          CustomSpacers.width12,
        ]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.blue,
              ),
            ),
            CustomSpacers.height20,
            Text(
              blog.title,
              style: TextStyle(
                fontSize: 24.w,
                fontWeight: FontWeight.bold,
              ),
            ),
            CustomSpacers.height20,
            Text(
              blog.content,
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
