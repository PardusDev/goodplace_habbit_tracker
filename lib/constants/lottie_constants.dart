import 'package:flutter/material.dart';

@immutable
class LottieConstants {
  // Don't instantiate this class. Use it directly.
  const LottieConstants._();

  static final String successLottie = 'success'.toLottie;
}

extension LottieConstantsExtension on String {
  String get toLottie => 'assets/lottie/$this.json';
}