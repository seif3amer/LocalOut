import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final FocusNode emailFocusNode = FocusNode();
  bool isHidden = true;
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode password2FocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  
  bool _obscureConfirmPassword = true;

  bool _passwordTouched = false;
  bool _confirmTouched = false;

  // ===== PASSWORD RULES =====
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
  void initState() {
    super.initState();
    // عشان اللون بتاع فوكاس الفيلدز يتحدث لما تدوس عليها (زي الباقي بالظبط)
    emailFocusNode.addListener(() => setState(() {}));
    passwordFocusNode.addListener(() => setState(() {}));
    password2FocusNode.addListener(() => setState(() {}));
    nameFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    password2FocusNode.dispose();
    nameFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 84),
                  const Center(
                    child: Text(
                      "Hello!",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: "kreon",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                        
                  const SizedBox(height: 12),
                        
                  const Center(
                    child: Text(
                      "Sign-up to your Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(204, 204, 204, 1),
                      ),
                    ),
                  ),
                        
                  const SizedBox(height: 40),
                        
                  // ===== NAME =====
                   Padding(
                     padding: const EdgeInsets.only(left: 16),
                     child: Row(
                      children: [
                        SvgPicture.asset("icons/solar_user-outline.svg"),
                        SizedBox(width: 8),
                        Text(
                          "Name",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                                       ),
                   ),
                        
                  const SizedBox(height: 12),
                        
                  Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextField(
                            controller: _nameController,
                            focusNode: nameFocusNode,
                            cursorColor: AppColors.tealGray,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Enter your name',
                              hintStyle: const TextStyle(
                                color: Color(0xFFCCCCCC),
                                fontSize: 14,
                              ),
                          
                              filled: true,
                          
                              fillColor: nameFocusNode.hasFocus
                                  ? const Color.fromARGB(128, 234, 248, 249) // اللون أثناء الكتابة
                                  : const Color.fromRGBO(245, 245, 245, 1),// اللون العادي
                          
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
                        
                  // ===== EMAIL =====
                   Padding(
                     padding: const EdgeInsets.only(left: 16),
                     child: Row(
                      children: [
                        SvgPicture.asset("icons/email.svg"),
                        SizedBox(width: 8),
                        Text(
                          "Email",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                                       ),
                   ),
                        
                  const SizedBox(height: 12),
                        
                  Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: TextField(
                            controller: _emailController,
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
                                  ? const Color.fromARGB(128, 234, 248, 249) // اللون أثناء الكتابة
                                  : const Color.fromRGBO(245, 245, 245, 1), // اللون العادي
                          
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
                        
                  // ===== PASSWORD =====
                   Padding(
                     padding: const EdgeInsets.only(left: 16,),
                     child: Row(
                      children: [
                        SvgPicture.asset("icons/new_passowrd.svg"),
                        
                        SizedBox(width: 8),
                        Text(
                          "Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                                       ),
                   ),
                        
                  const SizedBox(height: 12),
                        
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
                        : const Color.fromRGBO(245, 245, 245, 1), // اللون العادي
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
                  // ===== PASSWORD VALIDATION HINTS =====
                  if (_passwordTouched && !_passwordValid) ...[
                    const SizedBox(height: 8),
                    _buildValidationList(),
                  ],
                        
                  const SizedBox(height: 20),
                        
                  // ===== CONFIRM PASSWORD =====
                   Padding(
                     padding: const EdgeInsets.only(left: 16,),
                     child: Row(
                      children: [
                        SvgPicture.asset("icons/qlementine-icons_password-16.svg"),
                        SizedBox(width: 8),
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                     ),
                   ),
                        
                  const SizedBox(height: 12),
                        
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: TextField(
                        controller: _confirmPasswordController,
                        focusNode: password2FocusNode,
                        cursorColor: AppColors.tealGray,
                        obscureText: _obscureConfirmPassword,
                        onChanged: (_) => setState(() {
                          _confirmTouched = true;
                        }),
                        decoration: InputDecoration(
                          hintText: 'Confirm password',
                          hintStyle: const TextStyle(color: Color(0xFFCCCCCC), fontSize: 14),
                          filled: true,
                          fillColor: password2FocusNode.hasFocus
                              ? const Color.fromARGB(128, 234, 248, 249) // اللون أثناء الكتابة زي الباقي
                              : const Color.fromRGBO(245, 245, 245, 1), // اللون العادي
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
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () => setState(() =>
                                _obscureConfirmPassword = !_obscureConfirmPassword),
                          ),
                        ),
                      ),
                    ),
                  ),
                        
                  // ===== CONFIRM PASSWORD ERROR =====
                  if (_confirmTouched &&
                      _confirmPasswordController.text.isNotEmpty &&
                      !_passwordsMatch) ...[
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: const [
                          Icon(Icons.error_outline,
                              color: Colors.red, size: 16),
                          SizedBox(width: 6),
                          Text(
                            "Password not matched",
                            style: TextStyle(color: Colors.red, fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  ],
                        
                  const SizedBox(height: 32),
                        
                  // ===== OR =====
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child:
                              Text("OR", style: TextStyle(color: Colors.grey)),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                        
                  const SizedBox(height: 41),
                        
                  // ===== LOGIN WITH GOOGLE =====
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {},
                        icon: Image.asset("images/google.png", height: 24),
                        label: const Text(
                          "Continue With Google",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                        
                  const SizedBox(height: 16),
                        
                  // ===== LOGIN WITH APPLE =====
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        onPressed: () {},
                        icon: Image.asset("images/apple.png", height: 24),
                        label: const Text(
                          "Continue With Apple",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                        
                  const SizedBox(height: 30),
                        
                  // ===== CONTINUE BUTTON =====
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0BA3AC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _passwordValid && _passwordsMatch
                            ? () {
                                // TODO: Navigator للـ next screen
                              }
                            : null,
                        child: const Text(
                          "Continue",
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
          ),
        ),
      ),
    );
  }

  // ===== PASSWORD VALIDATION LIST WIDGET =====
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