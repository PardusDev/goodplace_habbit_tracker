import 'package:flutter/material.dart';

@immutable
class ImageConstants {
  // Can't create an instance of this class. Use it directly.
  const ImageConstants._();

  static final String googleLogo= 'googleLogo'.imageToPng;
  static final String notFound = 'not_found_asset'.imageToPng;
  static final String welcomeBackground = 'welcome_background'.imageToPng;
  static final String authPageShapeBg = 'auth_page_shape_bg'.imageToPng;
}

extension _StringPath on String {
  String get imageToPng => 'assets/images/$this.png';
}