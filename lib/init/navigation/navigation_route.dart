import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/error_pages/no_network/no_network_page.dart';
import 'package:goodplace_habbit_tracker/pages/habit_detail/habit_detail.dart';
import 'package:goodplace_habbit_tracker/pages/home/home_page.dart';
import 'package:goodplace_habbit_tracker/pages/login/login_page.dart';
import 'package:goodplace_habbit_tracker/pages/manage_my_habits/manage_my_habits_page.dart';
import 'package:goodplace_habbit_tracker/pages/onboarding/onboarding_page.dart';
import 'package:goodplace_habbit_tracker/pages/error_pages/not_found/not_found_page.dart';

import '../../animations/right_transition.dart';
import '../../constants/navigator_constants.dart';
import '../../pages/register/register_page.dart';
import '../../pages/settings/settings_page.dart';
import '../../pages/welcome/welcome_page.dart';

@immutable
class NavigationRoute {
  static const NavigationRoute _instance = NavigationRoute._();
  static NavigationRoute get instance => _instance;

  const NavigationRoute._();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigatorConstants.SPLASH_PAGE:
        return slideAnimatedRoute(const WelcomePage(), args.arguments);
      case NavigatorConstants.WELCOME_PAGE:
        return slideAnimatedRoute(const WelcomePage(), args.arguments);
      case NavigatorConstants.LOGIN_PAGE:
        return slideAnimatedRoute(const LoginPage(), args.arguments);
      case NavigatorConstants.REGISTER_PAGE:
        return slideAnimatedRoute(const RegisterPage(), args.arguments);
      case NavigatorConstants.ONBOARDING_PAGE:
        return slideAnimatedRoute(const OnBoardingPage(), args.arguments);
      case NavigatorConstants.HOME_PAGE:
        return slideAnimatedRoute(const HomePage(), args.arguments);
      case NavigatorConstants.SETTINGS_PAGE:
        return slideAnimatedRoute(const SettingsPage(), args.arguments);
      case NavigatorConstants.MANAGEMYHABITS_PAGE:
        return slideAnimatedRoute(const ManageMyHabitsPage(), args.arguments);
      case NavigatorConstants.HABITDETAIL_PAGE:
        return slideAnimatedRoute(const HabitDetailPage(), args.arguments);
      case NavigatorConstants.NOT_FOUND:
        return slideAnimatedRoute(const NotFound(), args.arguments);
      case NavigatorConstants.NO_NETWORK:
        return slideAnimatedRoute(const NoNetworkPage(), args.arguments);
      default:
        return slideAnimatedRoute(const NotFound(), args.arguments);
    }
  }

  MaterialPageRoute nonAnimatedRoute(Widget widget) {
    return MaterialPageRoute(
      builder: (context) => widget,
      settings: RouteSettings(name: widget.toString()),
    );
  }

  PageRouteBuilder slideAnimatedRoute(Widget widget, Object? args) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondayAnimation) => widget,
        settings: RouteSettings(name: widget.toString(), arguments: args),
        transitionsBuilder: RightTransition
    );
  }
}