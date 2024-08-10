import 'package:goodplace_habbit_tracker/pages/login/login_page_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/register/register_page_view_model.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../pages/splash/splash_page_view_model.dart';

class ProviderList {
  // Can't create an instance of this class. Use it directly.
  static final ProviderList _instance = ProviderList._();
  static ProviderList get instance => _instance;

  ProviderList._();

  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (_) => SplashPageViewModel()),
    ChangeNotifierProvider(create: (_) => LoginPageViewModel()),
    ChangeNotifierProvider(create: (_) => RegisterPageViewModel()),
    ChangeNotifierProvider(create: (_) => HomePageViewModel()),
  ];
}