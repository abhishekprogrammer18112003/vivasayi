



import 'package:vivasayi/features/onboarding/splash_screen.dart';

import '../core/app_imports.dart';
import 'app_pages.dart';

final kNavigatorKey = GlobalKey<NavigatorState>();

class CustomNavigator {
  static Route<dynamic> controller(RouteSettings settings) {
    //use settings.arguments to pass arguments in pages
    switch (settings.name) {
      case AppPages.appEntry:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );


      
      // case AppPages.orders:
      //   return MaterialPageRoute(
      //     builder: (context) => OrdersScreen(
      //       arguments: settings.arguments as Map<String, dynamic>,
      //       ticketId: settings.arguments as int,
      //     ),
      //     settings: settings,
      //   );
      

      default:
        throw ('This route name does not exit');
    }
  }

  // Pushes to the route specified
  static Future<T?> pushTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.of(context, rootNavigator: true)
        .pushNamed(strPageName, arguments: arguments);
  }

  // Pop the top view
  static void pop(BuildContext context, {Object? result}) {
    Navigator.pop(context, result);
  }

  // Pops to a particular view
  static Future<T?> popTo<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.popAndPushNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }

  static void popUntilFirst(BuildContext context) {
    Navigator.popUntil(context, (page) => page.isFirst);
  }

  static void popUntilRoute(BuildContext context, String route, {var result}) {
    Navigator.popUntil(context, (page) {
      if (page.settings.name == route && page.settings.arguments != null) {
        (page.settings.arguments as Map<String, dynamic>)["result"] = result;
        return true;
      }
      return false;
    });
  }

  static Future<T?> pushReplace<T extends Object?>(
    BuildContext context,
    String strPageName, {
    Object? arguments,
  }) async {
    return await Navigator.pushReplacementNamed(
      context,
      strPageName,
      arguments: arguments,
    );
  }
}
