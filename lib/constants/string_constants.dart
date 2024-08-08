import 'package:flutter/material.dart';

@immutable
class StringConstants {
  // Can't instantiate this class. Use it directly.
  const StringConstants._();

  static const String appName = 'GoodPlace';

  // Error screen strings
  static const String notFound = "We couldn't find the page you were looking for. :(";
  static const String notFoundSub = "Something went wrong. Try again later 👉👈";

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

    // Password error
  static const String loginScreenPasswordCantBeEmpty = "Password can't be empty.";
  static const String loginScreenEmailOrPasswdNotRight  = "Invalid email or password.";

  // **********************************************************************************

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
  static const String registerScreenEmailCantBeEmpty = "Email can't be empty.";
  static const String registerScreenEmailNotValid = "Email is not valid.";

  static const String registerScreenPasswordCantBeEmpty = "Password can't be empty.";
  static const String registerScreenPasswordShouldBeAtLeast6Chars = "Password should be at least 6 characters.";
  static const String registerScreenPasswordShouldContainNumber = "Password should contain at least one number.";
  static const String registerScreenPasswordShouldContainLetter = "Password should contain at least one letter.";
  static const String registerScreenCannotContainSpace = "Password cannot contain space.";

  static const String registerScreenPasswordNotMatch = "Passwords do not match.";
}