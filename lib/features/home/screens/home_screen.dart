import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/constants/app_data.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/home_provider.dart';
import 'package:vivasayi/features/home/screens/create_banner_screen.dart';
import 'package:vivasayi/features/home/screens/create_blog_screen.dart';
import 'package:vivasayi/features/home/screens/blogs_screen.dart';
import 'package:vivasayi/features/shops/screens/create_shop_screen.dart';
import 'package:vivasayi/features/shops/screens/shop_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<HomeProvider>(context, listen: false).fetchBanner();
    });
  }

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

  _listViewIcons() => SizedBox(
        height: 100.h,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: AppData.homeHeaderData.length,
            itemBuilder: (context, index) =>
                _coloredContainer(index, AppData.homeHeaderData[index]['title'] , AppData.homeHeaderData[index]['image'])),
      );

  _coloredContainer(int index, String text , String img) => GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlogScreen(
                        title: AppData.homeHeader[index],
                      )));
        },
        child: Padding(
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
                  img,
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
        ),
      );

  _carouselItems() => Consumer<HomeProvider>(
        builder: (context, value, child) => CarouselSlider(
          options: CarouselOptions(height: 200.0, viewportFraction: 1),
          items: value.bannerList.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  height: 70.h,
                  width: 380.w,
                  decoration: BoxDecoration(
                  // color: Colors.black.withOpacity(0.1),
                    borderRadius:BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Image.network(i['image_url'] , fit: BoxFit.cover,)),
                  ),
                );
              },
            );
          }).toList(),
        ),
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
          itemCount: AppData.ShopCategory.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShopScreen(
                        shopCategory: AppData.ShopCategory[index]
                            ['shopCategory']),
                  ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppData.ShopCategory[index]
                            ['image_url']), // Background image
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
                        AppData.ShopCategory[index]['shopCategory'],
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CreateBlogScreen(title: category)));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: Text(
                            category,
                            style: TextStyle(
                                fontSize: 16.w, fontWeight: FontWeight.w400),
                          ),
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
                            builder: (context) => const CreateShopScreen()),
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
                            builder: (context) => EditImageScreen()),
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
