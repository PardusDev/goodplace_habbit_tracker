import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/core/base/base_view_model.dart';

class LoginPageViewModel extends ChangeNotifier with BaseViewModel {
  late final BuildContext viewModelContext;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPageViewModel();

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
      // TODO: Change this widget. This widget is just for testing purposes.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Invalid email or password")));
    }
  }

  Future<void> loginWithGoogle(BuildContext context) async {
    // TODO: Implement login with Google logic
    print("Login with Google");
  }
}