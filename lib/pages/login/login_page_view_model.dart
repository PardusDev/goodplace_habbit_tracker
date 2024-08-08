import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../constants/string_constants.dart';

class LoginPageViewModel extends ChangeNotifier with BaseViewModel {
  late final BuildContext viewModelContext;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String _errorText = '';

  LoginPageViewModel();

  String get errorText => _errorText;

  void navigateToBack() {
    navigationService.navigateToBack();
  }

  void navigateToForgotPassword() {
    navigationService.navigateToPage('/not-found', null);
  }

  void navigateToRegister() {
    navigationService.navigateToPage('/register', null);
  }

  Future<void> login(BuildContext context) async {
    final email = emailController.text;
    final passwd = passwordController.text;

    // TODO: Implement login logic
    if (email == 'test@example.com' && passwd == 'password') {
      print("Login successful");
    } else {
      setErrorText(StringConstants.loginScreenEmailOrPasswdNotRight);
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    // TODO: Implement login with Google logic
    print("Login with Google");
  }

  void onPasswordChanged(String value) {
    if (value.isEmpty) {
      setErrorText(StringConstants.loginScreenPasswordCantBeEmpty);
    } else {
      setErrorText('');
    }
  }

  void setErrorText(String error) {
    _errorText = error;
    notifyListeners();
  }
}