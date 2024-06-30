import 'package:flutter/material.dart';
import 'package:vivasayi/core/constants/app_themes.dart';
import 'package:vivasayi/core/constants/value_constants.dart';
import 'package:vivasayi/core/loaded_widget.dart';
import 'package:vivasayi/core/utils/screen_utils.dart';
import 'package:vivasayi/features/nav_bar.dart';
import 'package:vivasayi/route/custom_navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
        home: const NavBarScreen(),
      ),
    );
  }
}
