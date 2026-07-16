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
                  focusNode: passwordFocusNode,
                  cursorColor: AppColors.tealGray,
                  obscureText: isHidden,
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
                  focusNode: password2FocusNode,
                  cursorColor: AppColors.tealGray,
                  obscureText: isHidden,
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
                          onPressed: () {},
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
}