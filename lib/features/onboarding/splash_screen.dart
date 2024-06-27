import 'dart:async';

import 'package:vivasayi/core/app_imports.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/login_signup/login_signup_page.dart';

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
    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginOrSignUp(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 151, 0, 1),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(75, 250, 0, 0),
        child: Image.asset(
          'assets/vivasayi_logo.png', // Ensure this image is in your assets folder and added in pubspec.yaml
          width: 250.w,
          height: 250.h,
        ),
      ),
    );
  }
}
