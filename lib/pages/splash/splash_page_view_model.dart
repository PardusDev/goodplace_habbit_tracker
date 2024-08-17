import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';
import 'package:goodplace_habbit_tracker/services/connectivity_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../core/base/base_view_model.dart';
import '../../services/version_service.dart';
import '../../utilities/version_manager.dart';

class SplashPageViewModel with ChangeNotifier, BaseViewModel {
  final AuthService _authenticationService = AuthService();
  final VersionService _versionService = VersionService();
  final ConnectivityService _connectivityService = ConnectivityService();
  late final _isRequiredUpdate;

  bool get isRequiredUpdate => _isRequiredUpdate;

  SplashPageViewModel() {
    handleStartUpLogic();
  }

  void handleStartUpLogic() async {
    // Get the client version.
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String clientVersion = packageInfo.version;

    // Get the current user.
    User? user = await _authenticationService.getCurrentUser();

    await checkVersion(clientVersion);
    if (_isRequiredUpdate) {
      // Show a dialog to the user to update the app.
      navigationService.navigateToPageClear(("/needUpdate"), null);
      return;
    }

    // Check the network connection.
    final hasConnection = await _connectivityService.hasConnection();
    if (!hasConnection) {
      navigationService.navigateToPageClear(("/noNetwork"), null);
      return;
    }

    // Fake delay to simulate a network request.
    await Future.delayed(const Duration(milliseconds: 750));
    if (user != null) {
      navigationService.navigateToPageClear(("/home"), null);
    } else {
      navigationService.navigateToPageClear("/welcome", null);
    }
  }

  Future<void> checkVersion(String clientVersion) async {
    final databaseValue = await _versionService.getVersionNumber();
    if (databaseValue == null || databaseValue.isEmpty) {
      // If the version number is not found in the database, set isRequiredUpdate to false.
      // Maybe we can show a message to the user that an error occurred while fetching the version number.
      _isRequiredUpdate = false;
      return;
    }

    final checkIsNeedUpdate = VersionManager(appValue: clientVersion, databaseValue: databaseValue);

    if (checkIsNeedUpdate.isNeedUpdate()) {
      _isRequiredUpdate = true;
      return;
    }

    _isRequiredUpdate = false;
    notifyListeners();
  }
}