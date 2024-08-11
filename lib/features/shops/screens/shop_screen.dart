import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/blog_provider.dart';
import 'package:vivasayi/features/shops/data/shops_provider.dart';
import 'package:vivasayi/features/shops/screens/product_screen.dart';
import 'package:vivasayi/ui/atoms/loader_widget.dart';
import 'package:geocode/geocode.dart';

class ShopScreen extends StatefulWidget {
  String shopCategory;
  ShopScreen({super.key, required this.shopCategory});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<ShopsProvider>(context, listen: false)
          .fetchShops(widget.shopCategory);
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
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new), // Custom arrow icon
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Nearby Shop",
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined),
                    Text(
                      "Location",
                      style: TextStyle(
                          fontSize: 25.w, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: SingleChildScrollView(child: _shopsAvailable()),
        ),
      ),
    );
  }



  Widget _shopsAvailable() => Consumer<ShopsProvider>(
        builder: (context, value, child) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: value.shopList.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 4 / 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: value.shopList.length,
                  itemBuilder: (context, index) {
                  
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductScreen(
                              shop : value.shopList[index],
                                shopName: value.shopList[index]['shopName'],
                                shopCategory: widget.shopCategory),
                          ),
                        ).then((v) {});
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height: 200.h, // Adjust the height as needed
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        value.shopList[index]['image_url']),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Positioned(
                                bottom: 20.h,
                                left: 8.w,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.w),
                                  ),
                                  padding: EdgeInsets.all(8.w),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        value.shopList[index]['city'],
                                        style: TextStyle(
                                          fontSize: 16.w,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              blurRadius: 4.w,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                              offset: Offset(2.w, 2.w),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height:
                                  8.h), // Space between the image and the text
                          Text(
                            value.shopList[index]
                                ['shopName'], // Display the shop name
                            style: TextStyle(
                              fontSize: 22.w,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                )
              : Center(
                  child: Text("No shops found !"),
                ),
        ),
      );
}
