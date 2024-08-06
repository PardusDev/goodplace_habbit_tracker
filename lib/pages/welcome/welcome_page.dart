import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

import '../../constants/string_constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.welcomeScreenBackgroundColor,
      body: Padding(
        padding: context.padding.normal,
        child: Stack(
          children: [
            Align(alignment: Alignment.bottomCenter,child: Image.asset("assets/images/welcome_background.png")),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                // */*/*/* Title */*/*/*
                Expanded(
                  child: Text(
                    StringConstants.welcomeScreenStrongTitle,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: ColorConstants.welcomeScreenTitleTextColor,
                          fontWeight: FontWeight.w500
                        ),
                  ),
                ),
                context.sized.emptySizedHeightBoxLow,
                Expanded(
                  child: Text(
                    StringConstants.welcomeScreenTitle,
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ColorConstants.welcomeScreenTitleTextColor,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                // */*/*/* Title End */*/*/*
                context.sized.emptySizedHeightBoxNormal,
                // */*/*/* Subtitle */*/*/*
                Text(
                  'A habit tracker app that helps you build good habits and break bad ones.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: ColorConstants.welcomeScreenSubtitleTextColor,
                    fontWeight: FontWeight.w300
                  ),
                ),
                // */*/*/* Subtitle End */*/*/*

                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
