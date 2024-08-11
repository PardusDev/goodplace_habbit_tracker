import 'package:flutter/material.dart';
import 'package:goodplace_habbit_tracker/constants/color_constants.dart';

class QuarterBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;

  QuarterBorderPainter({required this.borderColor, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    final paint = Paint()
      ..shader = const LinearGradient(
        colors: ColorConstants.continueButtonColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    const startAngle = 3 * 3.14 / 2;
    const sweepAngle = 3.14 / 2;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FullBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;

  FullBorderPainter({required this.borderColor, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    const startAngle = 3 * 3.14 / 2;
    const sweepAngle = 2 * 3.14;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
