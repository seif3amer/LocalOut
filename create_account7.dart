import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';

class WeightSelectionPage extends StatefulWidget {
  const WeightSelectionPage({super.key});

  @override
  State<WeightSelectionPage> createState() => _WeightSelectionPageState();
}

class _WeightSelectionPageState extends State<WeightSelectionPage> {
  static const Color markerYellow = Color(0xFFE6E44C);

  static const double minWeight = 30;
  static const double maxWeight = 200;

  bool isKg = true;
  double weight = 75;

  late final TextEditingController weightController;
  final FocusNode weightFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    weightController = TextEditingController(text: weight.round().toString());
  }

  @override
  void dispose() {
    weightController.dispose();
    weightFocusNode.dispose();
    super.dispose();
  }

  // بيتنادى لما اليوزر يكتب رقم في التيكست فيلد بنفسه
  void _onWeightTextChanged(String value) {
    final double? parsed = double.tryParse(value);
    if (parsed == null) return;
    final double clamped = parsed.clamp(minWeight, maxWeight);
    setState(() {
      weight = clamped;
    });
  }

  // بيتنادى لما اليوزر يسحب المسطرة
  void _onRulerChanged(double value) {
    setState(() {
      weight = value;
      // منحدثش التيكست فيلد وهو لسه فاتح للكتابة عشان مايحصلش قفز في الكيرسر
      if (!weightFocusNode.hasFocus) {
        weightController.text = value.round().toString();
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
                Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
                IconButton(onPressed: () {}, icon: SvgPicture.asset("icons/skip.svg")),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'What is your weight?',
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
                UnitSelector(
                  isKg: isKg,
                  onChanged: (value) {
                    setState(() {
                      isKg = value;
                    });
                  },
                ),
                const SizedBox(height: 32),
                WeightNumberLabels(currentValue: weight.round()),
                const SizedBox(height: 8),
                WeightRuler(
                  initialValue: weight,
                  minValue: minWeight,
                  maxValue: maxWeight,
                  rulerBackgroundColor: const Color.fromRGBO(179, 160, 255, 1),
                  markerColor: markerYellow,
                  onValueChanged: _onRulerChanged,
                ),
                const SizedBox(height: 16),
                CustomPaint(
                  size: const Size(46, 32),
                  painter: _TrianglePainter(color: AppColors.tealGray),
                ),
                const SizedBox(height: 16),
                // التيكست فيلد بدل RichText الثابت: تقدر تكتب فيه رقم
                // وهيحرك المسطرة، والعكس صحيح (تحريك المسطرة بيحدث الرقم هنا).
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IntrinsicWidth(
                      child: TextField(
                        controller: weightController,
                        cursorColor: AppColors.tealGray,
                        cursorWidth: 1.5,
                        focusNode: weightFocusNode,
                        keyboardType: const TextInputType.numberWithOptions(decimal: false),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Poppins',
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        onChanged: _onWeightTextChanged,
                        onSubmitted: (value) {
                          // لما يخلص كتابة، ثبّت الرقم بعد الـ clamp في التيكست فيلد
                          weightController.text = weight.round().toString();
                          weightController.selection = TextSelection.collapsed(
                            offset: weightController.text.length,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12, left: 4),
                      child: Text(
                        isKg ? 'Kg' : 'Lb',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.normal,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const PageIndicator(
                  totalDots: 5,
                  activeDots: 2,
                  activeColor: AppColors.tealGray,
                  inactiveColor: AppColors.gray,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: 320,
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
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: const Text(
        'Your weight helps improve clothing size recommendations.',
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

/// اختيار الوحدة (كجم/رطل): اللي مختار بيبقى تيل جراي وأبيض،
/// والتاني بيبقى رمادي فاتح وأسود.
class UnitSelector extends StatelessWidget {
  final bool isKg;
  final ValueChanged<bool> onChanged;

  const UnitSelector({
    super.key,
    required this.isKg,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 56,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: _UnitButton(
              label: 'KG',
              selected: isKg,
              onTap: () => onChanged(true),
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: Colors.white,
          ),
          Expanded(
            child: _UnitButton(
              label: 'LB',
              selected: !isKg,
              onTap: () => onChanged(false),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _UnitButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: selected ? AppColors.tealGray : const Color.fromRGBO(147, 151, 152, 1),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.white,
            fontSize: 20,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

/// صف الأرقام فوق المسطرة (زي 73 74 75 76 77) — الرقم في النص بولد وأسود،
/// والباقي رمادي.
class WeightNumberLabels extends StatelessWidget {
  final int currentValue;

  const WeightNumberLabels({super.key, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    final List<int> values = [
      currentValue - 2,
      currentValue - 1,
      currentValue,
      currentValue + 1,
      currentValue + 2,
    ];

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: values.map((value) {
            final bool isCenter = value == currentValue;
            return Text(
              '$value',
              style: TextStyle(
                fontSize: isCenter ? 40 : 25,
                fontWeight: isCenter ? FontWeight.bold : FontWeight.normal,
                color: isCenter ? Colors.black : Colors.grey,
                fontFamily: 'Poppins',
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// مسطرة أفقية مبنية بـ GestureDetector + Transform بدل ListView/ScrollController،
/// عشان تشتغل بشكل مضمون حتى لو الصفحة دي جوه PageView (أونبوردينج بيها سحب أفقي).
class WeightRuler extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final Color rulerBackgroundColor;
  final Color markerColor;
  final ValueChanged<double> onValueChanged;

  /// عدد البكسلات اللي بيمثلوا وحدة واحدة (1 كجم / 1 رطل)
  final double pixelsPerUnit;

  const WeightRuler({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.rulerBackgroundColor,
    required this.markerColor,
    required this.onValueChanged,
    this.pixelsPerUnit = 10,
  });

  @override
  State<WeightRuler> createState() => _WeightRulerState();
}

class _WeightRulerState extends State<WeightRuler> {
  // 0 = عند minValue
  late double _offsetPixels;

  @override
  void initState() {
    super.initState();
    final double v = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    _offsetPixels = (v - widget.minValue) * widget.pixelsPerUnit;
  }

  @override
  void didUpdateWidget(covariant WeightRuler oldWidget) {
    super.didUpdateWidget(oldWidget);
    // لو الوحدة اتغيرت (كجم/رطل) وجالنا initialValue جديدة من بره، حدّث المكان.
    if (oldWidget.initialValue != widget.initialValue ||
        oldWidget.minValue != widget.minValue ||
        oldWidget.maxValue != widget.maxValue) {
      final double v = widget.initialValue.clamp(widget.minValue, widget.maxValue);
      _offsetPixels = (v - widget.minValue) * widget.pixelsPerUnit;
    }
  }

  double get _maxOffset => (widget.maxValue - widget.minValue) * widget.pixelsPerUnit;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetPixels -= details.delta.dx;
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
    final double totalWidth = widget.pixelsPerUnit * itemCount;

    return SizedBox(
      height: 90,
      width: double.infinity,
      child: Container(
        color: widget.rulerBackgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double halfWidth = constraints.maxWidth / 2;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: ClipRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(halfWidth - _offsetPixels, 0),
                      child: OverflowBox(
                        minWidth: totalWidth,
                        maxWidth: totalWidth,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: List.generate(itemCount, (index) {
                            final int value = widget.minValue.round() + index;
                            final bool isMajor = value % 10 == 0;
                            final bool isMid = !isMajor && value % 5 == 0;
                            return SizedBox(
                              width: widget.pixelsPerUnit,
                              child: Center(
                                child: Container(
                                  width: isMajor ? 2 : 1,
                                  height: isMajor ? 40 : (isMid ? 30 : 24),
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
                        width: 2,
                        height: 44,
                        color: widget.markerColor,
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

class PageIndicator extends StatelessWidget {
  final int totalDots;
  final int activeDots;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicator({
    super.key,
    required this.totalDots,
    required this.activeDots,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        final bool isActive = index < activeDots;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? activeColor : inactiveColor,
            ),
          ),
        );
      }),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TrianglePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}