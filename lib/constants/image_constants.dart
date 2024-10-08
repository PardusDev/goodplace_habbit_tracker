import 'package:flutter/material.dart';

@immutable
class ImageConstants {
  // Can't create an instance of this class. Use it directly.
  const ImageConstants._();

  static final String googleLogo= 'googleLogo'.imageToPng;
  static final String notFound = 'not_found_asset'.imageToPng;
  static final String splashPageBg = 'splash_screen_bg'.imageToPng;
  static final String welcomeBackground = 'welcome_background'.imageToPng;
  static final String authPageShapeBg = 'auth_page_shape_bg'.imageToPng;
  static final String noNetworkVector = 'no_network'.imageToPng;
  static final String updateRequiredVector = 'update_required_vector'.imageToPng;

  static final String googlePlayStore = 'google_play_store'.iconToPng;
  static final String appleStore = 'apple_store'.iconToPng;
  static final String passwordHide = 'ic_password_hide'.iconToPng;
  static final String passwordShown = 'ic_password_shown'.iconToPng;
  static final String aiAvatar = 'ai_avatar'.iconToPng;
  static final String aiCreateIcon = 'ai_create_icon'.iconToPng;
  static final String userAvatar = 'user_avatar'.iconToPng;
  static final String icFlame = 'ic_flame'.iconToPng;
  static final String icStats = 'ic_stats'.iconToPng;
  static final String icHype = 'ic_hype'.iconToPng;

  //region Onboarding
  static final String onboardingPage1 = 'page1'.onboardingToPng;
  static final String onboardingPage2 = 'page2'.onboardingToPng;
  static final String onboardingPage3 = 'page3'.onboardingToPng;
  static final String onboardingPage4 = 'page4'.onboardingToPng;
  //endregion
}

extension _StringPath on String {
  String get imageToPng => 'assets/images/$this.png';
  String get iconToPng => 'assets/icons/$this.png';
  String get onboardingToPng => 'assets/onboarding/$this.png';
}