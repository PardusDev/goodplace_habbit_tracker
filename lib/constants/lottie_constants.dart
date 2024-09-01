import 'dart:math';

import 'package:flutter/material.dart';

@immutable
class LottieConstants {
  // Don't instantiate this class. Use it directly.
  const LottieConstants._();

  static final String successLottie = 'success'.toLottie;
  static final String awardCupLottie = 'award_cup'.toLottie;
  static final String awardWithGreenLottie = 'award_with_green'.toLottie;
  static final String successMadal = 'success_madal'.toLottie;

  static final List<String> congratulationLotties = [
    successLottie,
    awardCupLottie,
    awardWithGreenLottie,
    successMadal,
  ];

  static get congratulationLottiesRandom => congratulationLotties[Random().nextInt(congratulationLotties.length)];
}

extension LottieConstantsExtension on String {
  String get toLottie => 'assets/lottie/$this.json';
}