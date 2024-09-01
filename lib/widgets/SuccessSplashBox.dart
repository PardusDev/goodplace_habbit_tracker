import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/lottie_constants.dart';
import 'package:kartal/kartal.dart';
import 'package:lottie/lottie.dart';

import '../constants/string_constants.dart';
import '../init/navigation/navigation_service.dart';
import 'StadiumSideBlueButton.dart';

class SuccessSplashBox extends StatefulWidget {
  final VoidCallback onPressed;
  const SuccessSplashBox({super.key, required this.onPressed});

  @override
  State<SuccessSplashBox> createState() => _SuccessSplashBoxState();
}

class _SuccessSplashBoxState extends State<SuccessSplashBox> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.stop();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.sized.dynamicWidth(0.9),
        height: context.sized.dynamicHeight(0.7),
        decoration: BoxDecoration(
          borderRadius: context.border.highBorderRadius,
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
                flex: 2,
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
                  flex: 20,
                  child: Lottie.asset(
                    controller: _controller,
                    LottieConstants.congratulationLottiesRandom,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward().whenComplete(() => _controller.stop());
                    },
                  )
              ),

              const Spacer(flex: 1,),

              Expanded(
                flex: 1,
                child: Text(
                  StringConstants.successScreenSubtitleRandom,
                  textAlign: TextAlign.center,
                  style: context.general.textTheme.titleLarge?.copyWith(
                    color: ColorConstants.successScreenSubtitleColor,
                    fontWeight: FontWeight.w500,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),

              const Spacer(flex: 8,),

              Expanded(
                flex: 3,
                child: StadiumSideBlueButton(
                    onPressed: () {
                      NavigationService.instance.navigateToBack();
                      widget.onPressed();
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
