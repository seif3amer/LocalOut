import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:project/signup.dart';
import 'package:project/verfication.dart';
import 'package:project/colors.dart';
import 'package:project/buildbuttonmenu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/product_details.dart'; // TODO: غيّرها لصفحة الهوم الحقيقية بتاعتك

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  bool showForgotPassword = false;
  String selectedMethod = "Email";
  bool isLoading = false;
  String? errorMessage;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() => setState(() {}));
    passwordFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // ===== FIREBASE: تسجيل دخول بالإيميل والباسورد =====
  Future<void> _loginWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => errorMessage = "من فضلك اكتب الإيميل والباسورد");
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductDetails()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = _mapFirebaseError(e.code));
    } catch (_) {
      setState(() => errorMessage = "حصل خطأ غير متوقع، حاول تاني");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  // ===== FIREBASE: تسجيل دخول بجوجل =====
  Future<void> _loginWithGoogle() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProductDetails()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() => errorMessage = _mapFirebaseError(e.code));
    } catch (_) {
      setState(() => errorMessage = "فشل تسجيل الدخول بجوجل، حاول تاني");
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
        return 'الحساب ده مش موجود';
      case 'wrong-password':
      case 'invalid-credential':
        return 'الإيميل أو كلمة السر غلط';
      case 'invalid-email':
        return 'صيغة الإيميل غلط';
      case 'user-disabled':
        return 'الحساب ده متوقف';
      case 'too-many-requests':
        return 'محاولات كتير، حاول تاني بعد شوية';
      default:
        return 'حصل خطأ ($code)';
    }
  }

  // ===== إخفاء جزء من الإيميل بنجوم =====
  String _maskEmail(String email) {
    if (!email.contains('@')) return email;
    final parts = email.split('@');
    final name = parts[0];
    if (name.length <= 2) return "$name***@${parts[1]}";
    return "${name.substring(0, 2)}***@${parts[1]}";
  }

  // ===== جلب رقم التليفون الحقيقي من Firestore وإخفاء جزء منه =====
  Future<String> _fetchMaskedPhone(String email) async {
    if (email.isEmpty) return "رقم غير متاح";

    try {
      final query = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (query.docs.isEmpty) return "رقم غير متاح";

      final phone = query.docs.first.data()['phone'] as String? ?? "";
      if (phone.isEmpty) return "رقم غير متاح";

      if (phone.length <= 6) return phone;
      final start = phone.substring(0, phone.length - 6);
      final end = phone.substring(phone.length - 3);
      return "$start***$end";
    } catch (_) {
      return "رقم غير متاح";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double fieldWidth =
                constraints.maxWidth * 0.9 > 320 ? 320 : constraints.maxWidth * 0.9;

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: constraints.maxHeight * 0.12),

                        // ===== TITLE =====
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: "kreon",
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          "Log in to your Account",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFCCCCCC),
                          ),
                        ),

                        const SizedBox(height: 40),

                        // ===== EMAIL LABEL =====
                        SizedBox(
                          width: fieldWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SvgPicture.asset('icons/email.svg'),
                              ),
                              const SizedBox(width: 8),
                              const Text("Email",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SizedBox(
                            width: fieldWidth,
                            child: TextField(
                              controller: emailController,
                              focusNode: emailFocusNode,
                              cursorColor: AppColors.tealGray,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Enter email address',
                                hintStyle: const TextStyle(
                                    color: Color(0xFFCCCCCC), fontSize: 14),
                                filled: true,
                                fillColor: emailFocusNode.hasFocus
                                    ? const Color.fromARGB(128, 234, 248, 249)
                                    : const Color(0xFFF5F5F5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: AppColors.tealGray,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ===== PASSWORD LABEL =====
                        SizedBox(
                          width: fieldWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SvgPicture.asset(
                                    'icons/qlementine-icons_password-16.svg'),
                              ),
                              const SizedBox(width: 8),
                              const Text("Password",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SizedBox(
                            width: fieldWidth,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  cursorColor: AppColors.tealGray,
                                  obscureText: isHidden,
                                  onChanged: (value) {
                                    setState(() {
                                      showForgotPassword = value.isNotEmpty;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Enter your password',
                                    hintStyle: const TextStyle(
                                        color: Color(0xFFCCCCCC), fontSize: 14),
                                    filled: true,
                                    fillColor: passwordFocusNode.hasFocus
                                        ? const Color.fromARGB(128, 234, 248, 249)
                                        : const Color(0xFFF5F5F5),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0BA3AC),
                                        width: 1.5,
                                      ),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() => isHidden = !isHidden);
                                      },
                                      icon: Icon(
                                        isHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility_outlined,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                                if (showForgotPassword)
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () => _openForgotPasswordSheet(
                                          context, fieldWidth),
                                      child: const Text(
                                        "Forgot Password?",
                                        style: TextStyle(
                                          color: Color(0xFF0BA3AC),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),

                        // ===== رسالة خطأ Firebase =====
                        if (errorMessage != null) ...[
                          const SizedBox(height: 8),
                          SizedBox(
                            width: fieldWidth,
                            child: Text(
                              errorMessage!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],

                        const SizedBox(height: 24),

                        // ===== OR DIVIDER =====
                        SizedBox(
                          width: fieldWidth,
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Row(
                              children: [
                                Expanded(child: Divider(thickness: 1)),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "OR",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Expanded(child: Divider(thickness: 1)),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ===== LOGIN WITH GOOGLE (زرار Apple اتشال بالكامل) =====
                        SizedBox(
                          height: 48,
                          width: fieldWidth,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    width: 1.5, color: Color(0xFFF5F5F5)),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            onPressed: isLoading ? null : _loginWithGoogle,
                            icon: Image.asset("images/google.png", height: 24),
                            label: const Text(
                              "Login With Google",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Inter",
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ===== LOGIN BUTTON =====
                        SizedBox(
                          width: fieldWidth,
                          height: 44,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.tealGray,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              elevation: 0,
                            ),
                            onPressed: isLoading ? null : _loginWithEmail,
                            child: isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    "Log in",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Inter",
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ===== SIGN UP LINK =====
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                                fontFamily: "Inter",
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()),
                                );
                              },
                              child: const Text(
                                "Sign-Up",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  color: AppColors.tealGray,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _openForgotPasswordSheet(BuildContext context, double fieldWidth) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            bool isSendingOtp = false;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  "Verify Your Identity",
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const SizedBox(height: 9),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16),
                                child: SvgPicture.asset(
                                  'icons/exclamation (16) 1.svg',
                                  color: AppColors.gray,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Expanded(
                                child: Text(
                                  "For your security, verification is required on new devices.",
                                  style: TextStyle(fontSize: 10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              "Choose how to receive your code",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              MethodButton(
                                title: "Email",
                                isSelected: selectedMethod == "Email",
                                onTap: () =>
                                    setModalState(() => selectedMethod = "Email"),
                              ),
                              const SizedBox(width: 12),
                              MethodButton(
                                title: "WhatsApp",
                                isSelected: selectedMethod == "WhatsApp",
                                onTap: () => setModalState(
                                    () => selectedMethod = "WhatsApp"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Center(
                            child: SizedBox(
                              width: fieldWidth,
                              height: 44,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.tealGray,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: isSendingOtp
                                    ? null
                                    : () async {
                                        setModalState(() => isSendingOtp = true);

                                        String maskedContact = "";
                                        final email = emailController.text.trim();

                                        if (selectedMethod == "Email") {
                                          if (email.isNotEmpty) {
                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                email: email,
                                              );
                                            } catch (_) {}
                                          }
                                          maskedContact = _maskEmail(email);
                                        } else {
                                          maskedContact =
                                              await _fetchMaskedPhone(email);
                                        }

                                        if (!context.mounted) return;
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => VerificationCode(
                                              contactInfo: maskedContact,
                                              method: selectedMethod,
                                            ),
                                          ),
                                        );
                                      },
                                child: isSendingOtp
                                    ? const SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        "Send OTP",
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
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}