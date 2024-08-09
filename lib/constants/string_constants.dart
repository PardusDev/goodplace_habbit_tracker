import 'package:flutter/material.dart';

@immutable
class StringConstants {
  // Can't instantiate this class. Use it directly.
  const StringConstants._();

  static const String appName = 'GoodPlace';

  //region Error screen strings
  static const String notFound = "We couldn't find the page you were looking for. :(";
  static const String notFoundSub = "Something went wrong. Try again later 👉👈";
  //endregion

  //region Welcome screen strings
  static const String welcomeScreenStrongTitle = 'Hi, Welcome';
  static const String welcomeScreenTitle = "to $appName";
  static const String welcomeScreenSubtitle = 'Explore the app, Find some peace of mind to achive good habits.';
  static const String welcomeScreenButton = 'Get Started';
  //endregion

  //region Login screen strings
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
  static const String anErrorOccured = "An error occured.";
  //endregion

  //region Register screen strings
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
  //endregion

  //region Firebase Auth Exceptions
  static const String invalidEmail = "The email address is badly formatted.";
  static const String wrongPassword = "The password is incorrect. Please try again.";
  static const String userDisabled = "This user account has been disabled. Please contact support.";
  static const String userNotFound = "No user found with this email. Please check the email address and try again.";
  static const String tooManyRequests = "Too many requests. Please try again later.";
  static const String operationNotAllowed = "Operation not allowed. Please contact support.";

  static const String accountExists = 'An account already exists with a different credential.';
  static const String invalidCredential = 'The credential received is not valid or has expired. Please try again.';
  static const String invalidVerificationCode = 'The verification code is invalid.';
  static const String invalidVerificationId = 'The verification ID is invalid.';
  //endregion

  //region Firebase General Exceptions
  static const String operationCancelled = 'The operation was cancelled.';
  static const String unknownError = 'An unknown error occurred.';
  static const String invalidArgument = 'An invalid argument was provided.';
  static const String deadlineExceeded = 'The operation timed out.';
  static const String documentNotFound = 'The requested document was not found.';
  static const String documentAlreadyExists = 'The document already exists.';
  static const String permissionDenied = 'You do not have permission to perform this operation.';
  static const String resourceExhausted = 'The resource has been exhausted (quota exceeded).';
  static const String failedPrecondition = 'Operation could not be performed due to failed preconditions.';
  static const String operationAborted = 'The operation was aborted.';
  static const String outOfRange = 'The operation was attempted outside the valid range.';
  static const String operationNotImplemented = 'This operation is not implemented or supported.';
  static const String internalError = 'An internal error occurred.';
  static const String serviceUnavailable = 'The service is currently unavailable.';
  static const String dataLoss = 'Unrecoverable data loss or corruption.';
  static const String unauthenticated = 'You are not authenticated. Please log in and try again.';
  //endregion
}