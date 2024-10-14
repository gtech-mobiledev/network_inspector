import 'package:flutter/material.dart';

import '../presentation/pages/http_page.dart';
import '../presentation/pages/main_page.dart';
import '../presentation/pages/vanilla_page.dart';

class NavigationService {
  static var navigatorKey = GlobalKey<NavigatorState>();

  static Map<String, Widget Function(BuildContext context)> get routes {
    return {
      MainPage.routeName: (context) => const MainPage(),
      HttpPage.routeName: (context) => const HttpPage(),
      VanillaPage.routeName: (context) => const VanillaPage(),
    };
  }
}
