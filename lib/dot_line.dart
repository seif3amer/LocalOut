import 'dart:math';
import 'package:flutter/material.dart';

class DottedTopCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color backgroundColor;
  final Color dotColor;

  const DottedTopCard({
    super.key,
    required this.child,
    this.radius = 24,
    this.backgroundColor = Colors.white,
    this.dotColor = const Color(0xFFBFBFBF),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // جسم الكارت الأبيض بحواف مدورة فوق
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius),
            ),
          ),
          child: child,
        ),
        // الخط المنقط فوق الكارت بيتبع الانحناء
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: CustomPaint(
            size: Size(double.infinity, radius),
            painter: _DottedTopBorderPainter(
              radius: radius,
              color: dotColor,
            ),
          ),
        ),
      ],
    );
  }
}

class _DottedTopBorderPainter extends CustomPainter {
  final double radius;
  final Color color;

  _DottedTopBorderPainter({required this.radius, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // نرسم مسار بيتبع: منحنى شمال -> خط مستقيم في النص -> منحنى يمين
    final path = Path();
    path.moveTo(0, radius); // بداية المنحنى الشمال (تحت)
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(size.width - radius, 0); // الخط المستقيم فوق
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    _drawDashedPath(canvas, path, paint);
  }

  // دالة بترسم أي Path كخط منقط (dash - gap - dash - gap...)
  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    const double dashLength = 4.0;
    const double gapLength = 4.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      bool draw = true;
      while (distance < metric.length) {
        final double length = draw ? dashLength : gapLength;
        final double next = min(distance + length, metric.length);
        if (draw) {
          final extractPath = metric.extractPath(distance, next);
          canvas.drawPath(extractPath, paint);
        }
        distance = next;
        draw = !draw;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DottedTopBorderPainter oldDelegate) => false;
}