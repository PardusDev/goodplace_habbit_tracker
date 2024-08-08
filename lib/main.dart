import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/pages/login/login_page.dart';
import 'package:goodplace_habbit_tracker/route_generator.dart';
import 'package:goodplace_habbit_tracker/viewmodels/main_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainViewModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoodPlace',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.rotaOlustur,
     home: const LoginPage(),
    );
  }
}

