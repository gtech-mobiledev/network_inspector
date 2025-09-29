import 'package:flutter/material.dart';
import 'package:optimus_network_inspector/optimus_network_inspector.dart';
import 'package:provider/provider.dart';

import 'common/navigation_service.dart';
import 'common/notification_helper.dart';
import 'presentation/controllers/main_provider.dart';
import 'presentation/pages/main_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NetworkInspector.initialize();
  NotificationHelper.initialize();
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainProvider>(
      create: (context) => MainProvider(context: context),
      builder: (context, child) => MaterialApp(
        title: 'Network inspector',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
            ),
          ),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Colors.black.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
        themeMode: ThemeMode.dark,
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: MainPage.routeName,
        routes: NavigationService.routes,
      ),
    );
  }
}
