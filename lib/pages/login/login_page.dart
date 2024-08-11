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

                  //region */*/*/* Back Button */*/*/*
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
                  //endregion */*/*/* Back Button End */*/*/*

                  const Spacer(),

                  //region */*/*/* Title */*/*/*
                  Expanded(
                    flex: 4,
                    child: Text(StringConstants.loginScreenTitle, style: context.general.textTheme.headlineMedium!.copyWith(
                        color: ColorConstants.loginScreenTitleColor,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.visible,
                    ),),
                  ),
                  //endregion */*/*/* Title End */*/*/*

                  const Spacer(flex: 8,),

                  //region */*/*/* Other Login Options */*/*/*
                  Flexible(
                    flex: 8,
                    child: Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return OutlinedButtonWithImage(
                          onPressed: () {
                            viewModel.loginWithGoogle();
                          },
                          text: StringConstants.loginWithGoogle,
                          imagePath: ImageConstants.googleLogo,
                        );
                      }
                    ),
                  ),
                  //endregion */*/*/* Other Login Options End */*/*/*

                  const Spacer(flex: 2),

                  //region */*/*/* OR TEXT */*/*/*
                  Expanded(
                    flex: 4,
                    child: Text(StringConstants.loginScreenOrText, style: context.general.textTheme.labelMedium!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: ColorConstants.loginScreenOrTextColor,
                      overflow: TextOverflow.visible,
                    ),),
                  ),
                  //endregion */*/*/* OR TEXT End */*/*/*

                  //region */*/*/* Form */*/*/*
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
                  //endregion */*/*/* Form End */*/*/*

                  const Spacer(),

                  //region */*/*/* Error Text */*/*/*
                  Consumer<LoginPageViewModel>(
                    builder: (context, viewModel, child) {
                      return Visibility(
                        visible: viewModel.errorText.isNotEmpty,
                        child: Expanded(
                          flex: 2,
                          child: Text(
                            viewModel.errorText,
                            style: context.general.textTheme.titleSmall!.copyWith(
                                color: ColorConstants.loginScreenErrorTextColor,
                                fontWeight: FontWeight.w500,
                            overflow: TextOverflow.visible,
                            ),
                          )
                        ),
                      );
                    }
                  ),
                  //endregion */*/*/* Error Text End */*/*/*

                  const Spacer(flex: 4,),

                  //region */*/*/* Login Button */*/*/*
                  Flexible(
                    flex: 6,
                    child: Consumer<LoginPageViewModel>(
                      builder: (context, viewModel, child) {
                        return StadiumSideBlueButton(
                          onPressed: () {
                            viewModel.login();
                          },
                          text: StringConstants.loginScreenLoginButton,
                        );
                      }
                    ),
                  ),
                  //endregion */*/*/* Login Button End */*/*/*

                  const Spacer(),

                  //region */*/*/* Forgot Password */*/*/*
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
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.visible,
                            )
                        );
                      }
                    ),
                  ),
                  //endregion */*/*/* Forgot Password End */*/*/*

                  const Spacer(flex: 14),

                  //region */*/*/* Sign Up */*/*/*
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          StringConstants.dontHaveAnAccount.toUpperCase(),
                          style: context.general.textTheme.labelLarge!.copyWith(
                              color: ColorConstants.loginScreenOrTextColor,
                              fontWeight: FontWeight.w500,
                              overflow: TextOverflow.visible,
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
                                      fontWeight: FontWeight.w500,
                                      overflow: TextOverflow.visible,
                                  )
                              );
                            }
                        ),
                      ],
                    ),
                  ),
                  //endregion */*/*/* Sign Up End */*/*/*

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
