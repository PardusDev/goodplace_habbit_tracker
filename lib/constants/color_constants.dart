import 'package:flutter/material.dart';

@immutable
class ColorConstants {
  // Can't instantiate this class. Use it directly.
  const ColorConstants._();

  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF8E97FD);

  // Button colors
  static const Color buttonWhiteBackground = Color(0xFFEBEAEC);
  static const Color buttonWhiteTextColor = Color(0xFF3F414E);

  static const Color buttonBlueBackground = Color(0xFF8E97FD);
  static const Color buttonBlueTextColor = Color(0xFFF6F1FB);

  // Welcome screen colors
  static const Color welcomeScreenBackgroundColor = Color(0xFF8E97FD);
  static const Color welcomeScreenTitleTextColor = Color(0xFFFFECCC);
  static const Color welcomeScreenSubtitleTextColor = Color(0xFFEBEAEC);

  // Login screen colors
  static const Color loginScreenTitleColor = Color(0xFF3F414E);
  static const Color loginScreenOrTextColor = Color(0xFFA1A4B2);
  static const Color loginScreenInputFieldBackgroundColor = Color(0xFFA1A4B2);
  static const Color loginScreenInputFieldTextColor = Color(0xFFA1A4B2);
  static const Color loginScreenForgotPasswordTextColor = Color(0xFF3F414E);
}