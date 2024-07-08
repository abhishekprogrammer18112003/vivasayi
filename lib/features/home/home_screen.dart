import 'package:carousel_slider/carousel_slider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/constants/app_data.dart';
<<<<<<< HEAD
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/blogs_page.dart';
import 'package:vivasayi/features/shops/create_shop_screen.dart';
import 'package:vivasayi/features/shops/nearby_shops.dart';
=======

import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/shops/shop_screen.dart';
>>>>>>> 0f64b14540f5c3ba5516e3d64a8c5d326192690f

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSpacers.height38,
              _buildTop(),
              CustomSpacers.height20,
              _listViewIcons(),
              CustomSpacers.height20,
              _carouselItems(),
              CustomSpacers.height20,
              Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Shops',
                  style: TextStyle(fontSize: 25.w, fontWeight: FontWeight.w500),
                ),
              ),
              _shopsAvailable(),
            ],
          ),
        ),
      ),
    );
  }

<<<<<<< HEAD
  _buildTop() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppIcons.appLogo,
            height: 60.h,
            width: 60.w,
          ),
          IconButton(
            icon: Icon(Icons.add, size: 34.w),
            onPressed: () {
              _showCustomDialog(context);
            },
          ),
        ],
      );
=======
  _buildTop()=>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(AppIcons.appLogo , height: 50.h, width: 50.w,),
      IconButton(
              icon: Icon(Icons.add, size: 34.w),
              onPressed: () {
                // Add your onPressed action here
              },
            ),
    ],
  );
>>>>>>> 0f64b14540f5c3ba5516e3d64a8c5d326192690f

  _listViewIcons() => SizedBox(
        height: 100.h,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: AppData.homeHeaderData.length,
            itemBuilder: (context, index) =>
                _coloredContainer(AppData.homeHeaderData[index])),
      );

  _coloredContainer(String text) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 224, 250, 216),
            borderRadius: BorderRadius.circular(12), // 12px border radius
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppIcons.drone,
                height: 38.h,
                width: 40.w,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 10.w, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );

  _carouselItems() => CarouselSlider(
        options: CarouselOptions(height: 200.0, viewportFraction: 1),
        items: [1, 2, 3, 4, 5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 231, 255, 226),
                      borderRadius: BorderRadius.circular(20.w),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10.w, 20.h, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Free Consultation',
                                style: TextStyle(
                                  fontSize: 25.w,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromARGB(255, 29, 193, 0),
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Get free support from \nour customer services',
                                style: TextStyle(
                                  fontSize: 20.w,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Image.asset(
                            'assets/image copy.png', // Adjusted path
                            height: 150.h,
                            width: 140.w,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }).toList(),
      );

  _shopsAvailable() => Padding(
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
          itemCount: 6,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopScreen(),
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
                      child: Text(
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
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );

  _showCustomDialog(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Section: Displaying Categories

                  CustomSpacers.height28,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: AppData.homeHeader.map((category) {
                      return Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Text(
                          category,
                          style: TextStyle(
                              fontSize: 16.w, fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                  ),
                  CustomSpacers.height10,

                  Divider(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    thickness: 1.h,
                  ),
                  CustomSpacers.height10,

                  GestureDetector(
                    onTap: () {
                      // Handle Create Shop action
                      Navigator.of(context).pop(); // Close the dialog
                      // Navigate to ShopScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ShopScreen()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: const Text(
                        'Create Shop',
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      // Handle Create Shop action
                      // Navigate to ShopScreen
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyBlogsPage()),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: const Text(
                        'Create Home Banner',
                      ),
                    ),
                  ),
                  CustomSpacers.height28,
                ],
              ),
            ),
          );
        },
      );
}
