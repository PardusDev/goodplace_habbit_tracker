import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class StadiumSideIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final Color backgroundColor;
  const StadiumSideIconButton({super.key, required this.onPressed, required this.backgroundColor, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: context.sized.dynamicHeight(0.06),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
        child: icon,
      ),
    );
  }
}
