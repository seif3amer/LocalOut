import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                          text:
                              "We have sent the verification code to your Email:\n",
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

                  const SizedBox(height: 40),

                  // ===== 4 OTP BOXES =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: 60,
                          height: 60,
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
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
                              fillColor: _controllers[index].text.isNotEmpty
                                  ? Colors.white
                                  : const Color(0xFFF2F2F2),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: Color(0xFF0BA3AC),
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {}); // مهم لتحديث اللون والزرار

                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context)
                                    .requestFocus(_focusNodes[index - 1]);
                              }
                            },
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: 32),

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

                  const SizedBox(height: 16),

                  // ===== DIDN'T RECEIVE CODE? SEND AGAIN =====
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't Receive Code? ",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          color: Colors.grey,
                        ),
                      ),
                      GestureDetector(
                        onTap: _canResend
                            ? () {
                                _startTimer();
                                for (var c in _controllers) {
                                  c.clear();
                                }
                                FocusScope.of(
                                  context,
                                ).requestFocus(_focusNodes[0]);
                              }
                            : null,
                        child: Text(
                          "Send Again",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            fontFamily: "Inter",
                            color: _canResend
                                ? const Color(0xFF0BA3AC)
                                : Colors.grey.shade400,
                            decorationColor: const Color(0xFF0BA3AC),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // ===== CONTINUE BUTTON =====
                  SizedBox(
                    width: 320,
                    height: 52,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // ===== لو الكود مكتمل → تيل، لو لأ → رصاصي =====
                        backgroundColor: _isCodeComplete
                            ? const Color(0xFF0BA3AC)
                            : Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      // ===== لو الكود مكتمل → اشتغل، لو لأ → null يعني disabled =====
                      onPressed: _isCodeComplete
                          ? () {
                              final code =
                                  _controllers.map((c) => c.text).join();
                              // TODO: اعمل هنا الـ verification logic
                            }
                          : null,
                      child: Text(
                        "Continue",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Inter",
                          // ===== لون النص كمان يتغير =====
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