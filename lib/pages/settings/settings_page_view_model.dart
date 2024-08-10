import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';
import 'package:goodplace_habbit_tracker/widgets/Snackbars.dart';

import '../../core/base/base_view_model.dart';

class SettingsPageViewModel extends ChangeNotifier with BaseViewModel {
  final _navigationService = NavigationService.instance;
  final _authService = AuthService();

  void deleteAccount(BuildContext buildContext) async {
    try {
      await _authService.deleteAccountPermanently();
      signOut(buildContext);
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }

  void signOut(BuildContext buildContext) async {
    try {
      await _authService.signOut();
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