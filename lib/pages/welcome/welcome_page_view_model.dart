import 'package:flutter/src/widgets/framework.dart';

import '../../core/base/base_view_model.dart';

class WelcomePageViewModel with BaseViewModel {
  late final BuildContext viewModelContext;

  WelcomePageViewModel();

  void navigateToLogin() {
    navigationService.navigateToPage('/login', null);
  }
}