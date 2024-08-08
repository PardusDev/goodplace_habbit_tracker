import 'package:flutter/material.dart';

@immutable
class StringConstants {
  // Can't instantiate this class. Use it directly.
  const StringConstants._();

  static const String appName = 'GoodPlace';

  // Welcome screen strings
  static const String welcomeScreenStrongTitle = 'Hi, Welcome';
  static const String welcomeScreenTitle = "to $appName";
  static const String welcomeScreenSubtitle = 'Explore the app, Find some peace of mind to achive good habits.';
  static const String welcomeScreenButton = 'Get Started';

  // Login screen strings
  static const String loginScreenTitle = 'Welcome Back!';
  static const String loginWithGoogle = 'Continue with Google';
  static const String loginScreenOrText = 'OR LOG IN WITH EMAIL';
  static const String loginScreenEmailHint = 'Email address';
  static const String loginScreenPasswordHint = 'Password';
  static const String loginScreenLoginButton = 'LOG IN';
  static const String loginScreenForgotPassword = 'Forgot Password?';
  static const String dontHaveAnAccount = "Don't have an account? ";
  static const String signUp = 'Sign Up';

  // Register screen strings
  static const String registerScreenTitle = 'Create your account';
  static const String registerScreenOrText = 'OR SIGN UP WITH EMAIL';
  static const String registerScreenEmailHint = "Email address";
  static const String registerScreenPasswordHint = "Password";
  static const String registerScreenRetypePasswordHint = "Retype Password";
  static const String registerScreenPrivacyPolicyText = "I have read the ";
  static const String registerScreenPrivacyPolicyLink = "Privacy Policy";
  static const String registerScreenGetStartedButton = 'Get Started';
  static const String registerScreenAlreadyHaveAnAccount = 'ALREADY HAVE AN ACCOUNT? ';
  static const String registerScreenSignIn = "SIGN IN";
}