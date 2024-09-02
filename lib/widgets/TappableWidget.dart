import 'package:flutter/material.dart';

class TappableWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const TappableWidget({super.key, required this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: child,
    );
  }
}
