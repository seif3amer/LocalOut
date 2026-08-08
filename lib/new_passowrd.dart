import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/colors.dart';

class NewPassowrd extends StatefulWidget {
  const NewPassowrd({super.key});

  @override
  State<NewPassowrd> createState() => _NewPassowrdState();
}

class _NewPassowrdState extends State<NewPassowrd> {
  bool isHidden = true;
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode password2FocusNode = FocusNode();

  // === اتضافوا من كود الـ Signup: كنترولرز عشان نقدر نقرا/نتابع
  // قيمة كل فيلد ونطبق عليها منطق التحقق ===
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordTouched = false;
  bool _confirmTouched = false;

  // ===== PASSWORD RULES (نفس اللي في Signup بالظبط) =====
  bool get _hasUpperAndLower =>
      _passwordController.text.contains(RegExp(r'[A-Z]')) &&
      _passwordController.text.contains(RegExp(r'[a-z]'));

  bool get _hasNumber =>
      _passwordController.text.contains(RegExp(r'[0-9]'));

  bool get _hasSymbol =>
      _passwordController.text.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]'));

  bool get _hasMinLength => _passwordController.text.length >= 8;

  bool get _passwordValid =>
      _hasUpperAndLower && _hasNumber && _hasSymbol && _hasMinLength;

  bool get _passwordsMatch =>
      _passwordController.text == _confirmPasswordController.text;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    passwordFocusNode.dispose();
    password2FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
       child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 79,),
            Center(child: Image.asset("images/new_password.png", width: 304, height: 203,)),
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Change New Password", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            ),
            SizedBox(height: 8,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Enter your new password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 204, 204, 204)),),
            ),
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  SvgPicture.asset("icons/new_passowrd.svg"),
                  SizedBox(width: 8,),
                  Text("New password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: TextField(
                  controller: _passwordController,
                  focusNode: passwordFocusNode,
                  cursorColor: AppColors.tealGray,
                  obscureText: isHidden,
                  onChanged: (_) => setState(() {
                    _passwordTouched = true;
                  }),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
                    filled: true,
                    fillColor: passwordFocusNode.hasFocus
                        ? const Color.fromARGB(128, 234, 248, 249) // اللون أثناء الكتابة زي الإيميل
                        : const Color(0xFFF5F5F5), // اللون العادي
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
                        isHidden ? Icons.visibility_off : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ===== PASSWORD VALIDATION HINTS (زي الي في Signup بالظبط) =====
            if (_passwordTouched && !_passwordValid) ...[
              const SizedBox(height: 8),
              _buildValidationList(),
            ],

            SizedBox(height: 16,),

            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  SvgPicture.asset("icons/qlementine-icons_password-16.svg"),
                  SizedBox(width: 8,),
                  Text("New password", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: TextField(
                  controller: _confirmPasswordController,
                  focusNode: password2FocusNode,
                  cursorColor: AppColors.tealGray,
                  obscureText: isHidden,
                  onChanged: (_) => setState(() {
                    _confirmTouched = true;
                  }),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
                    filled: true,
                    fillColor: passwordFocusNode.hasFocus
                        ? const Color.fromARGB(128, 234, 248, 249) // اللون أثناء الكتابة زي الإيميل
                        : const Color(0xFFF5F5F5), // اللون العادي
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
                        isHidden ? Icons.visibility_off : Icons.visibility_outlined,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // ===== CONFIRM PASSWORD ERROR (زي الي في Signup بالظبط) =====
            if (_confirmTouched &&
                _confirmPasswordController.text.isNotEmpty &&
                !_passwordsMatch) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: const [
                    Icon(Icons.error_outline, color: Colors.red, size: 16),
                    SizedBox(width: 6),
                    Text(
                      "Password not matched",
                      style: TextStyle(color: Colors.red, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],

            SizedBox(height: 32,),
            Center(
                      child: SizedBox(
                        width: 343, // واخد نفس المحاذاة والعرض ليكون متناسق مع الحقل
                        height: 44,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tealGray,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0,
                          ),
                          // الزرار بيتفعّل بس لما الباسورد يكون مستوفي الشروط
                          // والاتنين متطابقين، زي منطق الـ Continue في Signup.
                          onPressed: _passwordValid && _passwordsMatch
                              ? () {}
                              : null,
                          child: const Text(
                            "Reset password",
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

            
          ],
        ),
      ),
    );
  }

  // ===== PASSWORD VALIDATION LIST WIDGET (نفس اللي في Signup بالظبط) =====
  Widget _buildValidationList() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 16),
              const SizedBox(width: 6),
              const Text(
                "Password must contain:",
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 4),
          _validationItem("Uppercase & lowercase", _hasUpperAndLower),
          _validationItem("Number", _hasNumber),
          _validationItem("Symbol", _hasSymbol),
          _validationItem("8+ Characters", _hasMinLength),
        ],
      ),
    );
  }

  Widget _validationItem(String text, bool isValid) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 2),
      child: Row(
        children: [
          Icon(
            isValid ? Icons.check_circle_outline : Icons.circle_outlined,
            size: 14,
            color: isValid ? Colors.green : Colors.red,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: isValid ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}