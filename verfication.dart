import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/colors.dart';

class VerificationCode extends StatefulWidget {
  const VerificationCode({super.key});

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode> {
  // ===== 4 Controllers for the 4 OTP boxes =====
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  // ===== Timer =====
  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();

    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  // ===== Format timer as 0:SS =====
  String get _timerText {
    final secs = _secondsRemaining.toString().padLeft(2, '0');
    return '0:$secs';
  }

  // ===== هل الأربع مربعات اتملو؟ =====
  bool get _isCodeComplete =>
      _controllers.every((c) => c.text.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 80),

                  // ===== TITLE =====
                  const Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Kreon",
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // ===== SUBTITLE =====
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: "We have sent the verification code to your Email:\n",
                        ),
                        TextSpan(
                          text: "mo***@gmail.com",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ===== 4 OTP BOXES =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final hasFocus = _focusNodes[index].hasFocus;
                      final isNotEmpty = _controllers[index].text.isNotEmpty;

                      final currentBorderSide = hasFocus
                          ? const BorderSide(color: AppColors.tealGray, width: 1.5)
                          : isNotEmpty
                              ? const BorderSide(color: Colors.black, width: 1.5)
                              : BorderSide.none;

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          // استخدام KeyboardListener للتحكم في زر الـ Backspace حتى لو المربع فاضي
                          child: KeyboardListener(
                            focusNode: FocusNode(), // نود وهمية للمستمع فقط
                            onKeyEvent: (event) {
                              if (event is KeyDownEvent && 
                                  event.logicalKey == LogicalKeyboardKey.backspace) {
                                // لو المربع الحالي فاضي والمسخدم ضغط امسح، نرجعه للمربع السابق ويمسحه
                                if (_controllers[index].text.isEmpty && index > 0) {
                                  _controllers[index - 1].clear();
                                  FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                  setState(() {});
                                }
                              }
                            },
                            child: TextField(
                              controller: _controllers[index],
                              focusNode: _focusNodes[index],
                              cursorColor: AppColors.tealGray,
                              cursorWidth: 1,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Inter",
                              ),
                              decoration: InputDecoration(
                                counterText: '',
                                filled: true,
                                fillColor: hasFocus
                                    ? const Color.fromARGB(128, 234, 248, 249)
                                    : isNotEmpty
                                        ? Colors.white
                                        : const Color(0xFFF2F2F2),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: currentBorderSide,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: currentBorderSide,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: currentBorderSide,
                                ),
                              ),
                              onChanged: (value) {
                                setState(() {});

                                if (value.isNotEmpty) {
                                  if (index < 3) {
                                    // الانتقال للمربع التالي
                                    FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                                  } else {
                                    // لو وصلنا للمربع الأخير (index == 3) واتكتب فيه، يشيل الفوكس خالص ويقفل الكيبورد
                                    _focusNodes[index].unfocus();
                                  }
                                } else {
                                  // لو المستخدم مسح الرقم اللي جوه المربع الحالي يرجعه خطوة لورا
                                  if (index > 0) {
                                    FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 24),

                  // ===== TIMER =====
                  Text(
                    _timerText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      color: Color(0xFFACACAC),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ===== DIDN'T RECEIVE CODE? SEND AGAIN =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't Receive Code? ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: _canResend
                            ? () {
                                _startTimer();
                                for (var c in _controllers) {
                                  c.clear();
                                }
                                FocusScope.of(context).requestFocus(_focusNodes[0]);
                              }
                            : null,
                        child: Text(
                          "Send Again",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Inter",
                            color: _canResend
                                ? AppColors.tealGray
                                : Colors.grey.shade400,
                            decorationColor: AppColors.tealGray,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ===== CONTINUE BUTTON =====
                  SizedBox(
                    width: 320,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _isCodeComplete
                            ? const Color(0xFF0BA3AC)
                            : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _isCodeComplete
                          ? () {
                              final code = _controllers.map((c) => c.text).join();
                              debugPrint('Verification code entered: $code');
                            }
                          : null,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                          color: _isCodeComplete
                              ? Colors.white
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}