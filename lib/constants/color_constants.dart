import 'package:flutter/material.dart';

@immutable
class ColorConstants {
  // Can't instantiate this class. Use it directly.
  const ColorConstants._();

  static const Color transparent = Colors.transparent;
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF8E97FD);

  static const Color validColor = Color(0xFF6CB28E);
  static const Color errorColor = Color(0xFFE57373);


  // Button colors
  static const Color buttonWhiteBackground = Color(0xFFEBEAEC);
  static const Color buttonWhiteTextColor = Color(0xFF3F414E);

  static const Color buttonBlueBackground = Color(0xFF8E97FD);
  static const Color buttonBlueTextColor = Color(0xFFF6F1FB);

  static const Color backButtonIconColor = Color(0xFF3F414E);
  static const Color backButtonBorderColor = Color(0xFFEBEAEC);

    // Outlined Button
  static const Color outlinedButtonColor = Colors.white;
  static const Color outlinedButtonTextColor = Color(0xFF3F414E);
  static const Color outlinedButtonBorderColor = Color(0xFFEBEAEC);

  // Welcome screen colors
  static const Color welcomeScreenBackgroundColor = Color(0xFF8E97FD);
  static const Color welcomeScreenTitleTextColor = Color(0xFFFFECCC);
  static const Color welcomeScreenSubtitleTextColor = Color(0xFFEBEAEC);

  // Login screen colors
  static const Color loginScreenTitleColor = Color(0xFF3F414E);
  static const Color loginScreenOrTextColor = Color(0xFFA1A4B2);
  static const Color loginScreenInputFieldBackgroundColor = Color(0xFFF2F3F7);
  static const Color loginScreenInputFieldHintColor = Color(0xFFA1A4B2);
  static const Color loginScreenInputFieldTextColor = Color(0xFF3F414E);
  static const Color loginScreenForgotPasswordTextColor = Color(0xFF3F414E);
  static const Color loginScreenErrorTextColor = Color(0xFFE57373);

  // Register screen colors
  static const Color registerScreenTitleColor = Color(0xFF3F414E);
  static const Color registerScreenOrTextColor = Color(0xFFA1A4B2);
  static const Color registerScreenPrivacyPolicyTextColor = Color(0xFFA1A4B2);
  static const Color registerScreenPrivacyPolicyLinkColor = Color(0xFF7583CA);
  static const Color registerScreenAlreadyHaveAnAccountColor = Color(0xFFA1A4B2);
  static const Color registerScreenSignInColor = Color(0xFF8E97FD);

  // Collapsable Bottom Sheet
  static const Color collapsableBottomSheetBackgroundColor = Color(0xFFFFFFFF);
  static const Color collapsableBottomSheetTitleColor = Color(0xFF7583CA);
  static const Color collapsableBottomSheetTextColor = Color(0xFFA1A4B2);

  // Checkbox
  static const Color checkboxBorderColor = Color(0xFFA1A4B2);
  static const Color checkboxCheckedColor = Color(0xFF8E97FD);
  static const Color checkboxBackgroundColor = Color(0xFFEFEFEF);
}