import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/init/navigation/navigation_service.dart';
import 'package:goodplace_habbit_tracker/locator.dart';
import 'package:goodplace_habbit_tracker/repository/repository.dart';

import '../../services/auth_service.dart';
import '../../widgets/Snackbars.dart';

enum ViewState { geliyor, geldi, hata }

class HomePageViewModel with ChangeNotifier {
  final Repository _repository = locator<Repository>();
  ViewState _state = ViewState.geliyor;
  ViewState get state => _state;
  String motivasyon="";
  final NavigationService _navigationService = NavigationService.instance;
  final AuthService _authService = AuthService();

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  getMotivasyon()async{
    try {
      motivasyon = await _repository.getMotivasyon();
    } catch (e) {
      // Maybe we can get motivation from local storage
      motivasyon = e.toString();
    } finally {
      notifyListeners();
    }
  }

  void signOut(BuildContext buildContext) async {
    try {
      await _authService.signOut();
      _navigationService.navigateToPageClear("/welcome", null);
    } catch (e) {
      ScaffoldMessenger.of(buildContext).showSnackBar(
          errorSnackBar(
              e.toString()
          )
      );
    }
  }

  void navigateToSettings() {
    _navigationService.navigateToPage('/settings', null);
  }
}