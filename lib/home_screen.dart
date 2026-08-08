

import 'dart:ui'; // مطلوب لتأثير الـ Blur والـ Glass
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';
import 'package:project/FilterBottomSheet.dart';
import 'package:project/multi_stage_filter_sheet.dart';
import 'custom_bottom_nav.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 0 = All, وبعدين كل براند بمكانه في اللستة
  int _currentIndex = 2;
  int _selectedBrandIndex = 0;
  bool isFavorite = true;
  List<String> selectedCategories = ['Jackets']; // اللستة اللي هتحفظ الاختيارات
  final List<String> categories = ['Jackets', 'Pants', 'Shorts', 'Skirts', 'Accessories', 'Hoodies', 'socks'];
  final GlobalKey _categoryButtonKey = GlobalKey(); // مفتاح الزرار عشان نجيب مكانه بالظبط
  OverlayEntry? _categoryOverlay; // الدروب داون بتاع الكاتيجوري اللي بيفتح تحت الزرار

  // === (1) حالة التفعيل (Selected State) لزرار المنيو وزرار الكاتيجوري ===
  // بتتفعل (تركواز + أيقونة/نص أبيض) طول ما البوب أب/الشيت فاتح، وترجع
  // لحالتها العادية أول ما يتقفل. نفس منطق شرائح البراند (All/Adidas/...).
  bool _isMenuActive = false;
  bool _isCategoryActive = false;

  // === (جديد) حالة التركيز على السيرش بار: بتفعّل البوردر تركواز لما
  // اليوزر يضغط في السيرش عشان يكتب، وترجع تاني لما يبعد ===
  final FocusNode _searchFocusNode = FocusNode();
  bool _isSearchFocused = false;

  // عدل المسارات دي على حسب أسماء صور الشركات عندك
  final List<Map<String, String>> _brands = [
    {'name': 'All', 'logo': ''},
    {'name': 'Adidas', 'logo': 'images/fila-9 1.png'},
    {'name': 'Nike', 'logo': 'images/fila-9 1.png'},
    {'name': 'Fila', 'logo': 'images/fila-9 1.png'},
    {'name': 'Puma', 'logo': 'images/fila-9 1.png'},
  ];

  // اللون التركواز المختار مثل الصورة تماماً
  static const Color selectedColor = AppColors.tealGray;

  @override
  void initState() {
    super.initState();
    // نراقب حالة الفوكس بتاعة السيرش بار عشان نغيّر لون البوردر
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _removeCategoryDropdown();
    super.dispose();
  }

  // -----------------------------------------------------------------
  // دروب داون الكاتيجوري: بيفتح كارت صغير تحت الزرار بالظبط (مش بوتوم
  // شيت من تحت الشاشة كله)، فيه Checkbox لكل كاتيجوري زي ما كان قبل كده.
  // -----------------------------------------------------------------
  void _toggleCategoryDropdown() {
    if (_categoryOverlay != null) {
      _removeCategoryDropdown();
      return;
    }

    final RenderBox? buttonBox =
        _categoryButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (buttonBox == null) return;

    final Offset buttonPosition = buttonBox.localToGlobal(Offset.zero);
    final Size buttonSize = buttonBox.size;
    final Size screenSize = MediaQuery.of(context).size;
    const double dropdownWidth = 230;

    // نخلي الدروب داون محاذي لحافة الزرار اليمين، وما يخرجش برا الشاشة
    double left = buttonPosition.dx + buttonSize.width - dropdownWidth;
    if (left < 12) left = 12;
    if (left + dropdownWidth > screenSize.width - 12) {
      left = screenSize.width - 12 - dropdownWidth;
    }
    final double top = buttonPosition.dy + buttonSize.height + 8;

    // (1) فعّل شكل الزرار المختار أول ما يفتح الدروب داون
    setState(() {
      _isCategoryActive = true;
    });

    _categoryOverlay = OverlayEntry(
      builder: (overlayContext) {
        return Stack(
          children: [
            // طبقة شفافة تقفل الدروب داون لو ضغطت في أي مكان تاني
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removeCategoryDropdown,
                child: Container(color: Colors.transparent),
              ),
            ),
            Positioned(
              left: left,
              top: top,
              width: dropdownWidth,
              child: Material(
                color: Colors.transparent,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    return Container(
                      constraints: const BoxConstraints(maxHeight: 320),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: categories.map((category) {
                            final bool isSelected = selectedCategories.contains(category);
                            return InkWell(
                              onTap: () {
                                menuSetState(() {
                                  if (isSelected) {
                                    selectedCategories.remove(category);
                                  } else {
                                    selectedCategories.add(category);
                                  }
                                });
                                setState(() {});
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: isSelected,
                                      onChanged: (value) {
                                        menuSetState(() {
                                          if (value == true) {
                                            selectedCategories.add(category);
                                          } else {
                                            selectedCategories.remove(category);
                                          }
                                        });
                                        setState(() {});
                                      },
                                      activeColor: AppColors.tealGray,
                                      checkColor: Colors.white,
                                      side: const BorderSide(color: Colors.black54, width: 2),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );

    Overlay.of(context).insert(_categoryOverlay!);
  }

  void _removeCategoryDropdown() {
    _categoryOverlay?.remove();
    _categoryOverlay = null;
    // (1) رجّع الزرار لحالته العادية أول ما الدروب داون يتقفل
    if (mounted && _isCategoryActive) {
      setState(() {
        _isCategoryActive = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  // 1. الصورة الخلفية الأساسية (السماء) - العرض كامل والارتفاع 249 مع رواندد من تحت
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                    child: Image.asset(
                      'images/home.png',
                      width: double.infinity,
                      height: 249,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // 2. بلور (Blur) خفيف على نفس مساحة الصورة فقط (249 ارتفاع)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 249,
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                        child: Container(
                          color: Colors.black.withOpacity(0.02), // طبقة خفيفة جداً لتثبيت الفلتر
                        ),
                      ),
                    ),
                  ),

                  // 3. المحتوى الأمامي بالكامل
                  SafeArea(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 70),
                            // --- الجزء العلوي (الملف الشخصي والاشعارات) ---
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    // الصورة الشخصية دائرية
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundColor: Colors.white24,
                                      backgroundImage: const AssetImage('images/seif.jpg'),
                                    ),
                                    const SizedBox(width: 16),
                                    // النصوص بجانب الصورة
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Hello Alex!',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold,
                                            shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const Icon(Icons.location_on_outlined, color: Colors.white70, size: 18),
                                            const SizedBox(width: 4),
                                            Text(
                                              'Cairo, Egypt',
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.8),
                                                fontSize: 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // زر الإشعارات بتأثير الجلاس (Glass Notification Button)
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: Container(
                                      width: 54,
                                      height: 54,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.15),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.white.withOpacity(0.25), width: 1.5),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: SvgPicture.asset("icons/bell.svg"),
                                          ),
                                          // النقطة الحمراء للإشعار
                                          Positioned(
                                            top: 14,
                                            right: 14,
                                            child: Container(
                                              width: 9,
                                              height: 9,
                                              decoration: const BoxDecoration(
                                                color: Colors.redAccent,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // --- السيرش بار بتأثير الجلاس (Glass Search Bar) ---
                            // === (جديد) البوردر بيبقى تركواز (tealGray) لما اليوزر
                            // يضغط جوه السيرش بار عشان يكتب، ويرجع شفاف تاني لما يبعد ===
                            ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  height: 68,
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(35),
                                    border: Border.all(
                                      color: _isSearchFocused
                                          ? AppColors.tealGray
                                          : Colors.white.withOpacity(0.25),
                                      width: 1.8,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      SvgPicture.asset("icons/search.svg"),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: TextField(
                                          focusNode: _searchFocusNode,
                                          cursorColor: AppColors.tealGray,
                                          style: const TextStyle(color: Colors.white, fontSize: 18),
                                          decoration: InputDecoration(
                                            focusColor: AppColors.tealGray,
                                            hintText: 'Find your perfect Outfit',
                                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 17),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      // === (1) زرار المنيو: بيتفعل (تركواز + أيقونة بيضا) طول
                                      // ما شيت الفلتر فاتح، ويرجع لحالته العادية لما يتقفل ===
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: IconButton(
                                          onPressed: () {
                                            // فعّل الزرار قبل ما نفتح الشيت
                                            setState(() {
                                              _isMenuActive = true;
                                            });
                                      
                                            // قايمة الفلتر بتطلع من تحت الشاشة (Bottom Sheet)
                                            showModalBottomSheet<void>(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) {
                                                return DraggableScrollableSheet(
                                                  initialChildSize: 0.75,
                                                  minChildSize: 0.4,
                                                  maxChildSize: 0.95,
                                                  expand: false,
                                                  builder: (context, scrollController) {
                                                    return Container(
                                                      decoration: const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(24),
                                                          topRight: Radius.circular(24),
                                                        ),
                                                      ),
                                                      child: const FilterBottomSheet(),
                                                    );
                                                  },
                                                );
                                              },
                                            ).whenComplete(() {
                                              // ارجع لحالته العادية أول ما الشيت يتقفل
                                              if (mounted) {
                                                setState(() {
                                                  _isMenuActive = false;
                                                });
                                              }
                                            });
                                          },
                                          icon: SvgPicture.asset(
                                            "icons/menu.svg",
                                            colorFilter: _isMenuActive
                                                ? const ColorFilter.mode(AppColors.tealGray, BlendMode.srcIn)
                                                : null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            Row(
                              children: [
                                const Text(
                                  "Choose Brand",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.tealGray),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 13),

                            // --- صف اختيار البراند مع ميزة التغيير الديناميكي الكامل عند الضغط ---
                            SizedBox(
                              height: 56,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                itemCount: _brands.length,
                                separatorBuilder: (context, index) => const SizedBox(width: 14),
                                itemBuilder: (context, index) {
                                  final bool isSelected = _selectedBrandIndex == index;
                                  final bool isAll = index == 0;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedBrandIndex = index;
                                      });
                                    },
                                    child: AnimatedContainer(
                                      duration: const Duration(milliseconds: 250), // حركة ناعمة جداً أثناء التحول
                                      width: isAll ? 56 : null,
                                      padding: isAll
                                          ? EdgeInsets.zero
                                          : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                      decoration: BoxDecoration(
                                        // يتغير اللون للتركواز لأي زر يتم اختياره، وإلا يظل أبيض صريح
                                        color: isSelected ? selectedColor : Colors.white,
                                        shape: isAll ? BoxShape.circle : BoxShape.rectangle,
                                        borderRadius: isAll ? null : BorderRadius.circular(16),
                                        boxShadow: [
                                          BoxShadow(
                                            color: isSelected
                                                ? selectedColor.withOpacity(0.3) // يعطي توهج خفيف للزر المختار
                                                : Colors.black.withOpacity(0.05),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: isAll
                                            ? Text(
                                                'All',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  // لون الخط يتغير بناءً على الاختيار
                                                  color: isSelected ? Colors.white : Colors.black87,
                                                ),
                                              )
                                            : Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    _brands[index]['logo']!,
                                                    height: 24,
                                                    width: 24,
                                                    fit: BoxFit.contain,
                                                    // السطر التالي يغير لون شعار الشركة للأبيض إذا تم اختيارها لكي تظهر بوضوح فوق التركواز
                                                    color: isSelected ? Colors.white : null,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    _brands[index]['name']!,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold,
                                                      // لون اسم الشركة يصبح أبيض عند الاختيار، وأسود عند عدم الاختيار
                                                      color: isSelected ? Colors.white : Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            // === (3) صف "365 Items / Category" بيتخفي بالكامل لما البراند
                            // المختار يكون "All"، وبيظهر تاني بسلاسة لأي براند تاني ===
                            AnimatedSize(
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeInOut,
                              child: _selectedBrandIndex == 0
                                  ? const SizedBox(width: double.infinity, height: 0)
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 32),
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("365 Items", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                                Text("Available in stock", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.grey),),
                                              ],
                                            ),
                                            Spacer(),
                                            // === (1) زرار الكاتيجوري: بيتفعل (تركواز + أيقونة/نص
                                            // أبيض) طول ما الدروب داون فاتح ===
                                            InkWell(
                                              key: _categoryButtonKey,
                                              onTap: _toggleCategoryDropdown,
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 200),
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 12,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: _isCategoryActive ? AppColors.tealGray : Colors.white,
                                                  borderRadius: BorderRadius.circular(15),
                                                  border: Border.all(
                                                    color: _isCategoryActive
                                                        ? AppColors.tealGray
                                                        : const Color(0xFFDCDCDC),
                                                    width: 1.9,
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.06),
                                                      blurRadius: 10,
                                                      spreadRadius: 1,
                                                      offset: const Offset(0, 5),
                                                    ),
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Icon(
                                                      Icons.sort_rounded,
                                                      color: _isCategoryActive ? Colors.white : Colors.black,
                                                      size: 24,
                                                    ),
                                                    const SizedBox(width: 12),
                                                    Text(
                                                      'Category',
                                                      style: TextStyle(
                                                        color: _isCategoryActive
                                                            ? Colors.white
                                                            : const Color(0xFF1A1A1A),
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.3,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                            ),

                            SizedBox(height: 16,),
                            Row(
                              children: [
                                Text("New Arrival", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                SizedBox(width: 6,),
                                SvgPicture.asset("icons/streamline-ultimate_reward-stars-4-bold.svg"),
                                Spacer(),
                                TextButton(
                                  onPressed: () {
                                    showGlassCenterSheet(
                                      context,
                                      const MultiStageFilterSheet(),
                                    );
                                  },
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.tealGray),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),

                                      SizedBox(width: 17,),

                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),

                                      SizedBox(width: 17,),

                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),
                              // كمل باقي عناصر صفحتك هنا..
                                                  ],
                                                ),
                            ),


                            SizedBox(height: 32,),
                            Row(
                              children: [
                                Text("Offers", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                SizedBox(width: 6,),
                                SvgPicture.asset("icons/bxs_offer.svg"),
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.tealGray),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),

                                      SizedBox(width: 17,),

                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),

                                      SizedBox(width: 17,),

                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),
                              // كمل باقي عناصر صفحتك هنا..
                                                  ],
                                                ),
                            ),



                            SizedBox(height: 32,),
                            Row(
                              children: [
                                Text("Top Selling", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                SizedBox(width: 6,),
                                SvgPicture.asset("icons/bxs_hot.svg"),
                                Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "View All",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.tealGray),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16,),

                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),

                                      SizedBox(width: 17,),

                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),

                                      SizedBox(width: 17,),

                                      Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                        Container(
                                          width: 220,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(255, 255, 255, 255), // خلفية الكارت الرمادي الفاتح
                                            borderRadius: BorderRadius.circular(24),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.06),
                                                blurRadius: 20,
                                                spreadRadius: 2,
                                                offset: const Offset(0, 6),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // الجزء الخاص بالصورة وزرار القلب
                                              Stack(
                                                children: [
                                                  // الصورة بحواف دائرية
                                                  ClipRRect(
                                                    borderRadius: BorderRadius.circular(18),
                                                    child: Image.asset(
                                                      "images/Tshirt.png",
                                                      width: double.infinity,
                                                      height: 240,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),

                                                  // زرار القلب - جوه حدود الكارت
                                                  Positioned(
                                                    top: 5,
                                                    right: 5,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          isFavorite = !isFavorite;
                                                        });
                                                      },
                                                      child: AnimatedContainer(
                                                        duration: const Duration(milliseconds: 200),
                                                        padding: const EdgeInsets.all(8),
                                                        decoration: BoxDecoration(
                                                          color: Colors.white.withOpacity(0.39),
                                                          shape: BoxShape.circle,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.1),
                                                              blurRadius: 6,
                                                              spreadRadius: 0.5,
                                                              offset: const Offset(0, 2),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Icon(
                                                          isFavorite ? Icons.favorite : Icons.favorite_border,
                                                          color: isFavorite ? Colors.red : Colors.grey.shade400,
                                                          size: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8,),
                                        Text("Nike Sportswear\n Club Fleece", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                        Text("L.E 600", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                                      ]
                                      ,),
                              // كمل باقي عناصر صفحتك هنا..
                                                  ],
                                                ),
                            ),
                          ],
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

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        cartItemCount: 3, // عدد المنتجات في السلة
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

/// ودجت مساعد بيفتح أي شاشة (زي الفلتر) في **نص الشاشة** بدل ما تطلع من تحت،
/// وبيدي تأثير "جلاس" (بلور شفاف) خلفها بدل الخلفية السودة العادية.
/// اتضاف عشان نستخدمه بدل showModalBottomSheet في أي مكان محتاج نفس المنطق.
Future<T?> showGlassCenterSheet<T>(BuildContext context, Widget child) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withOpacity(0.35),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, animation, secondaryAnimation) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: Center(
          child: Material(
            type: MaterialType.transparency,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.92,
                maxHeight: MediaQuery.of(context).size.height * 0.85,
              ),
              child: child,
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}