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
  static const double maxHeight = 250;

  // القيمة الحقيقية دي هي المصدر الوحيد للحالة (continuous double)
  double height = 160;

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

  // بيتنادى من المسطرة أثناء السحب (قيمة continuous) وعند نهاية السحب (قيمة مقرّبة)
  void _onRulerChanged(double value) {
    setState(() {
      height = value.clamp(minHeight, maxHeight);
      // منحدثش التيكست فيلد وهو لسه فاتح للكتابة عشان مايحصلش قفز في الكيرسر
      if (!heightFocusNode.hasFocus) {
        heightController.text = height.round().toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
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
            color: AppColors.background,
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
                        keyboardType:
                            const TextInputType.numberWithOptions(decimal: false),
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

/// الصف اللي بيحتوي على أرقام الجنب + المسطرة الرأسية + أرقام يمين + مؤشر الـ SVG.
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

  static const double pixelsPerUnit = 17;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        HeightSideLabels(
          currentValue: currentValue,
          minValue: minValue,
          maxValue: maxValue,
          pixelsPerUnit: pixelsPerUnit,
        ),
        const SizedBox(width: 12),
        HeightRuler(
          currentValue: currentValue,
          minValue: minValue,
          maxValue: maxValue,
          rulerBackgroundColor: rulerBackgroundColor,
          indicatorColor: indicatorColor,
          pixelsPerUnit: pixelsPerUnit,
          onValueChanged: onValueChanged,
        ),
        const SizedBox(width: 10),
        HeightRightLabels(
          currentValue: currentValue,
          minValue: minValue,
          maxValue: maxValue,
          pixelsPerUnit: pixelsPerUnit,
        ),
        const SizedBox(width: 6),
        SvgPicture.asset(
          "icons/height_triangle.svg",
          width: 36,
          height: 32,
        ),
      ],
    );
  }
}

/// مسطرة رأسية مخصصة — "controlled widget" بالكامل.
class HeightRuler extends StatelessWidget {
  final double currentValue;
  final double minValue;
  final double maxValue;
  final Color rulerBackgroundColor;
  final Color indicatorColor;
  final double pixelsPerUnit;
  final ValueChanged<double> onValueChanged;

  const HeightRuler({
    super.key,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    required this.rulerBackgroundColor,
    required this.indicatorColor,
    required this.onValueChanged,
    this.pixelsPerUnit = 14,
  });

  void _onDragUpdate(DragUpdateDetails details) {
    final double deltaValue = -details.delta.dy / pixelsPerUnit;
    final double newValue = (currentValue + deltaValue).clamp(minValue, maxValue);
    onValueChanged(newValue);
  }

  void _onDragEnd(DragEndDetails details) {
    final double snapped = currentValue.roundToDouble().clamp(minValue, maxValue);
    onValueChanged(snapped);
  }

  double _indicatorWidthForValue(double value) {
    final int v = value.round();
    final bool isMajor = v % 10 == 0;
    final bool isMid = !isMajor && v % 5 == 0;
    return isMajor ? 40 : (isMid ? 30 : 22);
  }

  @override
  Widget build(BuildContext context) {
    final double indicatorWidth = _indicatorWidthForValue(currentValue);

    return SizedBox(
      width: 84,
      height: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          color: rulerBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onVerticalDragUpdate: _onDragUpdate,
          onVerticalDragEnd: _onDragEnd,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _TickPainter(
                    currentValue: currentValue,
                    minValue: minValue,
                    maxValue: maxValue,
                    pixelsPerUnit: pixelsPerUnit,
                  ),
                ),
              ),
              IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  height: 2,
                  width: indicatorWidth,
                  color: indicatorColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TickPainter extends CustomPainter {
  final double currentValue;
  final double minValue;
  final double maxValue;
  final double pixelsPerUnit;

  _TickPainter({
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    required this.pixelsPerUnit,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double centerY = size.height / 2;
    final double centerX = size.width / 2;
    final Paint paint = Paint()..color = Colors.white;

    final int start = minValue.round();
    final int end = maxValue.round();

    for (int v = start; v <= end; v++) {
      final double y = centerY - (v - currentValue) * pixelsPerUnit;
      if (y < -4 || y > size.height + 4) continue;

      final bool isMajor = v % 10 == 0;
      final bool isMid = !isMajor && v % 5 == 0;
      final double lineWidth = isMajor ? 40 : (isMid ? 30 : 22);
      final double strokeHeight = isMajor ? 2.0 : 1.0;

      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(centerX, y),
          width: lineWidth,
          height: strokeHeight,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _TickPainter oldDelegate) {
    return oldDelegate.currentValue != currentValue ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue ||
        oldDelegate.pixelsPerUnit != pixelsPerUnit;
  }
}

class HeightSideLabels extends StatelessWidget {
  final double currentValue;
  final double minValue;
  final double maxValue;
  final double pixelsPerUnit;

  const HeightSideLabels({
    super.key,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    this.pixelsPerUnit = 14,
  });

  static const int labelStep = 5;

  static const Color _labelColor = Color(0xFFC4C4C4);
  static const String _labelFontFamily = 'Poppins';

  static const double _sizeNearest = 40;
  static const double _sizeNear = 35;
  static const double _sizeFar = 25;

  @override
  Widget build(BuildContext context) {
    final int start = minValue.round();
    final int end = maxValue.round();
    final int currentRounded = currentValue.round();

    return SizedBox(
      width: 66,
      height: double.infinity,
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double height = constraints.maxHeight;
            final double centerY = height / 2;

            final List<Widget> labels = [];
            for (int v = start; v <= end; v++) {
              if (v % labelStep != 0) continue;

              final int stepDistance =
                  ((v - currentValue) / labelStep).round().abs();
              final double fontSize = stepDistance == 0
                  ? _sizeNearest
                  : (stepDistance == 1 ? _sizeNear : _sizeFar);

              // التعديل هنا: يكون باللون الأسود فقط عندما يتطابق الرقم المقرب بالضبط مع v
              final bool isSelected = (v == currentRounded);

              final TextStyle style = TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : _labelColor,
                fontFamily: _labelFontFamily,
                height: 1.0,
              );

              final double y = centerY - (v - currentValue) * pixelsPerUnit;

              final double halfTextHeight = fontSize * 0.62;
              if (y - halfTextHeight < 0 || y + halfTextHeight > height) continue;

              labels.add(
                Positioned(
                  top: y,
                  right: 0,
                  child: FractionalTranslation(
                    translation: const Offset(0, -0.5),
                    child: Text(
                      '$v',
                      textAlign: TextAlign.right,
                      style: style,
                    ),
                  ),
                ),
              );
            }
            return Stack(children: labels);
          },
        ),
      ),
    );
  }
}

class HeightRightLabels extends StatelessWidget {
  final double currentValue;
  final double minValue;
  final double maxValue;
  final double pixelsPerUnit;

  const HeightRightLabels({
    super.key,
    required this.currentValue,
    required this.minValue,
    required this.maxValue,
    this.pixelsPerUnit = 14,
  });

  static const TextStyle _normalStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: Colors.grey,
    fontFamily: 'Inter',
    height: 1.0,
  );

  static const TextStyle _currentStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontFamily: 'Inter',
    height: 1.0,
  );

  @override
  Widget build(BuildContext context) {
    final int currentRounded = currentValue.round();
    final int start = minValue.round();
    final int end = maxValue.round();

    return SizedBox(
      width: 40,
      height: double.infinity,
      child: ClipRect(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double height = constraints.maxHeight;
            final double centerY = height / 2;

            final List<Widget> labels = [];
            for (int v = start; v <= end; v++) {
              if (v % 5 == 0) continue;

              final bool isCurrent = v == currentRounded;
              final TextStyle style = isCurrent ? _currentStyle : _normalStyle;

              final double y = centerY - (v - currentValue) * pixelsPerUnit;

              final double halfTextHeight = style.fontSize! * 0.62;
              if (y - halfTextHeight < 0 || y + halfTextHeight > height) continue;

              labels.add(
                Positioned(
                  top: y,
                  left: 0,
                  child: FractionalTranslation(
                    translation: const Offset(0, -0.5),
                    child: Text(
                      '$v',
                      textAlign: TextAlign.left,
                      style: style,
                    ),
                  ),
                ),
              );
            }
            return Stack(children: labels);
          },
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
              color: isFilled ? activeColor : (isHollow ? Colors.white : inactiveColor),
              border: isHollow ? Border.all(color: activeColor, width: 1.5) : null,
            ),
          ),
        );
      }),
    );
  }
}