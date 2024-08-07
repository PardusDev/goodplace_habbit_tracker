import 'package:flutter/material.dart';

@immutable
class ImageConstants {
  // Can't create an instance of this class. Use it directly.
  const ImageConstants._();

  static final String googleLogo= 'googleLogo'.imageToPng;
}

extension _StringPath on String {
  String get imageToPng => 'assets/images/$this.png';
}