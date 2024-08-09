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
                  //region */*/*/* Back Button */*/*/*
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
                  //endregion */*/*/* Back Button End */*/*/*

                  const Spacer(),

                  //region */*/*/* Title */*/*/*
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
                  //endregion */*/*/* Title End */*/*/*

                  const Spacer(flex: 8,),

                  //region */*/*/* Other Login Options */*/*/*
                  Flexible(
                    flex: 6,
                    child: Consumer<RegisterPageViewModel>(
                      builder: (context, viewModel, child) {
                        return OutlinedButtonWithImage(
                          onPressed: () {
                            viewModel.continueWithGoogle();
                          },
                          text: StringConstants.loginWithGoogle,
                          imagePath: ImageConstants.googleLogo,
                        );
                      }
                    ),
                  ),
                  //endregion */*/*/* Other Login Options End */*/*/*

                  const Spacer(flex: 2,),

                  //region */*/*/ Or Text */*/*/*
                  Expanded(
                    flex: 4,
                    child: Text(StringConstants.registerScreenOrText, style: context.general.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: ColorConstants.registerScreenOrTextColor
                    ),),
                  ),
                  //endregion */*/*/ Or Text End */*/*/*

                  //region */*/*/ Form */*/*/*
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
                  //endregion */*/*/ Form End */*/*/*

                  const Spacer(flex: 4,),

                  //region */*/*/ Privacy Policy */*/*/*
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
                  //endregion */*/*/ Privacy Policy End */*/*/*

                  //region */*/*/ General Error Text */*/*/*
                  Consumer<RegisterPageViewModel>(
                      builder: (context, viewModel, child) {
                        return Visibility(
                          visible: viewModel.generalErrorText.isNotEmpty,
                          child: Flexible(
                              flex: 2,
                              child: Text(
                                viewModel.generalErrorText,
                                style: context.general.textTheme.titleSmall!.copyWith(
                                    color: ColorConstants.loginScreenErrorTextColor,
                                    fontWeight: FontWeight.w500
                                ),
                              )
                          ),
                        );
                      }
                  ),
                  //endregion */*/*/ General Error Text End */*/*/*

                  const Spacer(flex: 14,),

                  //region */*/*/ GET STARTED BUTTON */*/*/*
                  Flexible(
                    flex: 6,
                    child: Consumer<RegisterPageViewModel>(
                      builder: (context, viewModel, child) {
                        return StadiumSideBlueButton(
                          onPressed: () {
                            viewModel.register();
                          },
                          text: StringConstants.registerScreenGetStartedButton,
                        );
                      }
                    ),
                  ),
                  //endregion */*/*/ GET STARTED BUTTON End */*/*/*

                  const Spacer(),

                  //region */*/*/ Already have an account? */*/*/*
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
                  //endregion */*/*/ Already have an account? End */*/*/*


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
