import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/widgets/StadiumSideIconButton.dart';

import '../constants/color_constants.dart';

class StadiumSideBlueIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  const StadiumSideBlueIconButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return StadiumSideIconButton(onPressed: onPressed, icon: icon, backgroundColor: ColorConstants.buttonBlueBackground);
  }
}
