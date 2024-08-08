import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:goodplace_habbit_tracker/pages/login/login_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLinePasswordInputField.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

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
            Image.asset(
                width: context.sized.dynamicWidth(1),
                ImageConstants.authPageShapeBg
            ),
            Padding(
              padding: context.padding.normal,
              child: Column(
                children: [

                  // */*/*/* Back Button */*/*/*
                  Expanded(
                    flex: 8,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Consumer<LoginPageViewModel>(
                        builder: (context, viewModel, child) {
                          return BackButtonWithBorder(
                            onPressed: () {
                              viewModel.navigateToBack();
                            },
                          );
                        }
                      ),
                    ),
                  ),
                  // */*/*/* Back Button End */*/*/*

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
                    flex: 8,
                    child: Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return OutlinedButtonWithImage(
                          onPressed: () {
                            viewModel.loginWithGoogle(context);
                          },
                          text: StringConstants.loginWithGoogle,
                          imagePath: ImageConstants.googleLogo,
                        );
                      }
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
                  Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return OneLineInputField(
                          hintText: StringConstants.loginScreenEmailHint,
                          obscureText: false,
                          controller: viewModel.emailController,
                        );
                      }
                  ),

                  const Spacer(),

                  Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return OneLinePasswordInputField(
                          hintText: StringConstants.loginScreenPasswordHint,
                          obscureText: true,
                          controller: viewModel.passwordController,
                          onChanged: viewModel.onPasswordChanged,
                        );
                      }
                  ),
                  // */*/*/* Form End */*/*/*

                  const Spacer(),

                  // */*/*/* Error Text */*/*/*
                  Consumer<LoginPageViewModel>(
                    builder: (context, viewModel, child) {
                      return Visibility(
                        visible: viewModel.errorText.isNotEmpty,
                        child: Flexible(
                          flex: 2,
                          child: Text(
                            viewModel.errorText,
                            style: context.general.textTheme.titleSmall!.copyWith(
                                color: ColorConstants.loginScreenErrorTextColor,
                                fontWeight: FontWeight.w500
                            ),
                          )
                        ),
                      );
                    }
                  ),
                  // */*/*/* Error Text End */*/*/*

                  const Spacer(flex: 4,),

                  // */*/*/* Login Button */*/*/*
                  Flexible(
                    flex: 6,
                    child: Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return StadiumSideBlueButton(
                          onPressed: () {
                            viewModel.login(context);
                          },
                          text: StringConstants.loginScreenLoginButton,
                        );
                      }
                    ),
                  ),

                  // */*/*/* Login Button End */*/*/*

                  const Spacer(),

                  // */*/*/* Forgot Password */*/*/*
                  Flexible(
                    flex: 2,
                    child: Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return TappableText(
                            onPressed: () {
                              viewModel.navigateToForgotPassword();
                            },
                            text: StringConstants.loginScreenForgotPassword,
                            textStyle: context.general.textTheme.titleSmall!.copyWith(
                                color: ColorConstants.loginScreenForgotPasswordTextColor,
                                fontWeight: FontWeight.w500
                            )
                        );
                      }
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
                        Consumer<LoginPageViewModel>(
                            builder: (context, viewModel, child) {
                              return TappableText(
                                  onPressed: () {
                                    viewModel.navigateToRegister();
                                  },
                                  text: StringConstants.signUp.toUpperCase(),
                                  textStyle: context.general.textTheme.labelLarge!.copyWith(
                                      color: ColorConstants.primaryColor,
                                      fontWeight: FontWeight.w500
                                  )
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  // */*/*/* Sign Up End */*/*/*

                  const Spacer(),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
