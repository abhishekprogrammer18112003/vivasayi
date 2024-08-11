import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/utils/custom_spacers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/blog_provider.dart';
import 'package:vivasayi/features/home/screens/blog_details.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';

class BlogScreen extends StatefulWidget {
  String title;
  BlogScreen({super.key, required this.title});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<BlogProvider>(context, listen: false).getBlogList(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: ()async{
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<BlogProvider>(context, listen: false).getBlogList(widget.title);
    });
      },
      child: Consumer<BlogProvider>(
        builder: (context, value, child) => LoaderWidget(
          isLoading: value.isLoadingBlog,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: false,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new), // Custom arrow icon
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                widget.title,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
            body: value.blogList.isNotEmpty ? Padding(
              padding: const EdgeInsets.only(top : 14.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: value.blogList.length,
                itemBuilder: (context, index) {
                  final blog = value.blogList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlogDetails(blogData: blog , title : widget.title),
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
                                child: Image.network(
                                  blog['image_url'][0],
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
                                      blog['title'],
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    CustomSpacers.height6,
                                    Text(
                                      blog['description'],
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
                            color: Colors.black.withOpacity(0.2),
                            thickness: 1.h,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ) : Center(child: Text("No blogs under this category !"),),
          ),
        ),
      ),
    );
  }
}
