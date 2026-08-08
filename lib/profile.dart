import 'dart:ui'; // مهمة لتأثير الزجاج (BackdropFilter)
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/colors.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          width: double.infinity,
          color: AppColors.background,
          child: Column(
            children: [
              SizedBox(
                width: 170,
                height: 170,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 65,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/seif.jpg'),
                    ),
                    Positioned(
                      bottom: 33,
                      right: 33,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.tealGray,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: SvgPicture.asset("icons/hugeicons_edit-02.svg"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // المجموعة الأولى
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/solar_user-outline.svg", width: 26, height: 26),
                      title: 'Profile Details',
                      onTap: () {},
                    ),
                    const Divider(
                      color: Color(0xFFEAEAEA),
                      thickness: 1,
                      height: 1,
                    ),
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/material-symbols-light_history-edu-outline-rounded.svg", width: 26, height: 26),
                      title: 'Order History',
                      onTap: () {},
                    ),
                    const Divider(
                      color: Color(0xFFEAEAEA),
                      thickness: 1,
                      height: 1,
                    ),
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/fluent_wallet-credit-card-28-regular.svg", width: 26, height: 26),
                      title: 'Wallet',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // المجموعة الثانية
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/material-symbols-light_language.svg", width: 26, height: 26),
                      title: 'Language',
                      onTap: () {
                        _showLanguageSheet(context);
                      },
                    ),
                    const Divider(
                      color: Color(0xFFEAEAEA),
                      thickness: 1,
                      height: 1,
                    ),
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/policy.svg", width: 26, height: 26),
                      title: 'Privacy Policy',
                      onTap: () {},
                    ),
                    const Divider(
                      color: Color(0xFFEAEAEA),
                      thickness: 1,
                      height: 1,
                    ),
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/terms.svg", width: 26, height: 26),
                      title: 'Terms & Conditions',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              // المجموعة الثالثة
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    buildMenuItem(
                      iconWidget: SvgPicture.asset("icons/solar_shop-outline.svg", width: 26, height: 26),
                      title: 'Shop',
                      onTap: () {},
                    ),
                    const Divider(
                      color: Color(0xFFEAEAEA),
                      thickness: 1,
                      height: 1,
                    ),
                    buildMenuItem(
                      iconWidget: const Icon(Icons.logout, color: Colors.black87, size: 26), // حافظنا على أيقونة اللوج أوت الافتراضية أو يمكنك استبدالها بـ SVG
                      title: 'Logout',
                      onTap: () {
                        _showLogoutDialog(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة إظهار الـ Logout Dialog بشكل زجاجي شفاف ومطابق للصورة في المنتصف
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.3), // خلفية الشاشة سوداء خفيفة
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // تأثير الضباب/الزجاج على الشاشة بالخلف
          child: Dialog(
            backgroundColor: Colors.white.withOpacity(0.25), // لون الحاوية زجاجي شفاف
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: BorderSide(color: Colors.white.withOpacity(0.2), width: 1.5), // حواف زجاجية لامعة
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // أيقونة التحذير الحمراء الكبيرة
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color(0xFFD9534F), // اللون الأحمر للأيقونة الخلفية
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.priority_high_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // نص السؤال
                  const Text(
                    'Are you sure, you want to\nLogout?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // النص واضح داكن
                    ),
                  ),
                  const SizedBox(height: 35),
                  // أزرار التحكم السفلى — Logout بقى نص مجرد بدون خلفية
                  // أو حدود (زي الصورة المرجعية)، وGo back فضل زرار مليان.
                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context); // اقفل الديالوج واعمل اللوجيك هنا
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Color(0xFFD9534F),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context); // العودة
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.tealGray, // نفس درجات ألوان الأزرار لديك
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Go back',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // دالة إظهار صفحة اللغة كـ Bottom Sheet بتطلع من تحت الشاشة لفوق
  // بدل ما تكون Dialog عايمة في نص الشاشة.
  void _showLanguageSheet(BuildContext context) {
    String selected = 'en';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // عشان الشيت ياخد ارتفاعه من المحتوى مش نص الشاشة بس
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.45),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              // بيدي مسافة تلقائية لو الكيبورد فتح أو للـ safe area تحت
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SafeArea(
                top: false,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final pad = (width * 0.07).clamp(16.0, 28.0);
                    final isNarrow = width < 300;

                    final englishOption = _LanguageRadioOption(
                      flag: '🇺🇸',
                      label: 'English',
                      selected: selected == 'en',
                      onTap: () {
                        setState(() => selected = 'en');
                        Navigator.pop(context);
                      },
                    );

                    final arabicOption = _LanguageRadioOption(
                      flag: '🇸🇦',
                      label: 'Arabic',
                      selected: selected == 'ar',
                      onTap: () {
                        setState(() => selected = 'ar');
                        Navigator.pop(context);
                      },
                    );

                    return Padding(
                      padding: EdgeInsets.fromLTRB(pad, pad * 0.7, pad, pad),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // مقبض صغير فوق الشيت (Handle) بيدي إحساس إنه Bottom Sheet قابل للسحب
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              margin: EdgeInsets.only(bottom: pad * 0.8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE0E0E0),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                          const Text(
                            'Language',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: pad),
                          isNarrow
                              ? Column(
                                  children: [
                                    englishOption,
                                    SizedBox(height: pad * 0.6),
                                    arabicOption,
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(child: englishOption),
                                    SizedBox(width: pad * 0.6),
                                    Expanded(child: arabicOption),
                                  ],
                                ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  // تم تعديل الدالة هنا لتستقبل Widget بدلاً من IconData
  Widget buildMenuItem({
    required Widget iconWidget,
    required String title,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 95,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F2F2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: iconWidget, // هنا نقوم بعرض الـ SVG أو الـ Icon الممرر مباشرة
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.chevron_right,
              size: 34,
              color: Color(0xFF8A8A8A),
            ),
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

class _LanguageRadioOption extends StatelessWidget {
  const _LanguageRadioOption({
    required this.flag,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String flag;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  static const Color _teal = Color(0xFF0BA3AC);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFFEAF7F8) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected ? _teal : const Color(0xFFE0E0E0),
              width: selected ? 1.4 : 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 28,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.grey.shade100,
                ),
                child: Text(flag, style: const TextStyle(fontSize: 14)),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: selected ? _teal : Colors.transparent,
                  border: selected
                      ? null
                      : Border.all(
                          color: Colors.grey.shade400,
                          width: 1.5,
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}