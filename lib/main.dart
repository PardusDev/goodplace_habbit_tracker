import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/init/start/application_start.dart';
import 'package:goodplace_habbit_tracker/pages/welcome/welcome_page.dart';
import 'package:provider/provider.dart';

import 'init/navigation/navigation_route.dart';
import 'init/navigation/navigation_service.dart';
import 'init/notifier/provider_list.dart';

void main() {
  ApplicationStart.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [... ProviderList.instance.dependItems],
      child: MaterialApp(
        title: StringConstants.appName,
        theme: ThemeData(
          splashFactory: NoSplash.splashFactory,
          highlightColor: ColorConstants.transparent,
          colorScheme: ColorScheme.fromSeed(
              seedColor: ColorConstants.primaryColor,
          ),
          useMaterial3: true,
        ),
        home: const WelcomePage(),
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        navigatorKey: NavigationService.instance.navigatorKey,
      ),
    );
  }
}
