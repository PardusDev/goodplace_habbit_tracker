import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:goodplace_habbit_tracker/pages/login/login_page_view_model.dart';
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
    final LoginPageViewModel viewModel = LoginPageViewModel();
    viewModel.setContext(context);

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
                          viewModel.navigateToBack();
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
                      onPressed: () {
                        viewModel.loginWithGoogle(context);
                      },
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
                  OneLineInputField(
                    hintText: StringConstants.loginScreenEmailHint,
                    obscureText: false,
                    controller: viewModel.emailController,
                  ),

                  const Spacer(),

                  // TODO: If obscureText property is true, password visibility icon will be added
                  OneLinePasswordInputField(
                    hintText: StringConstants.loginScreenPasswordHint,
                    obscureText: true,
                    controller: viewModel.passwordController,
                  ),
                  // */*/*/* Form End */*/*/*

                  const Spacer(flex: 4,),

                  // */*/*/* Login Button */*/*/*
                  Flexible(
                    flex: 4,
                    child: StadiumSideBlueButton(
                      onPressed: () {
                        viewModel.login(context);
                      },
                      text: StringConstants.loginScreenLoginButton,
                    ),
                  ),
                  // */*/*/* Login Button End */*/*/*

                  const Spacer(),

                  // */*/*/* Forgot Password */*/*/*
                  Flexible(
                    flex: 2,
                    child: TappableText(
                      onPressed: () {
                        viewModel.navigateToForgotPassword();
                      },
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.dontHaveAnAccount.toUpperCase(),
                          style: context.general.textTheme.labelLarge!.copyWith(
                              color: ColorConstants.loginScreenOrTextColor,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        TappableText(
                            onPressed: () {
                              viewModel.navigateToRegister();
                            },
                            text: StringConstants.signUp.toUpperCase(),
                            textStyle: context.general.textTheme.labelLarge!.copyWith(
                                color: ColorConstants.primaryColor,
                                fontWeight: FontWeight.w500
                            )
                        )
                      ],
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
