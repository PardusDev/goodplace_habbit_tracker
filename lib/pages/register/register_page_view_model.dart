import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/string_constants.dart';

class RegisterPageViewModel extends ChangeNotifier with BaseViewModel {
  final AuthService _authService = AuthService();
  late final BuildContext viewModelContext;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  User? user;
  bool _privacyPolicyChecked = false;

  String _nameErrorText = '';
  String _emailErrorText = '';
  String _passwordErrorText = '';
  String _generalErrorText = '';

  bool _nameValid = false;
  bool _emailValid = false;
  bool _passwordValid = false;
  bool _registering = false;

  RegisterPageViewModel();

  String get nameErrorText => _nameErrorText;
  String get emailErrorText => _emailErrorText;
  String get passwordErrorText => _passwordErrorText;
  String get generalErrorText => _generalErrorText;

  String get name => nameController.text;
  String get email => emailController.text;
  String get password => passwordController.text;

  bool get nameValid => _nameValid;
  bool get emailValid => _emailValid;
  bool get passwordValid => _passwordValid;

  bool get privacyPolicyChecked => _privacyPolicyChecked;

  bool get registering => _registering;

  void navigateToBack() {
    navigationService.navigateToBack();
  }

  void navigateToLogin() {
    navigationService.navigateToPage('/login', null);
  }
  //region NAME *************************************
  void onNameChanged(String value) {
    final result = _validateName(value);
    _nameValid = result['isValid'];
    setNameErrorText(result['errorText']);
  }

  Map<String, dynamic> _validateName(String value) {
    if (value.isEmpty) {
      return {'errorText': StringConstants.registerScreenNameCantBeEmpty, 'isValid': false};
    }
    else if (!RegExp(r'^\S+$').hasMatch(value)) {
      return {'errorText': StringConstants.registerScreenNameNotValid, 'isValid': false};
    }
    else if (value.length < 2) {
      return {'errorText': StringConstants.registerScreenNameShouldBeAtLeast2Chars, 'isValid': false};
    }
    else {
      return {'errorText': '', 'isValid': true};
    }
  }

  setNameErrorText(String error) {
    _nameErrorText = error;
    notifyListeners();
  }
  //endregion NAME *************************************

  // EMAIL *************************************
  void onEmailChanged(String value) {
    final result = _validateEmail(value);
    _emailValid = result['isValid'];
    setEmailErrorText(result['errorText']);
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

  void setEmailErrorText(String error) {
    _emailErrorText = error;
    notifyListeners();
  }
  // EMAIL END *************************************


  // PASSWD *************************************
  void onPasswordChanged(String value) {
    final result = _validatePassword(value);
    _passwordValid = result['isValid'];
    setPasswordErrorText(result['errorText']);
  }

  Map<String, dynamic> _validatePassword(String value) {
    if (value.isEmpty) {
      return {'errorText': StringConstants.registerScreenPasswordCantBeEmpty, 'isValid': false};
    }
    else if (value.length < 6) {
      return {'errorText': StringConstants.registerScreenPasswordShouldBeAtLeast6Chars, 'isValid': false};
    }
    // Password contain space
    else if (!RegExp(r'^\S+$').hasMatch(value)) {
      return {'errorText': StringConstants.registerScreenCannotContainSpace, 'isValid': false};
    }
    // Password should contain at least one letter
    else if (!RegExp(r'[a-zA-Z]').hasMatch(value)) {
      return {'errorText': StringConstants.registerScreenPasswordShouldContainLetter, 'isValid': false};
    }
    // Password should contain at least one digit
    else if (!RegExp(r'\d').hasMatch(value)) {
      return {'errorText': StringConstants.registerScreenPasswordShouldContainNumber, 'isValid': false};
    }
    else {
      return {'errorText': '', 'isValid': true};
    }
  }

  void setPasswordErrorText(String error) {
    _passwordErrorText = error;
    notifyListeners();
  }
  // PASSWD END *************************************

  void updatePrivacyPolicyChecked(bool isChecked) {
    _privacyPolicyChecked = isChecked;
    if (generalErrorText == StringConstants.registerScreenPrivacyPolicyNotChecked && isChecked) {
      setGeneralErrorText('');
    }
    notifyListeners();
  }

  Future<void> register() async {
    if (_registering) {
      return;
    }
    /*
    print(!emailValid));
    print(!passwordValid);
    */

    if (!emailValid || !passwordValid) {
      return;
    }

    // Check if the privacy policy is checked
    if (!_privacyPolicyChecked) {
      setGeneralErrorText(StringConstants.registerScreenPrivacyPolicyNotChecked);
      return;
    }

    setRegistering(true);

    try {
      user = await _authService.registerWithEmailAndPassword(name, email, password);
      if (user == null) {
        setGeneralErrorText(StringConstants.anErrorOccured);
        setRegistering(false);
        return;
      }
      goToTheOnboardingIfNecessary();
    } catch (e) {
      setGeneralErrorText(e.toString());
    } finally {
      setRegistering(false);
    }
  }

  Future<void> continueWithGoogle() async {
    try {
      user = await _authService.signInWithGoogle();
      if (user == null) {
        setGeneralErrorText(StringConstants.anErrorOccured);
      } else {
        goToTheOnboardingIfNecessary();
      }
    } catch (e) {
      setGeneralErrorText(e.toString());
    }
  }

  void goToTheOnboardingIfNecessary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool('onboarding') ?? false;

    if (seenOnboarding) {
      navigationService.navigateToPageClear("/home", null);
    } else {
      navigationService.navigateToPageClear("/onboarding", null);
    }
  }

  void setGeneralErrorText(String error) {
    _generalErrorText = error;
    notifyListeners();
  }

  void setRegistering(bool value) {
    _registering = value;
    notifyListeners();
  }
}