import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/lottie_constants.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../constants/string_constants.dart';
import '../init/navigation/navigation_service.dart';
import 'StadiumSideBlueButton.dart';

class SuccessSplashBox extends StatelessWidget {
  const SuccessSplashBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.sized.dynamicWidth(0.9),
        height: context.sized.dynamicHeight(0.7),
        decoration: BoxDecoration(
          borderRadius: context.border.lowBorderRadius,
          color: ColorConstants.successScreenBackgroundColor,
          boxShadow: const [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 2,
              blurRadius: 30,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: context.padding.normal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              Expanded(
                flex: 1,
                child: Text(
                  StringConstants.successScreenTitle,
                  style: context.general.textTheme.headlineLarge?.copyWith(
                    color: ColorConstants.successScreenTitleColor,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),

              const Spacer(),

              Expanded(
                flex: 8,
                child: Lottie.asset(
                  LottieConstants.successLottie,
                )
              ),

              const Spacer(flex: 2,),

              Expanded(
                flex: 1,
                child: Text(
                  StringConstants.successScreenSubtitleRandom,
                  textAlign: TextAlign.center,
                  style: context.general.textTheme.headlineSmall?.copyWith(
                    color: ColorConstants.successScreenSubtitleColor,
                    fontWeight: FontWeight.w400,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),

              const Spacer(flex: 2,),

              Expanded(
                flex: 2,
                child: StadiumSideBlueButton(
                    onPressed: () {
                      NavigationService.instance.navigateToBack();
                    },
                    text: StringConstants.successScreenButton
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
