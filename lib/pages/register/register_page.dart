import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputFieldValidable.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';

import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';
import '../../widgets/BackButtonWithBorder.dart';
import '../../widgets/OneLinePasswordInputFieldValidable.dart';
import '../../widgets/OutlinedButtonWithImage.dart';
import '../../widgets/TappableText.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: context.padding.normal,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        // TODO: IconButton will change according to the design
                        child: BackButtonWithBorder(
                          onPressed: () {
                            print("Back button pressed");
                          },
                        ),
                    ),
                  ),

                  const Spacer(),

                  // */*/*/* Title */*/*/*
                  Expanded(
                    flex: 4,
                    child: Text(
                      StringConstants.registerScreenTitle,
                      style: context.general.textTheme.headlineMedium?.copyWith(
                        color: ColorConstants.registerScreenTitleColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  // */*/*/* Title End */*/*/*

                  const Spacer(flex: 8,),

                  // */*/*/* Other Login Options */*/*/*
                  Flexible(
                    flex: 6,
                    child: OutlinedButtonWithImage(
                      onPressed: () {},
                      text: StringConstants.loginWithGoogle,
                      imagePath: ImageConstants.googleLogo,
                    ),
                  ),
                  // */*/*/* Other Login Options End */*/*/*

                  const Spacer(flex: 2,),

                  // */*/*/ Or Text */*/*/*
                  Expanded(
                    flex: 4,
                    child: Text(StringConstants.registerScreenOrText, style: context.general.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.registerScreenOrTextColor
                    ),),
                  ),
                  // */*/*/ Or Text End */*/*/*

                  // */*/*/ Form */*/*/*
                  OneLineInputFieldValidable(
                    hintText: StringConstants.registerScreenEmailHint,
                    validator: (text) {
                      // TODO: This method will change according to state management
                      if (text.isEmpty) {
                        return false;
                      }
                      else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(text)) {
                        return false;
                      }
                      else if (!RegExp(r'^\S+$').hasMatch(text)) {
                        return false;
                      }
                      else {
                        return true;
                      }
                    }
                  ),

                  const Spacer(),

                  OneLinePasswordInputFieldValidable(
                    hintText: StringConstants.registerScreenPasswordHint,
                    validator: (passwd) {
                      if (passwd.isEmpty) {
                        return false;
                      }
                      else if (passwd.length < 8) {
                        return false;
                      }
                      // Password contain space
                      else if (!RegExp(r'^\S+$').hasMatch(passwd)) {
                        return false;
                      }
                      // Password should contain at least one letter
                      else if (!RegExp(r'[a-zA-Z]').hasMatch(passwd)) {
                        return false;
                      }
                      // Password should contain at least one digit
                      else if (!RegExp(r'\d').hasMatch(passwd)) {
                        return false;
                      }
                      else {
                        return true;
                      }
                    },
                    // TODO: controller will change.
                    controller: TextEditingController(),
                  ),

                  const Spacer(),

                  OneLinePasswordInputFieldValidable(
                    hintText: StringConstants.registerScreenRetypePasswordHint,
                    validator: (passwd) {
                      // TODO: Check if the password is equal to the previous password
                        return true;
                    },
                    // TODO: controller will change.
                    controller: TextEditingController(),
                  ),
                  // */*/*/ Form End */*/*/*

                  const Spacer(flex: 4,),

                  // */*/*/ Privacy Policy */*/*/*
                  Flexible(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.registerScreenPrivacyPolicyText,
                          style: context.general.textTheme.labelLarge!.copyWith(
                            color: ColorConstants.registerScreenPrivacyPolicyTextColor,
                          ),),
                        TappableText(
                          onPressed: () {},
                          text: StringConstants.registerScreenPrivacyPolicyLink,
                          textStyle: context.general.textTheme.labelLarge!.copyWith(
                            color: ColorConstants.registerScreenPrivacyPolicyLinkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // */*/*/ Privacy Policy End */*/*/*

                  const Spacer(flex: 14,),

                  // */*/*/ GET STARTED BUTTON */*/*/*
                  Flexible(
                    flex: 6,
                    child: StadiumSideBlueButton(
                      onPressed: () {},
                      text: StringConstants.registerScreenGetStartedButton,
                    ),
                  ),
                  // */*/*/ GET STARTED BUTTON End */*/*/*

                  const Spacer(),

                  // */*/*/ Already have an account? */*/*/*
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.registerScreenAlreadyHaveAnAccount,
                          style: context.general.textTheme.labelLarge!.copyWith(
                            color: ColorConstants.registerScreenAlreadyHaveAnAccountColor,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        TappableText(
                          onPressed: () {},
                          text: StringConstants.registerScreenSignIn,
                          textStyle: context.general.textTheme.labelLarge!.copyWith(
                            color: ColorConstants.registerScreenSignInColor,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),


                  const Spacer()
                ],
              ),
            ),
            // TODO: Add background shapes.
          ],
        ),
      ),
    );
  }
}
