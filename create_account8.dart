import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HeightSelectionPage extends StatefulWidget {
  const HeightSelectionPage({super.key});

  @override
  State<HeightSelectionPage> createState() => _HeightSelectionPageState();
}

class _HeightSelectionPageState extends State<HeightSelectionPage> {
  static const Color rulerBackground = Color(0xFF635CA8);
  static const Color greyBorder = Color(0xFFD9D9D9);

  static const double minHeight = 130;
  static const double maxHeight = 220;

  double height = 165;

  late final TextEditingController heightController;
  final FocusNode heightFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    heightController = TextEditingController(text: height.round().toString());
  }

  @override
  void dispose() {
    heightController.dispose();
    heightFocusNode.dispose();
    super.dispose();
  }

  // بيتنادى لما اليوزر يكتب رقم في التيكست فيلد بنفسه
  void _onHeightTextChanged(String value) {
    final double? parsed = double.tryParse(value);
    if (parsed == null) return;
    final double clamped = parsed.clamp(minHeight, maxHeight);
    setState(() {
      height = clamped;
    });
  }

  // بيتنادى لما اليوزر يسحب المسطرة
  void _onRulerChanged(double value) {
    setState(() {
      height = value;
      // منحدثش التيكست فيلد وهو لسه فاتح للكتابة عشان مايحصلش قفز في الكيرسر
      if (!heightFocusNode.hasFocus) {
        heightController.text = value.round().toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientTop,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Row(
              children: [
                const Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: SvgPicture.asset("icons/skip.svg"),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          child: SingleChildScrollView(
            // لمنع تعارض سكرول الصفحة مع سحب المسطرة
            physics: const ClampingScrollPhysics(), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 38),
                const Text(
                  'What is your height?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Inter',
                  ),
                ),
                const SizedBox(height: 32),
                const _SubtitleBanner(),
                const SizedBox(height: 32),
                
                // التيكست فيلد والرقم الحالي
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IntrinsicWidth(
                      child: TextField(
                        cursorColor: AppColors.tealGray,
                        cursorWidth: 1.5,
                        controller: heightController,
                        focusNode: heightFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: _onHeightTextChanged,
                        onSubmitted: (value) {
                          // لما يخلص كتابة، ثبّت الرقم بعد الـ clamp في التيكست فيلد
                          heightController.text = height.round().toString();
                          heightController.selection = TextSelection.collapsed(
                            offset: heightController.text.length,
                          );
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 6, left: 2),
                      child: Text(
                        ' cm',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // 🔥 تم التعديل هنا: استخدام SizedBox بارتفاع ثابت لحل المشكلة
                SizedBox(
                  height: 350,
                  child: HeightRulerRow(
                    currentValue: height,
                    minValue: minHeight,
                    maxValue: maxHeight,
                    rulerBackgroundColor: rulerBackground,
                    indicatorColor: AppColors.tealGray,
                    onValueChanged: _onRulerChanged,
                  ),
                ),
                
                const SizedBox(height: 32),
                const HeightPageIndicator(
                  filledCount: 3,
                  hollowIndex: 3,
                  totalDots: 5,
                  activeColor: AppColors.tealGray,
                  inactiveColor: greyBorder,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.tealGray,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SubtitleBanner extends StatelessWidget {
  const _SubtitleBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 79,
      color: const Color(0xFF635CA8),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      alignment: Alignment.center,
      child: const Text(
        'This helps us suggest outfits that fit your body proportions.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontFamily: 'Inter',
        ),
      ),
    );
  }
}

/// الصف اللي بيحتوي على أرقام الجنب + المسطرة الرأسية + المثلث المؤشر.
class HeightRulerRow extends StatelessWidget {
  final double currentValue;
  final double minValue;
  final double maxValue;
  final Color rulerBackgroundColor;
  final Color indicatorColor;
  final ValueChanged<double> onValueChanged;

  const HeightRulerRow({
    super.key,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    required this.rulerBackgroundColor,
    required this.indicatorColor,
    required this.onValueChanged,
  });

  static const double pixelsPerUnit = 14;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double rulerLength = constraints.maxHeight;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeightSideLabels(
              currentValue: currentValue,
              height: rulerLength,
              pixelsPerUnit: pixelsPerUnit,
            ),
            const SizedBox(width: 12),
            HeightRuler(
              initialValue: currentValue,
              minValue: minValue,
              maxValue: maxValue,
              rulerBackgroundColor: rulerBackgroundColor,
              indicatorColor: indicatorColor,
              pixelsPerUnit: pixelsPerUnit,
              onValueChanged: onValueChanged,
            ),
            const SizedBox(width: 8),
            CustomPaint(
              size: const Size(36, 32),
              painter: _LeftTrianglePainter(color: indicatorColor),
            ),
          ],
        );
      },
    );
  }
}

/// مسطرة رأسية مخصصة.
class HeightRuler extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final Color rulerBackgroundColor;
  final Color indicatorColor;
  final double pixelsPerUnit;
  final ValueChanged<double> onValueChanged;

  const HeightRuler({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.rulerBackgroundColor,
    required this.indicatorColor,
    required this.onValueChanged,
    this.pixelsPerUnit = 14,
  });

  @override
  State<HeightRuler> createState() => _HeightRulerState();
}

class _HeightRulerState extends State<HeightRuler> {
  late double _offsetPixels;

  @override
  void initState() {
    super.initState();
    final double v = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    _offsetPixels = (v - widget.minValue) * widget.pixelsPerUnit;
  }

  @override
  void didUpdateWidget(covariant HeightRuler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue ||
        oldWidget.minValue != widget.minValue ||
        oldWidget.maxValue != widget.maxValue) {
      final double v = widget.initialValue.clamp(widget.minValue, widget.maxValue);
      setState(() {
        _offsetPixels = (v - widget.minValue) * widget.pixelsPerUnit;
      });
    }
  }

  double get _maxOffset => (widget.maxValue - widget.minValue) * widget.pixelsPerUnit;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetPixels -= details.delta.dy;
      _offsetPixels = _offsetPixels.clamp(0, _maxOffset);
    });
    final double rawValue = widget.minValue + (_offsetPixels / widget.pixelsPerUnit);
    widget.onValueChanged(rawValue.roundToDouble());
  }

  void _onDragEnd(DragEndDetails details) {
    final double snapped =
        (_offsetPixels / widget.pixelsPerUnit).roundToDouble() * widget.pixelsPerUnit;
    setState(() => _offsetPixels = snapped.clamp(0, _maxOffset));
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = (widget.maxValue - widget.minValue).round() + 1;
    final double totalHeight = widget.pixelsPerUnit * itemCount;

    return SizedBox(
      width: 84,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: widget.rulerBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double halfHeight = constraints.maxHeight / 2;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragUpdate: _onDragUpdate,
              onVerticalDragEnd: _onDragEnd,
              child: ClipRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(0, halfHeight - _offsetPixels),
                      child: OverflowBox(
                        minHeight: totalHeight,
                        maxHeight: totalHeight,
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: List.generate(itemCount, (index) {
                            final int value = widget.minValue.round() + index;
                            final bool isMajor = value % 10 == 0;
                            final bool isMid = !isMajor && value % 5 == 0;
                            return SizedBox(
                              height: widget.pixelsPerUnit,
                              child: Center(
                                child: Container(
                                  height: isMajor ? 2 : 1,
                                  width: isMajor ? 40 : (isMid ? 30 : 22),
                                  color: Colors.white,
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: Container(
                        height: 2,
                        width: 44,
                        color: widget.indicatorColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class HeightSideLabels extends StatelessWidget {
  final double currentValue;
  final double height;
  final double pixelsPerUnit;

  const HeightSideLabels({
    super.key,
    required this.currentValue,
    required this.height,
    this.pixelsPerUnit = 14,
  });

  static const double labelStep = 5;

  @override
  Widget build(BuildContext context) {
    final int centerRounded =
        (currentValue / labelStep).round() * labelStep.toInt();
    final List<int> labelValues = [
      centerRounded + 10,
      centerRounded + 5,
      centerRounded,
      centerRounded - 5,
      centerRounded - 10,
    ];

    return SizedBox(
      width: 66,
      height: height,
      child: ClipRect(
        child: Stack(
          children: labelValues.map((value) {
            final double offset = (currentValue - value) * pixelsPerUnit;
            final bool isCenter = value == centerRounded;
            return Positioned(
              top: height / 2 - 14 + offset,
              right: 0,
              child: Text(
                '$value',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: isCenter ? 40 : 25,
                  fontWeight: AppColors.tealGray == Colors.black ? FontWeight.bold : (isCenter ? FontWeight.bold : FontWeight.normal),
                  color: isCenter ? Colors.black : Colors.grey,
                  fontFamily: 'Inter',
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class HeightPageIndicator extends StatelessWidget {
  final int totalDots;
  final int filledCount;
  final int hollowIndex;
  final Color activeColor;
  final Color inactiveColor;

  const HeightPageIndicator({
    super.key,
    required this.totalDots,
    required this.filledCount,
    required this.hollowIndex,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        final bool isFilled = index < filledCount;
        final bool isHollow = index == hollowIndex;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isFilled
                  ? activeColor
                  : (isHollow ? Colors.white : inactiveColor),
              border: isHollow
                  ? Border.all(color: activeColor, width: 1.5)
                  : null,
            ),
          ),
        );
      }),
    );
  }
}

class _LeftTrianglePainter extends CustomPainter {
  final Color color;

  _LeftTrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _LeftTrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}