import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../constants/color_constants.dart';
import '../constants/icon_constants.dart';

class BackButtonWithBorder extends StatelessWidget {
  final VoidCallback onPressed;
  const BackButtonWithBorder({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: context.sized.dynamicWidth(0.12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorConstants.backButtonBorderColor,
              width: 1.0,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
            shape: WidgetStateProperty.all(const CircleBorder()),
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(ColorConstants.transparent),
            elevation: WidgetStateProperty.all(0),
            overlayColor: WidgetStateProperty.all(ColorConstants.transparent),
            splashFactory: NoSplash.splashFactory,
          ),
          child: const Icon(
            IconConstants.arrowBack,
            color: ColorConstants.backButtonIconColor,
          ),
        ),
      ],
    );
  }
}
