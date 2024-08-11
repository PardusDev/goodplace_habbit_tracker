import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/icon_constants.dart';
import '../constants/color_constants.dart';
import 'CustomPainters.dart';

class CircularButtonGappedBorder extends StatelessWidget {
  final Color buttonBackground;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final double iconSize;

  final Color quarterBorderColor;
  final double quarterBorderWidth;
  final double quarterBorderGap;

  final Color fullBorderColor;
  final double fullBorderWidth;
  final double fullBorderGap;

  const CircularButtonGappedBorder({super.key, required this.buttonBackground, required this.onPressed, required this.quarterBorderColor, required this.quarterBorderWidth, required this.fullBorderColor, required this.fullBorderWidth, required this.padding, required this.quarterBorderGap, required this.fullBorderGap, this.iconSize = 24});

  @override
  Widget build(BuildContext context) {
    // Calculate the button size
    final buttonSize = padding.horizontal + padding.vertical - iconSize;

    // Calculate the custom paint size
    final Size quarterBorderSize = Size(
      quarterBorderGap + buttonSize,
      quarterBorderGap + buttonSize,
    );
    final Size fullBorderSize = Size(
      fullBorderGap + buttonSize,
      fullBorderGap + buttonSize,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: quarterBorderSize,
          painter: QuarterBorderPainter(
            borderColor: quarterBorderColor,
            strokeWidth: quarterBorderWidth,
          ),
        ),
        CustomPaint(
          size: fullBorderSize,
          painter: FullBorderPainter(
            borderColor: fullBorderColor,
            strokeWidth: fullBorderWidth,
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(0)
          ),
          child: Ink(
            padding: padding,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: ColorConstants.continueButtonColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(
                IconConstants.continueButtonIcon,
                color: ColorConstants.continueButtonIconColor,
                size: iconSize,
              )
            ),
          ),
      ],
    );
  }
}