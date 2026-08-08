import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart'; // تأكد من وجود ملف الألوان في مساره

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
  double weight = 75; // الوزن الافتراضي

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
    // حصر القيمة بين المسموح به
    final double clamped = parsed.clamp(minWeight, maxWeight);
    setState(() {
      weight = clamped;
    });
  }

  // بيتنادى لما اليوزر يسحب المسطرة
  void _onRulerChanged(double value) {
    setState(() {
      weight = value;
      // نحدث التيكست فيلد فقط لو اليوزر مش قاعد يكتب جواه دلوقتي
      if (!weightFocusNode.hasFocus) {
        weightController.text = value.round().toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // TODO: تنفيذ التخطي (Skip)
            },
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
                const SizedBox(width: 4),
                // تأكد من وجود الأيقونة في مسارها
                SvgPicture.asset("icons/skip.svg"),
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
          decoration: const BoxDecoration(
            color: AppColors.background,
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
                
                // اختيار الوحدة (KG/LB)
                UnitSelector(
                  isKg: isKg,
                  onChanged: (value) {
                    setState(() {
                      isKg = value;
                    });
                  },
                ),
                
                const SizedBox(height: 32),
                
                // الأرقام الكبيرة المتحركة فوق المسطرة
                WeightNumberLabels(currentValue: weight.round()),
                const SizedBox(height: 8),
                
                // --- المسطرة (الودجت المعدلة) ---
                WeightRuler(
                  initialValue: weight,
                  minValue: minWeight,
                  maxValue: maxWeight,
                  rulerBackgroundColor: const Color(0xFFB3A0FF),
                  markerColor: markerYellow,
                  onValueChanged: _onRulerChanged,
                ),
                
                const SizedBox(height: 16),
                // تأكد من وجود المثلث في المسار
                SvgPicture.asset("icons/triangle.svg"),
                
                const SizedBox(height: 16),
                
                // عرض الوزن الحالي والوحدة (Kg/Lb)
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: false),
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
                          // تصفير النص في حال إدخال قيمة خاطئة أو تحديثه عند الانتهاء
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
                          color: Colors.black,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                
                // مؤشر الصفحات (الصفحة 2 من 5)
                const StepIndicator(
                  totalDots: 5,
                  activeDots: 2,
                  activeColor: AppColors.tealGray,
                  inactiveColor: AppColors.gray,
                ),
                
                const SizedBox(height: 32),
                
                // زر المتابعة
                SizedBox(
                  width: 320,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: تنفيذ المتابعة للصفحة التالية
                    },
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

// --- الودجت الفرعية المستقلة جوة الملف ---

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
        color: selected
            ? AppColors.tealGray
            : const Color.fromRGBO(147, 151, 152, 1),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
      ),
    );
  }
}

class WeightNumberLabels extends StatelessWidget {
  final int currentValue;

  const WeightNumberLabels({super.key, required this.currentValue});

  @override
  Widget build(BuildContext context) {
    // عرض القيمة الحالية وبجانبها قيمتين (أصغر وأكبر)
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

class StepIndicator extends StatelessWidget {
  final int totalDots;
  final int activeDots; // يمثل عدد الصفحات المكتملة حتى الآن
  final Color activeColor;
  final Color inactiveColor;

  const StepIndicator({
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
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // الصفحة النشطة فقط محاطة ببرودر ملون، والغير نشطة رمادية
              color: isActive ? Colors.transparent : inactiveColor,
              border: isActive ? Border.all(color: activeColor, width: 2) : null,
            ),
          ),
        );
      }),
    );
  }
}

// --- ويدجت المسطرة المعدلة بالكامل لحل مشكلة المحاذاة ---
class WeightRuler extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final Color rulerBackgroundColor;
  final Color markerColor;
  final ValueChanged<double> onValueChanged;
  final double pixelsPerUnit;

  const WeightRuler({
    super.key,
    required this.initialValue,
    required this.minValue,
    required this.maxValue,
    required this.rulerBackgroundColor,
    required this.markerColor,
    required this.onValueChanged,
    // تم زيادة المسافة قليلاً لتبدو مثل الصورة
    this.pixelsPerUnit = 15,
  });

  @override
  State<WeightRuler> createState() => _WeightRulerState();
}

class _WeightRulerState extends State<WeightRuler> {
  late double _offsetPixels;

  @override
  void initState() {
    super.initState();
    final double v =
        widget.initialValue.clamp(widget.minValue, widget.maxValue);
    _offsetPixels = (v - widget.minValue) * widget.pixelsPerUnit;
  }

  @override
  void didUpdateWidget(covariant WeightRuler oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue ||
        oldWidget.minValue != widget.minValue ||
        oldWidget.maxValue != widget.maxValue) {
      final double v =
          widget.initialValue.clamp(widget.minValue, widget.maxValue);
      _offsetPixels = (v - widget.minValue) * widget.pixelsPerUnit;
    }
  }

  double get _maxOffset =>
      (widget.maxValue - widget.minValue) * widget.pixelsPerUnit;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetPixels -= details.delta.dx;
      _offsetPixels = _offsetPixels.clamp(0, _maxOffset);
    });
    final double rawValue =
        widget.minValue + (_offsetPixels / widget.pixelsPerUnit);
    widget.onValueChanged(rawValue.roundToDouble());
  }

  void _onDragEnd(DragEndDetails details) {
    // المحاذاة الدقيقة (Snap) لتقف المسطرة فوق السن الأبيض تماماً عند الانتهاء
    final double snapped =
        (_offsetPixels / widget.pixelsPerUnit).roundToDouble() *
            widget.pixelsPerUnit;
    setState(() => _offsetPixels = snapped.clamp(0, _maxOffset));
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = (widget.maxValue - widget.minValue).round() + 1;
    final double totalWidth = widget.pixelsPerUnit * itemCount;

    return SizedBox(
      height: 100, // زيادة الارتفاع الكلي لإعطاء مساحة للسنون
      width: double.infinity,
      child: Container(
        color: widget.rulerBackgroundColor,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double halfWidth = constraints.maxWidth / 2;

            // تم تعديل translateX لحل مشكلة المحاذاة.
            // السر في إضافة (widget.pixelsPerUnit / 2) لضبط منتصف السن الأبيض
            // مع منتصف الخط الأصفر تماماً.
            final double translateX =
                halfWidth - _offsetPixels - (widget.pixelsPerUnit / 2);

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onHorizontalDragUpdate: _onDragUpdate,
              onHorizontalDragEnd: _onDragEnd,
              child: ClipRect(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: Offset(translateX, 0),
                      child: OverflowBox(
                        minWidth: totalWidth,
                        maxWidth: totalWidth,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: List.generate(itemCount, (index) {
                            final int value = widget.minValue.round() + index;
                            // الخط الطويل يتكرر كل 5 وحدات
                            final bool isMajor = value % 5 == 0;

                            return SizedBox(
                              width: widget.pixelsPerUnit,
                              child: Center(
                                child: Container(
                                  width: isMajor ? 2.5 : 1.8, // سمك الخطوط
                                  height:
                                      isMajor ? 54 : 26, // طول السنون البيضاء
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                        .withOpacity(isMajor ? 1.0 : 0.8),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),

                    // المؤشر الأصفر في المنتصف بالظبط ( IgnorePointer لكي لا يمنع السحب)
                    IgnorePointer(
                      child: Container(
                        width: 3.5, // سمك المؤشر الأصفر
                        height: 64, // ارتفاع المؤشر ليكون بارزاً
                        decoration: BoxDecoration(
                          color: widget.markerColor,
                          borderRadius: BorderRadius.circular(1),
                        ),
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

