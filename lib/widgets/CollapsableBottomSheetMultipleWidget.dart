import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';

class CollapsableBottomSheetMultipleWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String buttonText;
  final VoidCallback onPressed;
  final ScrollController scrollController;
  const CollapsableBottomSheetMultipleWidget({super.key, required this.title, required this.children, required this.buttonText, required this.onPressed, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 60.0,
                height: 6.0,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            ),

            const SizedBox(height: 16.0),

            Expanded(
              flex: 2,
              child: Text(
                title,
                style: context.general.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.collapsableBottomSheetTitleColor
                ),
              ),
            ),

            Expanded(
              flex: 26,
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: children,
                )
              ),
            ),

            const Spacer(),

            Expanded(
              flex: 2,
              child: StadiumSideBlueButton(
                  onPressed: onPressed,
                  text: buttonText
              ),
            ),
          ],
        ),
      ),
    );
  }
}
