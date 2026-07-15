import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/triangle.dart';

class CreateAccount6 extends StatefulWidget {
  const CreateAccount6({super.key});

  @override
  State<CreateAccount6> createState() => _CreateAccount6State();
}

class _CreateAccount6State extends State<CreateAccount6> {
  static const Color primaryTeal = Color(0xFF0BA3AC);
  static const Color pickerBackground = Color(0xFFB3A0FF);
  static const Color greyBorder = Color(0xFFD9D9D9);

  int currentValue = 28;
  late final TextEditingController ageController;

  @override
  void initState() {
    super.initState();
    ageController = TextEditingController(text: currentValue.toString());
  }

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.gradientTop,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'How old are you?',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32,),
              Container(
                width: double.infinity,
                height: 79,
                color: Color(0xFF635CA8),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: const Text(
                  'We use your age to tailor fashion trends and brand suggestions.',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
              const SizedBox(height: 62),
              SizedBox(
                width: 150,
                child: TextField(
                  cursorColor: AppColors.tealGray,
                  cursorWidth: 1.5,
                  controller: ageController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 64,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                  ),
                  onChanged: (value) {
                    final int? age = int.tryParse(value);
                    if (age != null && age >= 0 && age <= 100) {
                      setState(() => currentValue = age);
                    }
                  },
                ),
              ),
              const SizedBox(height: 32),
              CustomPaint(
                size: const Size(46, 32),
                painter: TrianglePainter(),
              ),
              const SizedBox(height: 16),
              AgePicker(
                minValue: 0,
                maxValue: 100,
                value: currentValue,
                backgroundColor: pickerBackground,
                highlightColor: pickerBackground,
                onChanged: (value) {
                  setState(() {
                    currentValue = value;
                    ageController.text = value.toString();
                  });
                },
              ),
              const SizedBox(height: 16),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Dot(color: primaryTeal, borderColor: primaryTeal),
                  SizedBox(width: 5),
                  _Dot(color: greyBorder, borderColor: primaryTeal),
                  SizedBox(width: 5),
                  _Dot(color: greyBorder, borderColor: greyBorder),
                  SizedBox(width: 5),
                  _Dot(color: greyBorder, borderColor: greyBorder),
                  SizedBox(width: 5),
                  _Dot(color: greyBorder, borderColor: greyBorder),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      'Continue',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final Color color;
  final Color borderColor;
  const _Dot({required this.color, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(color: borderColor),
        shape: BoxShape.circle,
      ),
    );
  }
}

/// بيكر أفقي مخصص للسن، اتبنى بـ GestureDetector + Transform (من غير أي
/// باكيدج خارجي أو ListView/ScrollController)، عشان:
/// 1) يتحرك بشكل مضمون ومايتلغبطش مع أي والد فيه سحب أفقي.
/// 2) يديني تحكم كامل في شكل كل رقم لوحده (اللون/الحجم) حسب بعده عن
///    الرقم المختار، ومربع التظليل حوالين الرقم المختار، بالظبط زي التصميم.
class AgePicker extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int value;
  final Color backgroundColor;
  final Color highlightColor;
  final ValueChanged<int> onChanged;

  const AgePicker({
    super.key,
    required this.minValue,
    required this.maxValue,
    required this.value,
    required this.backgroundColor,
    required this.highlightColor,
    required this.onChanged,
  });

  @override
  State<AgePicker> createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  static const double itemWidth = 72;

  late double _offsetPixels; // 0 = عند minValue
  late int _roundedValue;

  @override
  void initState() {
    super.initState();
    _roundedValue = widget.value.clamp(widget.minValue, widget.maxValue);
    _offsetPixels = (_roundedValue - widget.minValue) * itemWidth;
  }

  @override
  void didUpdateWidget(covariant AgePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _roundedValue) {
      _roundedValue = widget.value.clamp(widget.minValue, widget.maxValue);
      _offsetPixels = (_roundedValue - widget.minValue) * itemWidth;
    }
  }

  double get _maxOffset => (widget.maxValue - widget.minValue) * itemWidth;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetPixels -= details.delta.dx;
      _offsetPixels = _offsetPixels.clamp(0, _maxOffset);
      final int newRounded =
          (widget.minValue + (_offsetPixels / itemWidth)).round();
      if (newRounded != _roundedValue) {
        _roundedValue = newRounded;
        widget.onChanged(_roundedValue);
      }
    });
  }

  void _onDragEnd(DragEndDetails details) {
    setState(() {
      // اقفل بالظبط على مركز الرقم المختار
      _offsetPixels = (_roundedValue - widget.minValue) * itemWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int itemCount = widget.maxValue - widget.minValue + 1;

    return SizedBox(
      height: 99,
      width: double.infinity,
      child: Container(
        color: widget.backgroundColor,
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
                    // صندوق التظليل الثابت في المنتصف (خانة الرقم المختار)
                    Container(
                      width: itemWidth,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: widget.highlightColor,
                        border: const Border.symmetric(
                          vertical: BorderSide(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                    // صف الأرقام المتحرك
                    Transform.translate(
                      offset: Offset(
                        halfWidth - _offsetPixels - itemWidth / 2,
                        0,
                      ),
                      child: OverflowBox(
                        minWidth: itemWidth * itemCount,
                        maxWidth: itemWidth * itemCount,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: List.generate(itemCount, (index) {
                            final int value = widget.minValue + index;
                            final int distance = (value - _roundedValue).abs();
                        
                            final TextStyle style;
                            if (distance == 0) {
                              style = const TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Poppins',
                              );
                            } else if (distance == 1) {
                              style = const TextStyle(
                                color: Colors.black,
                                fontSize: 35,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                              );
                            } else {
                              style = TextStyle(
                                color: Colors.black.withOpacity(0.45),
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              );
                            }
                        
                            return SizedBox(
                              width: itemWidth,
                              child: Center(
                                child: Text('$value', style: style),
                              ),
                            );
                          }),
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