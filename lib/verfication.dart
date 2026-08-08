import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/colors.dart';

class VerificationCode extends StatefulWidget {
  final String contactInfo; // الإيميل أو رقم الواتساب
  final String method; // "Email" أو "WhatsApp"

  const VerificationCode({
    super.key,
    this.contactInfo = "mo***@gmail.com",
    this.method = "Email",
  });

  @override
  State<VerificationCode> createState() => _VerificationCodeState();
}

class _VerificationCodeState extends State<VerificationCode>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  int _secondsRemaining = 60;
  Timer? _timer;
  bool _canResend = false;
  bool _isExpired = false;
  bool _isLocked = false; // بعد 5 محاولات غلط
  bool _hasError = false;
  int _wrongAttempts = 0;
  String? _errorText;

  // ===== TODO: دي دالة تجريبية بس. لازم تستبدلها بنداء حقيقي لـ Backend
  // (زي Cloud Function) بيتأكد من الكود اللي المستخدم بعته. Firebase مفهوش
  // خدمة جاهزة لإرسال كود 4 أرقام بالإيميل/واتساب، فمحتاج تبني السيستم ده
  // بنفسك (تولّد كود، تخزنه في Firestore مع وقت انتهاء، وتتأكد منه هنا) =====
  static const String _demoCorrectCode = "1234";

  // ===== Shake Animation =====
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();

    for (var node in _focusNodes) {
      node.addListener(() => setState(() {}));
    }

    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _shakeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.elasticIn),
    );
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 60;
      _canResend = false;
      _isExpired = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() {
          _canResend = true;
          _isExpired = true;
          _errorText = "Code expired";
          _hasError = true;
        });
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _shakeController.dispose();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _timerText {
    final secs = _secondsRemaining.toString().padLeft(2, '0');
    return '0:$secs';
  }

  bool get _isCodeComplete => _controllers.every((c) => c.text.isNotEmpty);

  void _clearBoxes() {
    for (var c in _controllers) {
      c.clear();
    }
  }

  void _resendCode() {
    _clearBoxes();
    setState(() {
      _hasError = false;
      _errorText = null;
      _isExpired = false;
      _isLocked = false;
      _wrongAttempts = 0;
    });
    _startTimer();
    FocusScope.of(context).requestFocus(_focusNodes[0]);

    // ===== TODO: هنا تنادي الدالة الحقيقية اللي بتولّد وتبعت كود جديد =====
  }

  Future<void> _handleContinue() async {
    if (!_isCodeComplete || _isExpired || _isLocked) return;

    final enteredCode = _controllers.map((c) => c.text).join();

    // ===== TODO: استبدل السطر ده بنداء حقيقي للـ Backend بتاعك للتأكد من الكود =====
    final bool isCorrect = enteredCode == _demoCorrectCode;

    if (isCorrect) {
      _timer?.cancel();
      if (!mounted) return;
      Navigator.pop(context, true); // رجّع true للشاشة اللي فاتحة ده
      return;
    }

    // ===== كود غلط =====
    _wrongAttempts++;

    setState(() {
      _hasError = true;
      if (_wrongAttempts >= 5) {
        _isLocked = true;
        _errorText = "Too many incorrect attempts. Please request a new code";
      } else if (_wrongAttempts >= 2) {
        _errorText =
            "Incorrect code. Make sure you're using the latest one we sent.";
      } else {
        _errorText = "Incorrect code. Please try again.";
      }
    });

    _shakeController.forward(from: 0);
    HapticFeedback.mediumImpact();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double fieldWidth =
                constraints.maxWidth * 0.9 > 320 ? 320 : constraints.maxWidth * 0.9;
            final double boxSize = (fieldWidth - 3 * 16) / 4 > 56
                ? 56
                : (fieldWidth - 3 * 16) / 4;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.1),

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

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                        children: [
                          TextSpan(
                            text: widget.method == "Email"
                                ? "We have sent the verification code to your Email:\n"
                                : "We have sent the verification code to your WhatsApp Number:\n",
                          ),
                          TextSpan(
                            text: widget.contactInfo,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ===== 4 OTP BOXES مع الـ Shake Animation =====
                    AnimatedBuilder(
                      animation: _shakeAnimation,
                      builder: (context, child) {
                        final offset =
                            sin(_shakeAnimation.value * pi * 6) * 8 *
                                (1 - _shakeAnimation.value);
                        return Transform.translate(
                          offset: Offset(offset, 0),
                          child: child,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          final hasFocus = _focusNodes[index].hasFocus;
                          final isNotEmpty = _controllers[index].text.isNotEmpty;
                          final isDisabled = _isExpired || _isLocked;

                          Color borderColor;
                          if (_hasError) {
                            borderColor = Colors.red;
                          } else if (hasFocus) {
                            borderColor = AppColors.tealGray;
                          } else if (isNotEmpty) {
                            borderColor = Colors.black;
                          } else {
                            borderColor = Colors.transparent;
                          }

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: SizedBox(
                              width: boxSize,
                              height: boxSize,
                              child: TextField(
                                controller: _controllers[index],
                                focusNode: _focusNodes[index],
                                enabled: !isDisabled,
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
                                  fillColor: isDisabled
                                      ? const Color(0xFFF7F7F7)
                                      : hasFocus
                                          ? const Color.fromARGB(128, 234, 248, 249)
                                          : isNotEmpty
                                              ? Colors.white
                                              : const Color(0xFFF2F2F2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: borderColor,
                                        width: borderColor == Colors.transparent
                                            ? 0
                                            : 1.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: borderColor,
                                        width: borderColor == Colors.transparent
                                            ? 0
                                            : 1.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: _hasError
                                            ? Colors.red
                                            : AppColors.tealGray,
                                        width: 1.5),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    // إعادة الكتابة تشيل حالة الخطأ (إلا لو منتهي أو مقفول)
                                    if (!_isExpired && !_isLocked) {
                                      _hasError = false;
                                      _errorText = null;
                                    }
                                  });

                                  if (value.isNotEmpty) {
                                    if (index < 3) {
                                      FocusScope.of(context)
                                          .requestFocus(_focusNodes[index + 1]);
                                    } else {
                                      _focusNodes[index].unfocus();
                                    }
                                  } else if (index > 0) {
                                    FocusScope.of(context)
                                        .requestFocus(_focusNodes[index - 1]);
                                  }
                                },
                              ),
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // ===== رسالة الخطأ =====
                    if (_errorText != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          _errorText!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    else
                      Text(
                        _timerText,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          color: Color(0xFFACACAC),
                        ),
                      ),

                    const SizedBox(height: 20),

                    // ===== DIDN'T RECEIVE CODE? =====
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Didn't Receive Code? ",
                          style: TextStyle(
                              fontSize: 14, fontFamily: "Inter", color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: _canResend ? _resendCode : null,
                          child: Text(
                            _isExpired || _isLocked ? "Resend Code" : "Send Again",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              fontFamily: "Inter",
                              color: _canResend
                                  ? AppColors.tealGray
                                  : Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // ===== CONTINUE BUTTON =====
                    SizedBox(
                      width: fieldWidth,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (_isCodeComplete && !_isExpired && !_isLocked)
                              ? const Color(0xFF0BA3AC)
                              : Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        onPressed:
                            (_isCodeComplete && !_isExpired && !_isLocked)
                                ? _handleContinue
                                : null,
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            color: (_isCodeComplete && !_isExpired && !_isLocked)
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
            );
          },
        ),
      ),
    );
  }
}