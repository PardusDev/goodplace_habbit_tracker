import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/pages/forgot_password/forgot_password_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/CircularButtonGappedBorder.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/string_constants.dart';
import '../../widgets/BackButtonWithBorder.dart';
import '../../widgets/OneLineInputFieldValidable.dart';

class ForgotPasswordPage1 extends StatelessWidget {
  const ForgotPasswordPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.backgroundColor,
      floatingActionButton: Consumer<ForgotPasswordViewModel>(
        builder: (context, viewModel, child) {
          return CircularButtonGappedBorder(
            buttonBackground: ColorConstants.primaryColor,
            onPressed: () {
              viewModel.navigateToForgotPassword2();
            },
            quarterBorderColor: ColorConstants.transparent,
            quarterBorderWidth: 0,
            quarterBorderGap: -12,
            fullBorderColor: const Color.fromRGBO(161, 164, 178, 0.2),
            fullBorderWidth: 2,
            fullBorderGap: 6.0,
            padding: const EdgeInsets.all(28.0),
          );
        }
      ),
      body: Padding(
        padding: context.padding.normal,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),

              //region */*/*/* Back Button */*/*/*
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Consumer<ForgotPasswordViewModel>(
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

              const Spacer(flex: 4,),

              Text(
                "We need your email to find your account 👇",
                style: context.general.textTheme.headlineSmall!.copyWith(
                  color: ColorConstants.secondaryColor,
                  fontWeight: FontWeight.bold
                ),
              ),

              context.sized.emptySizedHeightBoxLow3x,

              Consumer<ForgotPasswordViewModel>(
                  builder: (context, viewModel, child) {
                    return OneLineInputFieldValidable(
                      hintText: StringConstants.registerScreenEmailHint,
                      onChanged: viewModel.onEmailChanged,
                      controller: viewModel.emailController,
                      isValid: viewModel.isEmailValid,
                    );
                  }
              ),

              context.sized.emptySizedHeightBoxLow,

              Consumer<ForgotPasswordViewModel>(
                  builder: (context, viewModel, child) {
                    return Visibility(
                      visible: viewModel.generalErrorText.isNotEmpty,
                      child: Flexible(
                          flex: 2,
                          child: Center(
                            child: Text(
                              viewModel.generalErrorText,
                              style: context.general.textTheme.titleSmall!.copyWith(
                                color: ColorConstants.loginScreenErrorTextColor,
                                fontWeight: FontWeight.w500,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          )
                      ),
                    );
                  }
              ),

              const Spacer(flex: 8,),
            ],
          ),
        ),
      ),
    );
  }
}
