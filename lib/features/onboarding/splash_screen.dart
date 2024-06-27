import 'dart:async';

import 'package:vivasayi/core/app_imports.dart';

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
    Timer(Duration(milliseconds: 800), () async {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(child: Icon(Icons.h_mobiledata)),
    );
  }
}
