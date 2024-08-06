import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

import '../../constants/string_constants.dart';
import '../../widgets/StadiumSideButton.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.welcomeScreenBackgroundColor,
      body: Stack(
        children: [
          Align(alignment: Alignment.bottomCenter,child: Image.asset("assets/images/welcome_background.png")),
          Padding(
            padding: context.padding.medium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 4),
                // */*/*/* Title */*/*/*
                Expanded(
                  flex: 1,
                  child: Text(
                    StringConstants.welcomeScreenStrongTitle,
                    style: context.general.textTheme.headlineLarge!.copyWith(
                          color: ColorConstants.welcomeScreenTitleTextColor,
                          fontWeight: FontWeight.w500
                        ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    StringConstants.welcomeScreenTitle,
                    style: context.general.textTheme.headlineLarge!.copyWith(
                      color: ColorConstants.welcomeScreenTitleTextColor,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ),
                // */*/*/* Title End */*/*/*
                // */*/*/* Subtitle */*/*/*
                Expanded(
                  flex: 8,
                  child: SizedBox(
                    width: context.sized.dynamicWidth(0.7),
                    child: Text(
                      textAlign: TextAlign.center,
                      StringConstants.welcomeScreenSubtitle,
                      style: context.general.textTheme.titleMedium!.copyWith(
                        color: ColorConstants.welcomeScreenSubtitleTextColor,
                        fontWeight: FontWeight.w300,
                        fontSize: 18
                      ),
                    ),
                  ),
                ),
                // */*/*/* Subtitle End */*/*/*
                const Spacer(flex: 9),
                StadiumSideButton(
                  onPressed: () {  },
                  text: StringConstants.welcomeScreenButton,
                ),
                const Spacer(flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
