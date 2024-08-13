import 'package:flutter/foundation.dart';

import '../models/AppUser.dart';

class AppUserManager extends ChangeNotifier {
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