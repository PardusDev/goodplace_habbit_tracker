import 'package:flutter/cupertino.dart';

import '../../constants/string_constants.dart';
import '../../core/base/base_view_model.dart';

class ForgotPasswordViewModel with ChangeNotifier, BaseViewModel {
  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  bool? _isEmailValid = null;
  bool? get isEmailValid => _isEmailValid;

  String _generalErrorText = "";
  String get generalErrorText => _generalErrorText;

  void onEmailChanged(String value) {
    final result = _validateEmail(value);
    _isEmailValid = result['isValid'];
    setGeneralErrorText(result['errorText']);
  }

  Map<String, dynamic> _validateEmail(String value) {
    if (value.isEmpty) {
      return {'errorText': StringConstants.registerScreenEmailCantBeEmpty, 'isValid': false};
    }
    else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return {'errorText': StringConstants.registerScreenEmailNotValid, 'isValid': false};
    }
    else if (!RegExp(r'^\S+$').hasMatch(value)) {
      return {'errorText': StringConstants.registerScreenEmailNotValid, 'isValid': false};
    }
    else {
      return {'errorText': '', 'isValid': true};
    }
  }

  void setGeneralErrorText(String error) {
    _generalErrorText = error;
    notifyListeners();
  }

  void navigateToBack() {
    navigationService.navigateToBack();
  }

  void navigateToForgotPassword2() {
    if (_isEmailValid == true) {
      navigationService.navigateToPage('/forgot_password_2', null);
    }
    else {
      setGeneralErrorText(StringConstants.registerScreenEmailNotValid);
    }
  }
}