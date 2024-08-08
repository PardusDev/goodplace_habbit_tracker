import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/string_constants.dart';
import 'package:goodplace_habbit_tracker/pages/register/register_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/OneLineInputFieldValidable.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

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
            Image.asset(
                width: context.sized.dynamicWidth(2),
                ImageConstants.authPageShapeBg
            ),
            Padding(
              padding: context.padding.normal,
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Consumer<RegisterPageViewModel>(
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
                  Consumer<RegisterPageViewModel>(
                    builder: (context, viewModel, child) {
                      return OneLineInputFieldValidable(
                        hintText: StringConstants.registerScreenEmailHint,
                        onChanged: viewModel.onEmailChanged,
                        controller: viewModel.emailController,

                      );
                    }
                  ),

                  Consumer<RegisterPageViewModel>(
                      builder: (context, viewModel, child) {
                        return Visibility(
                          visible: viewModel.emailErrorText.isNotEmpty,
                          child: Flexible(
                              flex: 2,
                              child: Text(
                                viewModel.emailErrorText,
                                style: context.general.textTheme.titleSmall!.copyWith(
                                    color: ColorConstants.loginScreenErrorTextColor,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          ),
                        );
                      }
                  ),

                  const Spacer(),

                  Consumer<RegisterPageViewModel>(
                    builder: (context, viewModel, child) {
                      return OneLinePasswordInputFieldValidable(
                        hintText: StringConstants.registerScreenPasswordHint,
                        onChanged: viewModel.onPasswordChanged,
                        controller: viewModel.passwordController,
                      );
                    }
                  ),

                  Consumer<RegisterPageViewModel>(
                      builder: (context, viewModel, child) {
                        return Visibility(
                          visible: viewModel.passwordErrorText.isNotEmpty,
                          child: Flexible(
                              flex: 2,
                              child: Text(
                                viewModel.passwordErrorText,
                                style: context.general.textTheme.titleSmall!.copyWith(
                                    color: ColorConstants.loginScreenErrorTextColor,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          ),
                        );
                      }
                  ),

                  const Spacer(),

                  Consumer<RegisterPageViewModel>(
                    builder: (context, viewModel, child) {
                      return OneLinePasswordInputFieldValidable(
                        hintText: StringConstants.registerScreenRetypePasswordHint,
                        controller: viewModel.confirmPasswordController,
                        onChanged: viewModel.onConfirmPasswordChanged,
                      );
                    }
                  ),

                  Consumer<RegisterPageViewModel>(
                      builder: (context, viewModel, child) {
                        return Visibility(
                          visible: viewModel.rePasswordErrorText.isNotEmpty,
                          child: Flexible(
                              flex: 2,
                              child: Text(
                                viewModel.rePasswordErrorText,
                                style: context.general.textTheme.titleSmall!.copyWith(
                                    color: ColorConstants.loginScreenErrorTextColor,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          ),
                        );
                      }
                  ),
                  // */*/*/ Form End */*/*/*

                  const Spacer(flex: 4,),

                  // */*/*/ Privacy Policy */*/*/*
                  // TODO: Add a checkbox for privacy policy
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
          ],
        ),
      ),
    );
  }
}
