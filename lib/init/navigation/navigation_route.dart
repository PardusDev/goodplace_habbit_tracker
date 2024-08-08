import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/login/login_page.dart';
import 'package:goodplace_habbit_tracker/widgets/NotFound.dart';

import '../../constants/navigator_constants.dart';
import '../../pages/register/register_page.dart';
import '../../pages/welcome/welcome_page.dart';

@immutable
class NavigationRoute {
  static const NavigationRoute _instance = const NavigationRoute._();
  static NavigationRoute get instance => _instance;

  const NavigationRoute._();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigatorConstants.WELCOME_PAGE:
        return nonAnimatedRoute(const WelcomePage());
      case NavigatorConstants.LOGIN_PAGE:
        return nonAnimatedRoute(const LoginPage());
      case NavigatorConstants.REGISTER_PAGE:
        return nonAnimatedRoute(const RegisterPage());
      case NavigatorConstants.NOT_FOUND:
        return nonAnimatedRoute(const NotFound());
      default:
        return nonAnimatedRoute(const NotFound());
    }
  }

  MaterialPageRoute nonAnimatedRoute(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
    );
  }
}