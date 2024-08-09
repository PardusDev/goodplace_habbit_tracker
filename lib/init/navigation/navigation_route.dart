import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/login/login_page.dart';
import 'package:goodplace_habbit_tracker/widgets/NotFound.dart';

import '../../animations/right_transition.dart';
import '../../constants/navigator_constants.dart';
import '../../pages/register/register_page.dart';
import '../../pages/welcome/welcome_page.dart';

@immutable
class NavigationRoute {
  static const NavigationRoute _instance = NavigationRoute._();
  static NavigationRoute get instance => _instance;

  const NavigationRoute._();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigatorConstants.WELCOME_PAGE:
        return slideAnimatedRoute(const WelcomePage());
      case NavigatorConstants.LOGIN_PAGE:
        return slideAnimatedRoute(const LoginPage());
      case NavigatorConstants.REGISTER_PAGE:
        return slideAnimatedRoute(const RegisterPage());
      case NavigatorConstants.NOT_FOUND:
        return slideAnimatedRoute(const NotFound());
      default:
        return slideAnimatedRoute(const NotFound());
    }
  }

  MaterialPageRoute nonAnimatedRoute(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: widget.toString()),
    );
  }

  PageRouteBuilder slideAnimatedRoute(Widget widget) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondayAnimation) => widget,
        settings: RouteSettings(name: widget.toString()),
        transitionsBuilder: RightTransition
    );
  }
}