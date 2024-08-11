import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:goodplace_habbit_tracker/constants/image_constants.dart';
import 'package:kartal/kartal.dart';

import '../constants/string_constants.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: Padding(
          padding: context.padding.medium,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(ImageConstants.notFound),
              Text(StringConstants.notFound, style: context.general.textTheme.headlineMedium,),
              context.sized.emptySizedHeightBoxLow3x,
              Text(StringConstants.notFoundSub, style: context.general.textTheme.titleMedium,),
              const Spacer(),
            ],
          ),
        ),
      )
    );
  }
}
