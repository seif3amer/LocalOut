import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/colors.dart';
import 'package:project/signup.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final FocusNode emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    emailFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // ===== RESPONSIVE WIDTH CALCULATION =====
            // المتاح هنا هو عرض الشاشة بالكامل ناقص الـ Padding الجانبي (16 يمين + 16 شمال = 32)
            final double availableWidth = constraints.maxWidth - 32;
            
            // هنا بنقوله: خد العرض المتاح كله بشرط ميزيدش عن 343 بكسل
            final double targetWidth = availableWidth > 343 ? 343 : availableWidth;
            
            // حساب متجاوب لعرض الصورة
            final double imageWidth =
                constraints.maxWidth * 0.85 > 304 ? 304 : constraints.maxWidth * 0.85;

            return SingleChildScrollView(
              child: Padding(
                // تثبيت الـ Padding بـ 16 بكسل من كل الجوانب زي ما طلبت
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // يبدأ من الشمال دايماً
                  children: [
                    const SizedBox(height: 20),
                    // ===== IMAGE =====
                    // الصورة بنسيبها في السنتر عشان شكل التصميم
                    Center(
                      child: Image.asset(
                        "images/cactus.png",
                        width: imageWidth,
                        height: imageWidth * (202 / 304),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // ===== TEXTS =====
                    SizedBox(
                      width: targetWidth,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Forget Password",
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Enter your register email below",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFFCCCCCC),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // ===== EMAIL LABEL =====
                    SizedBox(
                      width: targetWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset('icons/email.svg'),
                          const SizedBox(width: 8),
                          const Text("Email", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // ===== EMAIL TEXTFIELD =====
                    Padding(
                      padding: const EdgeInsets.only( right: 16),
                      child: SizedBox(
                        width: double.infinity, // هيكبر لحد 343 كحد أقصى وهيكون ريسبونسيف
                        height: 48,
                        child: TextField(
                          focusNode: emailFocusNode,
                          cursorColor: AppColors.tealGray,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'Enter email address',
                            hintStyle: const TextStyle(
                              color: Color(0xFFCCCCCC),
                              fontSize: 14,
                            ),
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
                    const SizedBox(height: 8),
                    
                    // ===== REMEMBER PASSWORD / SIGN UP =====
                    SizedBox(
                      width: targetWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Remember the password?? ",
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
                                color: AppColors.tealGray,
                                decorationColor: AppColors.tealGray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 61),
                    
                    // ===== SUBMIT BUTTON =====
                    Center(
                      child: SizedBox(
                        width: targetWidth, // واخد نفس المحاذاة والعرض ليكون متناسق مع الحقل
                        height: 44,
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
                            "Submit",
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
                    const SizedBox(height: 25),
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