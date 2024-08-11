import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:vivasayi/core/constants/app_themes.dart';
import 'package:vivasayi/core/constants/value_constants.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/managers/app_manager.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/home/data/blog_provider.dart';
import 'package:vivasayi/features/home/data/home_provider.dart';
import 'package:vivasayi/features/home/screens/create_banner_screen.dart';
import 'package:vivasayi/features/nav_bar.dart';
import 'package:vivasayi/features/onboarding/data/onboarding_provider.dart';
import 'package:vivasayi/features/onboarding/screens/splash_screen.dart';
import 'package:vivasayi/features/home/screens/blogs_screen.dart';
import 'package:vivasayi/features/shops/data/shops_provider.dart';
import 'package:vivasayi/route/custom_navigator.dart';
late Position position;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppManager.initialize();
  position = await determinePosition();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => BlogProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ShopsProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
      ],
      child: ScreenUtilInit(
        designSize:
            const Size(VALUE_FIGMA_DESIGN_WIDTH, VALUE_FIGMA_DESIGN_HEIGHT),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vivasayi',
          initialRoute: '/',
          onGenerateRoute: CustomNavigator.controller,
          themeMode: ThemeMode.light,
          builder: OverlayManager.transitionBuilder(),
          theme: AppThemes.light,
          home: SplashScreen(),
        ),
      ),
    );
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, don't continue
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, don't continue
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can continue
  return await Geolocator.getCurrentPosition();
}
