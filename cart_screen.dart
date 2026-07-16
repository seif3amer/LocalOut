import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';
import 'package:dotted_line/dotted_line.dart'; // تأكد من إضافة البكج في الـ pubspec.yaml

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          "Cart",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // كارت المنتج الأول
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(164, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "images/Tshirt.png",
                          width: 85,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Men's Tie-Dye T-Shirt\nNike Sportswear",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "L.E 250",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.remove, color: Colors.grey, size: 18),
                                        onPressed: () {
                                          setState(() {
                                            if (_quantity > 1) _quantity--;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(color: AppColors.tealGray, shape: BoxShape.circle),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
                                        onPressed: () {
                                          setState(() {
                                            _quantity++;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 34,
                                    decoration: const BoxDecoration(
                                      color: AppColors.tealGray,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                                    ),
                                    child: const Center(
                                      child: Text('XL', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {},
                                    icon: SvgPicture.asset("icons/trash.svg", width: 24, height: 24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // كارت المنتج الثاني
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(164, 255, 255, 255),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "images/Tshirt.png",
                          width: 85,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Men's Tie-Dye T-Shirt\nNike Sportswear",
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black, height: 1.3),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  "L.E 250",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                                      ),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.remove, color: Colors.grey, size: 18),
                                        onPressed: () {
                                          setState(() {
                                            if (_quantity > 1) _quantity--;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text('$_quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                                    const SizedBox(width: 16),
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: const BoxDecoration(color: AppColors.tealGray, shape: BoxShape.circle),
                                      child: IconButton(
                                        padding: EdgeInsets.zero,
                                        icon: const Icon(Icons.keyboard_arrow_up, color: Colors.white, size: 24),
                                        onPressed: () {
                                          setState(() {
                                            _quantity++;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: 32,
                                    height: 34,
                                    decoration: const BoxDecoration(
                                      color: AppColors.tealGray,
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                                    ),
                                    child: const Center(
                                      child: Text('XL', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {},
                                    icon: SvgPicture.asset("icons/trash.svg", width: 24, height: 24),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // ------ كارت الـ Order Info بالحافة المنقطة المايلة فوق ------
              DottedTopCard(
                radius: 24,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Order Info",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Subtotal", style: TextStyle(fontSize: 15, color: Colors.grey[500])),
                          const Text("L.E 700", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Shipping cost", style: TextStyle(fontSize: 15, color: Colors.grey[500])),
                          const Text("L.E 100", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      DottedLine(
                        direction: Axis.horizontal,
                        lineLength: double.infinity,
                        lineThickness: 1.5,
                        dashLength: 4.0,
                        dashColor: Colors.grey[300]!,
                        dashGapLength: 4.0,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Total Cost", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          const Text("L.E 800", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // ------ زرار الـ Check-Out ------
              Container(
                color: const Color.fromARGB(164, 255, 255, 255),
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24, top: 8),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tealGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Check-Out",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== Widget الكارت بالحافة المنقطة المايلة فوق ====================

class DottedTopCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final Color backgroundColor;
  final Color dotColor;

  const DottedTopCard({
    super.key,
    required this.child,
    this.radius = 24,
    this.backgroundColor = const Color.fromARGB(164, 255, 255, 255),
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

    // مسار بيتبع: منحنى شمال -> خط مستقيم في النص -> منحنى يمين
    final path = Path();
    path.moveTo(0, radius);
    path.arcToPoint(
      Offset(radius, 0),
      radius: Radius.circular(radius),
      clockwise: true,
    );
    path.lineTo(size.width - radius, 0);
    path.arcToPoint(
      Offset(size.width, radius),
      radius: Radius.circular(radius),
      clockwise: true,
    );

    _drawDashedPath(canvas, path, paint);
  }

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