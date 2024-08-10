import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
import '../../constants/image_constants.dart';
import 'onboarding_page_view_model.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Consumer<OnBoardingPageViewModel>(
        builder: (context, viewModel, child) {
          return PageView(
            controller: viewModel.pageController,
            onPageChanged: viewModel.onPageChanged,
            children: viewModel.pages,
          );
        },
      ),
      floatingActionButton: Consumer<OnBoardingPageViewModel>(
        builder: (context, viewModel, child) {
          return GestureDetector(
            onTap: viewModel.nextPage,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.transparent,
              ),
              child: Image.asset(ImageConstants.onboardingButtonAsset),
            ),
          );
        },
      )
    );
  }
}

