import 'package:flutter/material.dart';

@immutable
class NavigatorConstants {
  // Can't create an instance of this class
  const NavigatorConstants._();

  static const WELCOME_PAGE = "/welcome";
  static const LOGIN_PAGE = "/login";
  static const REGISTER_PAGE = "/register";
  static const NOT_FOUND = "/not_found";
}