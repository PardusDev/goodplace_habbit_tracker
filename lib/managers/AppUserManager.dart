import 'package:flutter/foundation.dart';

import '../models/AppUser.dart';

class AppUserManager extends ChangeNotifier {
  // Singleton
  static AppUserManager _instance = AppUserManager._();
  static AppUserManager get instance => _instance;

  AppUserManager._();

  AppUser? _appUser;

  AppUser? get appUser => _appUser;

  void setUser(AppUser appUser) {
    _appUser = appUser;
    notifyListeners();
  }

  void clearUser() {
    _appUser = null;
    notifyListeners();
  }
}