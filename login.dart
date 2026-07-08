import 'package:flutter/material.dart';
import 'package:project/signup.dart';
import 'package:project/colors.dart';
import 'package:project/buildbuttonmenu.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  bool showForgotPassword = false;
  String selectedMethod = "Email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // ===== RESPONSIVE WIDTH CALCULATION =====
            // بياخد أصغر قيمة بين 320 (القيمة الأصلية) و 90% من عرض الشاشة
            // عشان يفضل مظبوط على الموبايل الصغير والتابلت والويب من غير ما يخرج بره الشاشة
            final double fieldWidth =
                constraints.maxWidth * 0.9 > 320 ? 320 : constraints.maxWidth * 0.9;

            return Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),

                      // ===== TITLE =====
                      const Text(
                        "Welcome Back!",
                        style: TextStyle(
                          fontSize: 24,
                          fontFamily: "Kreon",
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const Text(
                        "Log in to your Account",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // ===== EMAIL LABEL =====
                      SizedBox(
                        width: fieldWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Icon(Icons.email_outlined,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                            SizedBox(width: 8),
                            Text("Email", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ===== EMAIL FIELD =====
                      SizedBox(
                        width: fieldWidth,
                        child: TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter email address',
                            hintStyle: const TextStyle(color: Color(0xFFACACAC)),
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide(
                                color: AppColors.tealGray,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ===== PASSWORD LABEL =====
                      SizedBox(
                        width: fieldWidth,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                             Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: SvgPicture.asset(
                                'icons/qlementine-icons_password-16.svg',
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text("Password", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 8),

                      SizedBox(
                        width: fieldWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              obscureText: isHidden,
                              onChanged: (value) {
                                setState(() {
                                  showForgotPassword = value.isNotEmpty;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
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
                                    setState(() {
                                      isHidden = !isHidden;
                                    });
                                  },
                                  icon: Icon(
                                    isHidden
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                            // ===== FORGOT PASSWORD BUTTON =====
                            if (showForgotPassword)
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return LayoutBuilder(
                                              builder: (context, sheetConstraints) {
                                                final double sheetFieldWidth =
                                                    sheetConstraints.maxWidth * 0.9 > 320
                                                        ? 320
                                                        : sheetConstraints.maxWidth * 0.9;
                                                return SizedBox(
                                                  width: double.infinity,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        top: 20, left: 20, right: 20),
                                                    child: SingleChildScrollView(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Text(
                                                                "Verify Your Identity",
                                                                style: TextStyle(
                                                                  fontSize: 16,
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              IconButton(
                                                                onPressed: () {
                                                                  Navigator.pop(context);
                                                                },
                                                                icon: const Icon(Icons.close),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10),
                                                          const Row(
                                                            children: [
                                                              Icon(
                                                                Icons.info_outline,
                                                                color: Color(0xFF8B8484),
                                                                size: 14,
                                                              ),
                                                              SizedBox(width: 5),
                                                              Expanded(
                                                                child: Text(
                                                                  "For your security, verification is required on new devices.",
                                                                  style: TextStyle(
                                                                    fontSize: 10,
                                                                    fontWeight: FontWeight.w100,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 20),
                                                          const Text(
                                                            "Choose how to receive your code",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 10),
                                                          Row(
                                                            children: [
                                                              MethodButton(
                                                                title: "Email",
                                                                isSelected:
                                                                    selectedMethod == "Email",
                                                                onTap: () {
                                                                  setModalState(() {
                                                                    selectedMethod = "Email";
                                                                  });
                                                                },
                                                              ),
                                                              const SizedBox(width: 12),
                                                              MethodButton(
                                                                title: "WhatsApp",
                                                                isSelected:
                                                                    selectedMethod == "WhatsApp",
                                                                onTap: () {
                                                                  setModalState(() {
                                                                    selectedMethod = "WhatsApp";
                                                                  });
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          const SizedBox(height: 10),
                                                          SizedBox(
                                                            width: sheetFieldWidth,
                                                            height: 52,
                                                            child: ElevatedButton(
                                                              style: ElevatedButton.styleFrom(
                                                                backgroundColor:
                                                                    AppColors.tealGray,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(30),
                                                                ),
                                                                elevation: 0,
                                                              ),
                                                              onPressed: () {},
                                                              child: const Text(
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
                                                          const SizedBox(height: 20),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
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

                      // ===== OR DIVIDER =====
                      SizedBox(
                        width: fieldWidth,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: const [
                              Expanded(child: Divider(thickness: 1)),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "OR",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(child: Divider(thickness: 1)),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 35),

                      // ===== LOGIN WITH GOOGLE =====
                      SizedBox(
                        width: fieldWidth,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(width: 1.5, color: Color(0xFFF5F5F5)),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {},
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

                      const SizedBox(height: 18),

                      // ===== LOGIN WITH APPLE =====
                      SizedBox(
                        width: fieldWidth,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(width: 1.5, color: Color(0xFFF5F5F5)),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () {},
                          icon: Image.asset("images/apple.png", height: 24),
                          label: const Text(
                            "Login With Apple",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Inter",
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // ===== LOGIN BUTTON =====
                      SizedBox(
                        width: fieldWidth,
                        height: 52,
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
                      const SizedBox(height: 25),

                      // ===== DON'T HAVE AN ACCOUNT? SIGN UP =====
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontFamily: "Inter",
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // TODO: لما تضيف صفحة SignUp استبدل بالكود ده:
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Signup(),
                                ),
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Go to Sign Up")),
                              );
                            },
                            child: const Text(
                              "Sign-Up",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Inter",
                                color: Color(0xFF0BA3AC), // تيل
                                //decoration: TextDecoration.underline,
                                decorationColor: AppColors.tealGray,
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
            );
          },
        ),
      ),
    );
  }
}