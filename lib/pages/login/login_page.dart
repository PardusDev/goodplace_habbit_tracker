import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLinePasswordInputField.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';

import '../../constants/string_constants.dart';
import '../../widgets/BackButtonWithBorder.dart';
import '../../widgets/OneLineInputField.dart';
import '../../widgets/OutlinedButtonWithImage.dart';
import '../../widgets/TappableText.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    child: Text(StringConstants.loginScreenTitle, style: context.general.textTheme.headlineMedium!.copyWith(
                        color: ColorConstants.loginScreenTitleColor,
                        fontWeight: FontWeight.w700
                    ),),
                  ),
                  // */*/*/* Title End */*/*/*

                  const Spacer(flex: 8,),

                  // */*/*/* Other Login Options */*/*/*
                  Flexible(
                    flex: 4,
                    child: OutlinedButtonWithImage(
                      onPressed: () {},
                      text: StringConstants.loginWithGoogle,
                      imagePath: ImageConstants.googleLogo,
                    ),
                  ),
                  // */*/*/* Other Login Options End */*/*/*

                  const Spacer(flex: 2),

                  // */*/*/* OR TEXT */*/*/*
                  Expanded(
                    flex: 4,
                    child: Text(StringConstants.loginScreenOrText, style: context.general.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.loginScreenOrTextColor
                    ),),
                  ),
                  // */*/*/* OR TEXT End */*/*/*

                  // */*/*/* Form */*/*/*
                  const OneLineInputField(hintText: StringConstants.loginScreenEmailHint, obscureText: false,),

                  const Spacer(),

                  // TODO: If obscureText property is true, password visibility icon will be added
                  const OneLinePasswordInputField(hintText: StringConstants.loginScreenPasswordHint, obscureText: true, ),
                  // */*/*/* Form End */*/*/*

                  const Spacer(flex: 4,),

                  // */*/*/* Login Button */*/*/*
                  Flexible(
                    flex: 4,
                    child: StadiumSideBlueButton(
                      onPressed: () {},
                      text: StringConstants.loginScreenLoginButton,
                    ),
                  ),
                  // */*/*/* Login Button End */*/*/*

                  const Spacer(),

                  // */*/*/* Forgot Password */*/*/*
                  Flexible(
                    flex: 2,
                    child: TappableText(
                      onPressed: () {},
                      text: StringConstants.loginScreenForgotPassword,
                      textStyle: context.general.textTheme.titleSmall!.copyWith(
                        color: ColorConstants.loginScreenForgotPasswordTextColor,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                  // */*/*/* Forgot Password End */*/*/*

                  const Spacer(flex: 14),

                  // */*/*/* Sign Up */*/*/*
                  Flexible(
                    flex: 2,
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: StringConstants.dontHaveAnAccount.toUpperCase(),
                            style: context.general.textTheme.labelLarge!.copyWith(
                                color: ColorConstants.loginScreenOrTextColor,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                          // TODO: SIGN UP text little bit different from the other
                          WidgetSpan(child: TappableText(
                              onPressed: () {},
                              text: StringConstants.signUp.toUpperCase(),
                              textStyle: context.general.textTheme.labelLarge!.copyWith(
                                  color: ColorConstants.primaryColor,
                                  fontWeight: FontWeight.w500
                              )
                          ))
                        ]
                    ),
                  ),
                  ),
                  // */*/*/* Sign Up End */*/*/*

                  const Spacer(),
                ]
              ),
            ),
            // TODO: Add background shapes.
          ],
        ),
      ),
    );
  }
}
