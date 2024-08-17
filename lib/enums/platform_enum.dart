import 'dart:io';

import '../constants/image_constants.dart';

enum PlatformEnum {
  android,
  ios;

  static PlatformEnum get currentPlatform {
    if (Platform.isIOS) {
      return PlatformEnum.ios;
    }
    if (Platform.isAndroid) {
      return PlatformEnum.android;
    }

    throw Exception('Platform not supported');
  }
}

extension PlatformEnumExtension on PlatformEnum {
  String get storeImage {
    switch (this) {
      case PlatformEnum.android:
        return ImageConstants.googlePlayStore;
      case PlatformEnum.ios:
        return ImageConstants.appleStore;
    }
  }

  String get platformName {
    return this.name;
  }
}