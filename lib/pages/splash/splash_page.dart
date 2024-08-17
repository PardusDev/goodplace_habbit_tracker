import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/pages/splash/splash_page_view_model.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/image_constants.dart';
import '../../constants/string_constants.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashPageViewModel(),
      builder: (context, child) {
        final viewModel = Provider.of<SplashPageViewModel>(context, listen: false);

        return Scaffold(
          backgroundColor: ColorConstants.backgroundColor,
          body: Stack(
            children: [
              Image.asset(
                width: context.sized.dynamicWidth(1),
                height: context.sized.dynamicHeight(1),
                ImageConstants.splashPageBg,
                fit: BoxFit.fill,
              ),
              Center(
                child: DefaultTextStyle(
                  style: context.general.textTheme.headlineMedium!.copyWith(
                    color: ColorConstants.secondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(StringConstants.appName),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
