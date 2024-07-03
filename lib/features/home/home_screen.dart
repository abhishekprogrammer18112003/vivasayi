import 'package:carousel_slider/carousel_slider.dart';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/constants/app_data.dart';
// import 'package:vivasayi/core/helpers/scaffold_helpers.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical : 10),
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

  _buildTop()=>Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(AppIcons.appLogo , height: 60.h, width: 60.w,),
      IconButton(
              icon: Icon(Icons.add, size: 34.w),
              onPressed: () {
                // Add your onPressed action here
              },
            ),
    ],
  );

  // _listViewIcons() => SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         children: <Widget>[
  //           _coloredContainer('Modern \nAgri'),
  //           _coloredContainer('Natural \nAgri'),
  //           _coloredContainer('Agri \nMedicines'),
  //           _coloredContainer('Terrace \nGarden'),
  //           _coloredContainer('Articles'),
  //         ],
  //       ),
  //     );


  _listViewIcons()=>SizedBox(
    height: 100.h,

    child: ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: AppData.homeHeaderData.length,
      itemBuilder: (context , index) =>_coloredContainer(AppData.homeHeaderData[index])),
  );

  Widget _coloredContainer(String text) => Padding(
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
                style: TextStyle(fontSize: 10.w ,fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
  );

  Widget _carouselItems() => CarouselSlider(
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
          itemCount: 6,
          itemBuilder: (context, index) {
            return Card(
              elevation: 2.0,
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
                    bottom: 8.h,
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
}
