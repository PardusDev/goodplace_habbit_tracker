import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';
import 'package:kartal/kartal.dart';

import '../../../constants/string_constants.dart';

class NoNetworkPage extends StatelessWidget {
  const NoNetworkPage({super.key});

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
              Image.asset('assets/images/no_network.png'),
              Text(StringConstants.noNetwork, style: context.general.textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w500,
              ),),
              context.sized.emptySizedHeightBoxLow3x,
              Text(StringConstants.noNetworkSub, style: context.general.textTheme.titleMedium,),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
