import 'dart:async';
import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/managers/shared_preference_manager.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/nav_bar.dart';
import 'package:vivasayi/features/onboarding/screens/signup.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    bool isLogin = SharedPreferencesManager.getBool("isLogin");
    Timer(const Duration(seconds: 2), () async {
      if (isLogin) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NavBarScreen(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignUpScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 151, 0, 1),
      body: Center(
        child: Image.asset(
          AppIcons
              .appLogo, // Ensure this image is in your assets folder and added in pubspec.yaml
          width: 250.w,
          height: 250.h,
        ),
      ),
    );
  }
}
