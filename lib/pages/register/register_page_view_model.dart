import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';

import '../../constants/string_constants.dart';

class RegisterPageViewModel extends ChangeNotifier with BaseViewModel {
  final AuthService _authService = AuthService();
  late final BuildContext viewModelContext;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  User? user;

  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _rePasswordErrorText = '';
  String _generalErrorText = '';

  RegisterPageViewModel();

  String get emailErrorText => _emailErrorText;
  String get passwordErrorText => _passwordErrorText;
  String get rePasswordErrorText => _rePasswordErrorText;
  String get generalErrorText => _generalErrorText;

  void navigateToBack() {
    navigationService.navigateToBack();
  }

  void navigateToLogin() {
    navigationService.navigateToPage('/login', null);
  }

  // EMAIL *************************************
  bool onEmailChanged(String value) {
    if (value.isEmpty) {
      setEmailErrorText(StringConstants.registerScreenEmailCantBeEmpty);
      return false;
    }
    else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      setEmailErrorText(StringConstants.registerScreenEmailNotValid);
      return false;
    }
    else if (!RegExp(r'^\S+$').hasMatch(value)) {
      setEmailErrorText(StringConstants.registerScreenEmailNotValid);
      return false;
    }
    else {
      setEmailErrorText('');
      return true;
    }
  }

  void setEmailErrorText(String error) {
    _emailErrorText = error;
    notifyListeners();
  }
  // EMAIL END *************************************


  // PASSWD *************************************
  bool onPasswordChanged(String value) {
    if (value.isEmpty) {
      setPasswordErrorText(StringConstants.registerScreenPasswordCantBeEmpty);
      return false;
    }
    else if (value.length < 6) {
      setPasswordErrorText(StringConstants.registerScreenPasswordShouldBeAtLeast6Chars);
      return false;
    }
    // Password contain space
    else if (!RegExp(r'^\S+$').hasMatch(value)) {
      setPasswordErrorText(StringConstants.registerScreenCannotContainSpace);
      return false;
    }
    // Password should contain at least one letter
    else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      setPasswordErrorText(StringConstants.registerScreenPasswordShouldContainLetter);
      return false;
    }
    // Password should contain at least one digit
    else if (!RegExp(r'\d').hasMatch(value)) {
      setPasswordErrorText(StringConstants.registerScreenPasswordShouldContainNumber);
      return false;
    }
    else {
      setPasswordErrorText('');
      return true;
    }
  }

  void setPasswordErrorText(String error) {
    _passwordErrorText = error;
    notifyListeners();
  }
  // PASSWD END *************************************

  // CONFIRM PASSWD *************************************
  bool onConfirmPasswordChanged(String value) {
    if (value.isEmpty) {
      setRePasswordErrorText(StringConstants.registerScreenPasswordCantBeEmpty);
      return false;
    }
    else if (value != passwordController.text) {
      setRePasswordErrorText(StringConstants.registerScreenPasswordNotMatch);
      return false;
    }
    else {
      setRePasswordErrorText('');
      return true;
    }
  }

  void setRePasswordErrorText(String error) {
    _rePasswordErrorText = error;
    notifyListeners();
  }
  // CONFIRM PASSWD END *************************************


  Future<void> register() async {
    final email = emailController.text;
    final passwd = passwordController.text;
    final confirmPasswd = confirmPasswordController.text;

    /*
    print(!onEmailChanged(email));
    print(!onEmailChanged(passwd));
    print(!onEmailChanged(confirmPasswd));
    */

    // Check if the email, password and confirm password is valid
    if (!onEmailChanged(email) || !onPasswordChanged(passwd) || !onConfirmPasswordChanged(confirmPasswd)){
      return;
    }

    try {
      user = await _authService.registerWithEmailAndPassword(email, passwd);
      if (user == null) {
        setGeneralErrorText(StringConstants.anErrorOccured);
        return;
      }
      // Navigate to home screen.
      // The home screen not implemented yet.
      // Therefore navigate to welcome screen.
      navigationService.navigateToPageClear('/welcome', null);
    } catch (e) {
      setGeneralErrorText(e.toString());
    }
  }

  Future<void> continueWithGoogle() async {
    try {
      user = await _authService.signInWithGoogle();
      if (user == null) {
        setGeneralErrorText(StringConstants.anErrorOccured);
      }
    } catch (e) {
      setGeneralErrorText(e.toString());
    }
  }

  void setGeneralErrorText(String error) {
    _generalErrorText = error;
    notifyListeners();
  }
}