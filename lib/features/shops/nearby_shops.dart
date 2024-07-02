import 'package:flutter/material.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/shop_details.dart';

class NearbyShop extends StatefulWidget {
  const NearbyShop({super.key});

  @override
  State<NearbyShop> createState() => _NearbyShopState();
}

class _NearbyShopState extends State<NearbyShop> {
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
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(child: _shopsAvailable()),
    );
  }

  Widget _shopsAvailable() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4 / 5,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopDetails(),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image:
                            AssetImage('assets/nuts.png'), // Background image
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
                            'Seeds',
                            style: TextStyle(
                              fontSize: 16.w,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 4.w,
                                  color: Colors.black.withOpacity(0.5),
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
            );
          },
        ),
      );
}
