import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideBlueButton.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';

class CollapsableBottomSheetMultipleWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final String buttonText;
  final VoidCallback onPressed;
  const CollapsableBottomSheetMultipleWidget({super.key, required this.title, required this.children, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: context.padding.normal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: context.general.textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ColorConstants.collapsableBottomSheetTitleColor
                ),
              ),
            ),

            Expanded(
              flex: 14,
              child: SingleChildScrollView(
                child: Column(
                  children: children,
                )
              ),
            ),

            const Spacer(),

            Expanded(
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
