import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/create_account6.dart';

class CreateAccount4 extends StatefulWidget {
  const CreateAccount4({super.key});

  @override
  State<CreateAccount4> createState() => _CreateAccount4State();
}

class _CreateAccount4State extends State<CreateAccount4> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Center(
          child: Text(
            'What’s your gender?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  color: const Color(0xFF635CA8),
                  width: double.infinity,
                  height: 79,
                  child: const Center(
                    child: Text(
                      "This helps us personalize your fashion\n recommendations",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // --- زر الذكر ---
              _buildGenderButton(
                genderKey: 'male',
                icon: Icons.male,
                label: 'Male',
              ),

              const SizedBox(height: 24),

              // --- زر الأنثى ---
              _buildGenderButton(
                genderKey: 'female',
                icon: Icons.female,
                label: 'Female',
              ),

              const SizedBox(height: 32),

              // مؤشر الخطوات (Step Indicator)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2.5),
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      border: index == 0
                          ? Border.all(color: const Color(0xFF0BA3AC))
                          : null,
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // زر المتابعة (Continue)
              SizedBox(
                width: 320,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0BA3AC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: selectedGender == null
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CreateAccount6(),
                            ),
                          );
                        },
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
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  // ودجت بناء زر اختيار النوع بالتأثير المطلوب
  Widget _buildGenderButton({
    required String genderKey,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = selectedGender == genderKey;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedGender = genderKey;
            });
          },
          child: SizedBox(
            width: 170,
            height: 170,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. الدائرة الخلفية للبوردر والظل السكلي (تظهر فقط عند الاختيار)
                if (isSelected)
                  Positioned(
                    top: 3, // إزاحة بسيطة لتحت عشان البوردر يتركز في الجزء السفلي
                    child: Container(
                      width: 166,
                      height: 166,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white, // أبيض الـ Border
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: const Offset(0, 5), // ظل موجه لتحت فقط
                          ),
                        ],
                      ),
                    ),
                  ),

                // 2. الدائرة الأساسية (المكونة للزر والأيقونة)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isSelected ? 164 : 160,
                  height: isSelected ? 164 : 160,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xFF635CA8) // اللون البنفسجي للمختار
                        : const Color(0xFFCAC8C8), // اللون الرمادي لغير المختار
                  ),
                  child: Icon(
                    icon,
                    size: 110,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}