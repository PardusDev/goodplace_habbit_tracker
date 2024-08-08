import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

import '../../constants/string_constants.dart';

class RegisterPageViewModel extends ChangeNotifier with BaseViewModel {
  late final BuildContext viewModelContext;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _rePasswordErrorText = '';

  RegisterPageViewModel();

  String get emailErrorText => _emailErrorText;
  String get passwordErrorText => _passwordErrorText;
  String get rePasswordErrorText => _rePasswordErrorText;

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


  Future<void> register(BuildContext context) async {
    final email = emailController.text;
    final passwd = passwordController.text;
    final confirmPasswd = confirmPasswordController.text;
  }
}