import 'package:flutter/material.dart';

@immutable
class NavigatorConstants {
  // Can't create an instance of this class
  const NavigatorConstants._();

  static const SPLASH_PAGE = "/splash";
  static const WELCOME_PAGE = "/welcome";
  static const LOGIN_PAGE = "/login";
  static const REGISTER_PAGE = "/register";
  static const ONBOARDING_PAGE = "/onboarding";
  static const NOT_FOUND = "/not_found";
  static const NO_NETWORK = "/noNetwork";
  static const NEED_UPDATE = "/needUpdate";
  static const HOME_PAGE = "/home";
  static const SETTINGS_PAGE = "/settings";
  static const MANAGEMYHABITS_PAGE = "/manageMyHabits";
  static const HABITDETAIL_PAGE = "/habitDetail";
  static const EDIT_HABIT_PAGE = "/editHabit";
}