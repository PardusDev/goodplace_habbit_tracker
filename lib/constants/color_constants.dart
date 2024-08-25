import 'package:flutter/material.dart';

@immutable
class ColorConstants {
  // Can't instantiate this class. Use it directly.
  const ColorConstants._();

  static const Color transparent = Colors.transparent;
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF8E97FD);
  static const Color secondaryColor = Color(0xFFA1A4B2);

  static const Color validColor = Color(0xFF6CB28E);
  static const Color errorColor = Color(0xFFE57373);


  // Button colors
  static const Color buttonWhiteBackground = Color(0xFFEBEAEC);
  static const Color buttonWhiteTextColor = Color(0xFF3F414E);

  static const Color buttonBlueBackground = Color(0xFF8E97FD);
  static const Color buttonBlueTextColor = Color(0xFFF6F1FB);

  static const Color backButtonIconColor = Color(0xFF3F414E);
  static const Color backButtonBorderColor = Color(0xFFEBEAEC);

    // Outlined Button
  static const Color outlinedButtonColor = Colors.white;
  static const Color outlinedButtonTextColor = Color(0xFF3F414E);
  static const Color outlinedButtonBorderColor = Color(0xFFEBEAEC);

  // Welcome screen colors
  static const Color welcomeScreenBackgroundColor = Color(0xFF8E97FD);
  static const Color welcomeScreenTitleTextColor = Color(0xFFFFECCC);
  static const Color welcomeScreenSubtitleTextColor = Color(0xFFEBEAEC);

  // Login screen colors
  static const Color loginScreenTitleColor = Color(0xFF3F414E);
  static const Color loginScreenOrTextColor = Color(0xFFA1A4B2);
  static const Color loginScreenInputFieldBackgroundColor = Color(0xFFF2F3F7);
  static const Color loginScreenInputFieldHintColor = Color(0xFFA1A4B2);
  static const Color loginScreenInputFieldTextColor = Color(0xFF3F414E);
  static const Color loginScreenForgotPasswordTextColor = Color(0xFF3F414E);
  static const Color loginScreenErrorTextColor = Color(0xFFE57373);

  // Register screen colors
  static const Color registerScreenTitleColor = Color(0xFF3F414E);
  static const Color registerScreenOrTextColor = Color(0xFFA1A4B2);
  static const Color registerScreenPrivacyPolicyTextColor = Color(0xFFA1A4B2);
  static const Color registerScreenPrivacyPolicyLinkColor = Color(0xFF7583CA);
  static const Color registerScreenAlreadyHaveAnAccountColor = Color(0xFFA1A4B2);
  static const Color registerScreenSignInColor = Color(0xFF8E97FD);

  // Collapsable Bottom Sheet
  static const Color collapsableBottomSheetBackgroundColor = Color(0xFFFFFFFF);
  static const Color collapsableBottomSheetTitleColor = Color(0xFF7583CA);
  static const Color collapsableBottomSheetTextColor = Color(0xFFA1A4B2);

  // Checkbox
  static const Color checkboxBorderColor = Color(0xFFA1A4B2);
  static const Color checkboxCheckedColor = Color(0xFF8E97FD);
  static const Color checkboxBackgroundColor = Color(0xFFEFEFEF);

  // region Settings screen
  static const Color settingsScreenItemTextColor = Color(0xFF3F414E);
  static const Color settingsScreenItemIconColor = Color(0xFFA1A4B2);
  static const Color deleteAccountButtonColor = Color(0xFFE57373);
  // endregion

  // region Snackbar colors
  static const Color errorSnackBarColor = Color(0xFFE57373);
  static const Color warningSnackBarColor = Color(0xFFfffc7f);
  static const Color successSnackBarColor = Color(0xFF6CB28E);
  // endregion

  // region CircularButtonGappedBorder
  static const Color continueButtonIconColor = Color(0xFFEFEFEF);
  static const Color continueButtonFullBorderColor = Color(0xFFF7F8F8);
  static const List<Color> continueButtonColors = [
    Color(0xFF9DCEFF),
    Color(0xFF92A3FD)
  ];
  // endregion

  // region HomePage
  static const Color homePageCardBackgroundColor = Color(0xFFFFFFFF);
  static const Color homePageCardTitleColor = Color(0xFF373737);

  static const Color homePageAddHabbitButtonBackgroundColor = Color(0xFF4D57C8);
  static const Color homePageAddHabbitButtonIconColor = Color(0xFFFFFFFF);
  static const Color homePageHabitListTileTitleColor = Color(0xFFEFEFEF);
  static const Color homePageHabitListTileButtonColor = Color(0xFF4D57C8);
  static const Color homePageHabitListTileButtonTextColor = Color(0xFFFFFFFF);
  static const Color homePageCompletedHabitListTileButton = Color(0xFFA1A4B2);
  static const Color homePageCompletedHabitListTileButtonTextColor = Color(0xFF3F414E);

  static const Color homePageHabitListShowAllTextColor = Color(0xFF4D57C8);
  // endregion

  // region CreateHabit
  static const Color createHabitAIIconColor = Color(0xFFFFD700);
  // endregion

  // region
  static const Color aiChatBubbleBackgroundColor = Color(0xFFEFEFEF);
  static const Color aiChatBubbleTextColor = Color(0xFF3F414E);
  static const Color aiChatBubbleUserBackgroundColor = Color(0xFF8E97FD);
  static const Color aiChatBubbleUserTextColor = Color(0xFFFFFFFF);
  static const List<Color> aiChatBubbleIndicatorGradientColors = [
    Color(0xFF9DCEFF),
    Color(0xFF92A3FD),
  ];
  // endregion

  // region Success Screen

  static const Color successScreenBackgroundColor = Color(0xFFFFFFFF);
  static const Color successScreenTitleColor = Color(0xFF3F414E);
  static const Color successScreenSubtitleColor = Color(0xFFA1A4B2);
  static const Color successScreenButtonColor = Color(0xFF8E97FD);
  static const Color successScreenButtonTextColor = Color(0xFFFFFFFF);

  // endregion

  // region Habit Details
  static const Color habitDetailScreenEditTextColor = Color(0xFFD1DAFF);
  // endregion

}