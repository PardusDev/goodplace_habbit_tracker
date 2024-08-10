import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';

class OutlinedButtonWithImage extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String imagePath;
  const OutlinedButtonWithImage({super.key, required this.onPressed, required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        splashFactory: NoSplash.splashFactory,
        highlightColor: ColorConstants.transparent,
        child: Container(
          width: double.infinity,
          height: context.sized.dynamicHeight(0.06),
          decoration: BoxDecoration(
            color: ColorConstants.outlinedButtonColor,
            border: Border.all(color: ColorConstants.outlinedButtonBorderColor),
            borderRadius: BorderRadius.circular(context.sized.dynamicHeight(0.06)),
          ),
          child: Center(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: context.padding.onlyLeftMedium,
                    child: Image.asset(
                        imagePath,
                        width: context.sized.dynamicWidth(0.06)
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      text.toUpperCase(),
                      style: context.general.textTheme.labelMedium!.copyWith(
                          color: ColorConstants.outlinedButtonTextColor,
                          fontWeight: FontWeight.w600
                      )
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
