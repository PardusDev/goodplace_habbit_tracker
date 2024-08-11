
import 'package:flutter/material.dart';

import '../../core/base/base_view_model.dart';

class WelcomePageViewModel extends ChangeNotifier with BaseViewModel {
  late final BuildContext viewModelContext;

  WelcomePageViewModel();

  void navigateToLogin() {
    navigationService.navigateToPage('/login', null);
  }
}