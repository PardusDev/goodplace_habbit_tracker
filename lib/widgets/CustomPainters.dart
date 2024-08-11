import 'package:flutter/material.dart';

class QuarterBorderPainter extends CustomPainter {
  final Color borderColor;
  final double strokeWidth;

  QuarterBorderPainter({required this.borderColor, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
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
