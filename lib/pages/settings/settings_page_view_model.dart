import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/managers/AppUserManager.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';
import 'package:goodplace_habbit_tracker/widgets/Snackbars.dart';
import 'package:provider/provider.dart';

import '../../core/base/base_view_model.dart';

class SettingsPageViewModel extends ChangeNotifier with BaseViewModel {
  final _navigationService = NavigationService.instance;
  final _authService = AuthService();

  bool _isDeleteAccountLoading = false;

  bool get isDeleteAccountLoading => _isDeleteAccountLoading;

  void deleteAccount(BuildContext buildContext) async {
    if (_isDeleteAccountLoading) return;

    try {
      _isDeleteAccountLoading = true;
      notifyListeners();
      await _authService.deleteAccountPermanently();
      signOut(buildContext);
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    } finally {
      _isDeleteAccountLoading = false;
      notifyListeners();
    }
  }

  void signOut(BuildContext buildContext) async {
    try {
      await _authService.signOut();
      Provider.of<AppUserManager>(buildContext, listen: false).clearUser();
      _navigationService.navigateToPageClear("/login", null);
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }

  void navigateToBack() {
    _navigationService.navigateToBack();
  }
}