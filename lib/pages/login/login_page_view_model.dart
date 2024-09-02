import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';

import '../../constants/string_constants.dart';

class LoginPageViewModel extends ChangeNotifier with BaseViewModel {
  final AuthService _authService = AuthService();
  late final BuildContext viewModelContext;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User? user;

  String _errorText = '';

  LoginPageViewModel();

  String get errorText => _errorText;

  void navigateToBack() {
    navigationService.navigateToBack();
  }

  void navigateToForgotPassword() {
    navigationService.navigateToPage('/forgotPasswordFlow', null);
  }

  void navigateToRegister() {
    navigationService.navigateToPage('/register', null);
  }

  void navigateToOnboarding() {
    navigationService.navigateToPageClear('/onboarding', null);
  }

  void navigateToHome() {
    navigationService.navigateToPageClear('/home', null);
  }

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    try {
      user = await _authService.signInWithEmailAndPassword(email, password);
      if (user == null) {
        setErrorText(StringConstants.loginScreenEmailOrPasswdNotRight);
      }
      navigateToHome();
    } catch (e) {
      setErrorText(e.toString());
      return;
    }

  }

  Future<void> loginWithGoogle() async {
    try {
      UserCredential? userCredential = await _authService.signInWithGoogle();
      user = userCredential!.user;
      if (user == null) {
        setErrorText(StringConstants.anErrorOccured);
      } else {
        if (userCredential.additionalUserInfo!.isNewUser) {
          navigateToOnboarding();
        } else {
          navigateToHome();
        }
      }
    } catch (e) {
      setErrorText(e.toString());
    }
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

  // TODO: When the login, setup reminders

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}