import 'package:flutter/material.dart';

Widget RightTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
  const Offset begin = Offset(1.0, 0.0);
  const Offset end = Offset.zero;
  const Curve curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}
