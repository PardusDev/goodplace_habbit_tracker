import 'package:flutter/cupertino.dart';
import 'package:goodplace_habbit_tracker/services/auth_service.dart';

import '../../constants/string_constants.dart';
import '../../core/base/base_view_model.dart';

class ForgotPasswordViewModel with ChangeNotifier, BaseViewModel {
  final AuthService _authService = AuthService();

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  final TextEditingController _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  bool? _isEmailValid = null;
  bool? get isEmailValid => _isEmailValid;

  String _generalErrorText = "";
  String get generalErrorText => _generalErrorText;

  ForgotPasswordViewModel(BuildContext context) {
    this.buildContext = context;
  }

  // region Forgot Password 1
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

  Future<void> navigateToForgotPassword2() async {
    if (_isEmailValid == true) {
      try {
        await _authService.sendPasswordResetEmail(email: _emailController.text);
        navigatorKey.currentState?.pushNamed('/forgotPasswordPage2');
      } catch (e) {
        setGeneralErrorText(e.toString());
      }
    }
    else {
      setGeneralErrorText(StringConstants.registerScreenEmailNotValid);
    }
  }
  // endregion Forgot Password 1

  // region Forgot Password 2
  void navigateToLogin() {
    navigationService.navigateToPageClear("/welcome", null);
    navigationService.navigateToPage('/login', null);
  }
  // endregion Forgot Password 2

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}