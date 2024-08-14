import 'dart:math';

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
  static const String registerScreenNameHint = 'Name';
  static const String registerScreenEmailHint = "Email address";
  static const String registerScreenPasswordHint = "Password";
  static const String registerScreenRetypePasswordHint = "Retype Password";
  static const String registerScreenPrivacyPolicyText = "I have read the ";
  static const String registerScreenPrivacyPolicyLink = "Privacy Policy";
  static const String registerScreenGetStartedButton = 'Get Started';
  static const String registerScreenAlreadyHaveAnAccount = 'ALREADY HAVE AN ACCOUNT? ';
  static const String registerScreenSignIn = "SIGN IN";
  static const String pleaseWait = "Please wait...";

  static const String registerScreenNameCantBeEmpty = "Name can't be empty.";
  static const String registerScreenNameNotValid = "Name is not valid.";
  static const String registerScreenNameShouldBeAtLeast2Chars = "Name should be at least 2 characters.";

  static const String registerScreenEmailCantBeEmpty = "Email can't be empty.";
  static const String registerScreenEmailNotValid = "Email is not valid.";

  static const String registerScreenPasswordCantBeEmpty = "Password can't be empty.";
  static const String registerScreenPasswordShouldBeAtLeast6Chars = "Password should be at least 6 characters.";
  static const String registerScreenPasswordShouldContainNumber = "Password should contain at least one number.";
  static const String registerScreenPasswordShouldContainLetter = "Password should contain at least one letter.";
  static const String registerScreenCannotContainSpace = "Password cannot contain space.";
  static const String registerScreenPrivacyPolicyNotChecked = "Please accept the Privacy Policy.";
  //endregion

  //region Onboarding screen strings
  static const String onboardingPage1Title = 'Track Your Habit';
  static const String onboardingPage1Subtitle = "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals";

  static const String onboardingPage2Title = 'Get Burn';
  static const String onboardingPage2Subtitle = "Let's keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever";

  static const String onboardingPage3Title = 'Eat Well';
  static const String onboardingPage3Subtitle = "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun";

  static const String onboardingPage4Title = 'Morning Yoga';
  static const String onboardingPage4Subtitle = "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun";
  //endregion

  //region Firebase Auth Exceptions
  static const String invalidEmail = "The email address is badly formatted.";
  static const String wrongPassword = "The password is incorrect. Please try again.";
  static const String userDisabled = "This user account has been disabled. Please contact support.";
  static const String emailAlreadyInUse = "The email address is already in use by another account.";
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

  // region Dio Exceptions
  static const String requestCancelled = "Request to the server was cancelled.";
  static const String connectionTimeout = "Connection timeout with the server.";
  static const String sendTimeout = "Send timeout in connection with the server.";
  static const String receiveTimeout = "Receive timeout in connection with the server.";
  static const String badRequest = "Bad request.";
  static const String unauthorized = "Unauthorized request.";
  static const String forbidden = "Forbidden request.";
  static const String dioNotFound = "Requested resource not found.";
  static const String internalServerError = "Internal server error.";
  static const String badCertificate = "Bad SSL certificate.";
  static const String connectionError = "Connection error occurred.";
  // endregion Dio Exceptions END

  //region Privacy Policy
  static const String privacyPolicy = 'Privacy Policy';
  static const String privacyPolicyText = 'This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). This Privacy Policy describes how your personal information is collected, used, and shared when you visit or make a purchase from goodplace.com (the “Site”). ';
  //endregion

  //region Collapsable Bottom Sheet
  static const String collapsableBottomSheetClose = 'Close';
  //endregion

  // region Alert Dialog
  static const String alertDialogOk = 'OK';
  static const String alertDialogConfirm = 'Confirm';
  static const String alertDialogCancel = 'Cancel';
  // endregion

  // region Settings screen strings
  static const String settingsScreenTitle = "Settings";
  static const String deleteAccount = "Delete Account";
  // endregion

  // region Delete Account Confirmation
  static const String areYouSure = "Are you sure?";
  static const String deleteAccountConfirmationText = "Are you sure you want to delete your account? This action cannot be undone.";
  // endregion Settings screen strings END

  // region Habits operations
  static const String myHabits = "My Habits";
  static const String homePageHabitListTileButton = "I did it!";
  static const String homePageHabitListTileButtonCompleted = "Completed";
  // region Create Habit Screen
  static const String createHabitScreenTitle = "Create Habit";
  static const String createHabitScreenNameHint = "Habit Name";
  static const String createHabitScreenSubjectHint = "What is your subject?";
  static const String createHabitScreenAddImageLabel = "Add Image";
  static const String createHabitScreenCreateButton = "Create";
  static const String habitNameEmptyError = "Habit name can't be empty.";
  // endregion
  // region Success Screen
  static const String successScreenTitle = "Success!";

  static const List<String> successScreenSubtitles = [
    "High five! You’re on fire (in a good way)!",
    "Boom! You just owned that task!",
    "Achievement unlocked: You’re officially awesome!",
    "Habit complete! You’re basically a habit ninja now.",
    "Habit success! Who’s the boss? You’re the boss!",
    "Daily habit done! Your streak is hotter than your morning coffee.",
    "Crushed it! Your future self is giving you a high five!"
  ];

  static get successScreenSubtitleRandom => successScreenSubtitles[Random().nextInt(successScreenSubtitles.length)];

  static const String successScreenButton = "Done";
  // endregion

  // region Habit Alert Dialog
  static const String habitAlertDialogTitle = "Are you sure?";
  static const String habitAlertDialogBody = "Do you want to remove this habit?";
  // endregion Habits operations END

}