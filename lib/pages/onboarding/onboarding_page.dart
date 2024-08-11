import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/CircularButtonGappedBorder.dart';
import 'package:provider/provider.dart';

import '../../constants/color_constants.dart';
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
          return CircularButtonGappedBorder(
            buttonBackground: ColorConstants.primaryColor,
            onPressed: viewModel.nextPage,
            padding: const EdgeInsets.all(24),
            quarterBorderColor: ColorConstants.primaryColor,
            quarterBorderWidth: 3,
            quarterBorderGap: 14,
            fullBorderColor: ColorConstants.secondaryColor,
            fullBorderWidth: 0.05,
            fullBorderGap: 14,
          );
        }
      ),
    );
  }
}

