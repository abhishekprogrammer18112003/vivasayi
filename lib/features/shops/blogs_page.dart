import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/blog_details.dart';

class Blog {
  final String title;
  final String content;
  final String imageUrl;

  Blog({required this.title, required this.content, required this.imageUrl});
}

class MyBlogsPage extends StatefulWidget {
  const MyBlogsPage({super.key});

  @override
  State<MyBlogsPage> createState() => _MyBlogsPageState();
}

class _MyBlogsPageState extends State<MyBlogsPage> {
  final List<Blog> blogs = [
    Blog(
      title: 'Blog Title 1',
      content:
          'Lorem ipsum dol elit non enim. Ut fermentum sollicitudin dui ac tristique mauris penon enim. Ut fermentum sollicitudin dui ac tristique mauris penon enim. Ut fermentum sollicitudin dui ac tristique mauris pellentesque et',
      imageUrl: 'assets/peas.png',
    ),
    Blog(
      title: 'Blog Title 2',
      content:
          'Lorem ipsum dolor sit amet enim Ut fermentum sollicitudinsit amet enim Ut fermentum sollicitudinsit amet enim Ut fermentum sollicitudin dui ac tristique mauris pellentesque et',
      imageUrl: 'assets/nuts.png',
    ),
    // Add more blogs here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new), // Custom arrow icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Natural Agri',
          style: TextStyle(fontWeight: FontWeight.w400),
        ),
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          final blog = blogs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlogDetails(blog: blog),
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          blog.imageUrl,
                          width: 120.w,
                          height: 120.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      CustomSpacers.width20,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              blog.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomSpacers.width6,
                            Text(
                              blog.content,
                              style: TextStyle(
                                fontSize: 16.w,
                                color: Colors.grey,
                              ),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  CustomSpacers.height14,
                  Divider(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    thickness: 1.h,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
