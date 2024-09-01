import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../widgets/BackButtonWithBorder.dart';
import 'forgot_password_view_model.dart';

class ForgotPasswordPage2 extends StatelessWidget {
  const ForgotPasswordPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.backgroundColor,
      body: Padding(
        padding: context.padding.normal,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const Spacer(flex: 4,),

              Text(
                "We have sent you an email with a link to reset your password. 🛡\nPlease check spam ️folder.",
                style: context.general.textTheme.headlineSmall!.copyWith(
                    color: ColorConstants.secondaryColor,
                    fontWeight: FontWeight.bold
                ),
              ),

              const Spacer(flex: 5,),

              Consumer<ForgotPasswordViewModel>(
                builder: (context, viewModel, child) {
                  return StadiumSideBlueButton(
                      onPressed: () {
                        viewModel.navigateToLogin();
                      },
                      text: "Go to the Login"
                  );
                }
              ),

              context.sized.emptySizedHeightBoxLow3x,
            ],
          ),
        ),
      )
    );
  }
}
