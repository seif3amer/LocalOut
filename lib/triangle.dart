// import 'package:flutter/material.dart';
// import 'package:project/colors.dart';

// class TrianglePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = AppColors.tealGray
//       ..style = PaintingStyle.fill;

//     final path = Path()
//       ..moveTo(size.width / 2, 0)
//       ..quadraticBezierTo(
//         size.width * 0.55,
//         size.height * 0.05,
//         size.width,
//         size.height,
//       )
//       ..lineTo(0, size.height)
//       ..quadraticBezierTo(
//         size.width * 0.45,
//         size.height * 0.05,
//         size.width / 2,
//         0,
//       );

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }

import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.tealGray
      ..style = PaintingStyle.fill;

    const double tipRadius = 8; // كل ما تزودها السن يبقى مدور أكتر

    final path = Path()
      // بداية قبل السن
      ..moveTo(size.width / 1.999- tipRadius, tipRadius)

      // السن المدور
      ..quadraticBezierTo(
        size.width / 2,
        0,
        size.width / 2 + tipRadius,
        tipRadius,
      )

      // الجانب الأيمن
      ..quadraticBezierTo(
        size.width * 0.55,
        size.height * 0.05,
        size.width,
        size.height,
      )

      // القاعدة
      ..lineTo(0, size.height)

      // الجانب الأيسر
      ..quadraticBezierTo(
        size.width * 0.45,
        size.height * 0.05,
        size.width / 2 - tipRadius,
        tipRadius,
      )

      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}