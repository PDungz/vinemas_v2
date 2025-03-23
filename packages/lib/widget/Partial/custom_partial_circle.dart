import 'dart:math';

import 'package:flutter/material.dart';

class CustomPartialCircle extends StatelessWidget {
  final double radius;
  final Color color;
  final bool isVertical; // true = dọc, false = ngang
  final bool isLeftOrTop; // true = trái/trên, false = phải/dưới
  final double ratio; // 1 = full, 0.5 = half, 0.25 = quarter

  const CustomPartialCircle({
    super.key,
    required this.radius,
    required this.color,
    this.isVertical = false,
    this.isLeftOrTop = true,
    this.ratio = 1, // Mặc định là hình tròn đầy đủ
  });

  @override
  Widget build(BuildContext context) {
    double width, height;

    if (ratio == 1) {
      width = height = radius * 2;
    } else if (ratio == 0.5) {
      width = isVertical ? radius : radius * 2;
      height = isVertical ? radius * 2 : radius;
    } else if (ratio == 0.25) {
      width = height = radius;
    } else {
      width = height = radius * 2; // Trường hợp khác, giữ nguyên full size
    }

    return CustomPaint(
      size: Size(width, height),
      painter: _PartialCirclePainter(
        color: color,
        radius: radius,
        isVertical: isVertical,
        isLeftOrTop: isLeftOrTop,
        ratio: ratio.clamp(0.0, 1.0),
      ),
    );
  }
}

class _PartialCirclePainter extends CustomPainter {
  final Color color;
  final double radius;
  final bool isVertical;
  final bool isLeftOrTop;
  final double ratio;

  _PartialCirclePainter({
    required this.color,
    required this.radius,
    required this.isVertical,
    required this.isLeftOrTop,
    required this.ratio,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();

    double startAngle;
    double sweepAngle = ratio * 2 * pi;

    Offset center;
    if (ratio == 1) {
      center = Offset(radius, radius);
    } else if (ratio == 0.5) {
      center = isVertical
          ? Offset(radius / 2, radius) // Dọc: căn giữa theo chiều ngang
          : Offset(radius, radius / 2); // Ngang: căn giữa theo chiều dọc
    } else if (ratio == 0.25) {
      center = Offset(radius / 2, radius / 2);
    } else {
      center = Offset(radius, radius);
    }

    if (isVertical) {
      startAngle = isLeftOrTop ? pi / 2 : -pi / 2;
    } else {
      startAngle = isLeftOrTop ? pi : 0;
    }

    path.addArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
    );

    path.lineTo(center.dx, center.dy);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
