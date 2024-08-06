import 'package:flutter/material.dart';

@immutable
class StringConstants {
  // Can't instantiate this class. Use it directly.
  const StringConstants._();

  static const String appName = 'GoodPlace';

  // Welcome screen strings
  static const String welcomeScreenStrongTitle = 'Hi, Welcome';
  static const String welcomeScreenTitle = "to $appName";
  static const String welcomeScreenSubtitle = 'Explore the app, Find some peace of mind to achive good habits.';
  static const String welcomeScreenButton = 'Get Started';
}