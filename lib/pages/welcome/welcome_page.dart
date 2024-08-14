import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:goodplace_habbit_tracker/pages/welcome/welcome_page_view_model.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideWhiteButton.dart';
import 'package:kartal/kartal.dart';
import 'package:provider/provider.dart';

import '../../constants/string_constants.dart';
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WelcomePageViewModel(),
      child: Scaffold(
        // We need to set resizeToAvoidBottomInset to false to prevent the keyboard from resizing the screen.
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorConstants.welcomeScreenBackgroundColor,
        body: Stack(
          children: [
            Align(alignment: Alignment.bottomCenter,child: Image.asset(ImageConstants.welcomeBackground)),
            Padding(
              padding: context.padding.normal,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(flex: 4),
                  //region */*/*/* Title */*/*/*
                  Expanded(
                    flex: 1,
                    child: Text(
                      StringConstants.welcomeScreenStrongTitle,
                      style: context.general.textTheme.headlineLarge!.copyWith(
                            color: ColorConstants.welcomeScreenTitleTextColor,
                            fontWeight: FontWeight.w500,
                            overflow: TextOverflow.visible,
                          ),
                    ),
                  ),

                  context.sized.emptySizedHeightBoxLow,

                  Expanded(
                    flex: 2,
                    child: Text(
                      StringConstants.welcomeScreenTitle,
                      style: context.general.textTheme.headlineLarge!.copyWith(
                        color: ColorConstants.welcomeScreenTitleTextColor,
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
                  //endregion */*/*/* Title End */*/*/*

                  //region */*/*/* Subtitle */*/*/*
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
                          fontSize: 18,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ),
                  ),
                  //endregion */*/*/* Subtitle End */*/*/*

                  const Spacer(flex: 9),

                  //region */*/*/* Button */*/*/*
                  Consumer<WelcomePageViewModel>(
                    builder: (context, viewModel, child) {
                      return StadiumSideWhiteButton(
                        onPressed: () {
                          viewModel.navigateToLogin();
                        },
                        text: StringConstants.welcomeScreenButton,
                      );
                    }
                  ),
                  //endregion */*/*/* Button End */*/*/*

                  const Spacer(flex: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
