import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // كلمات البحث المقترحة/الأخيرة — التلاشي التدريجي في الشفافية بيبان
  // بوضوح في آخر 3 عناصر زي التصميم بالظبط.
  final List<String> _keywords = <String>[
    'Nike',
    'Pants',
    'T-shirts',
    'Hoodie',
    'long sleeves',
    'shorts',
    'socks',
    'winter collections',
    'suits',
    'Blue',
  ];

  @override
  void initState() {
    super.initState();
    // بنعمل rebuild لما الفوكس يتغير عشان لون فيلد البحث يتحدث
    // (fieldFocus) زي بقية الفيلدز في البروجيكت.
    _searchFocusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // درجة الشفافية لكل كلمة — أول الكلمات واضحة بالكامل وبعدين بتتلاشى
  // تدريجياً زي ما هو ظاهر في التصميم.
  double _opacityFor(int index) {
    const List<double> fadeMap = [1, 1, 1, 1, 1, 1, 1, 0.55, 0.35, 0.2];
    if (index < fadeMap.length) return fadeMap[index];
    return 0.2;
  }

  void _selectKeyword(String keyword) {
    setState(() {
      _searchController.text = keyword;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: keyword.length),
      );
    });
    _searchFocusNode.requestFocus();
  }

  void _clearHistory() {
    setState(() {
      // TODO: نادِ هنا على اللوجيك الفعلي لمسح سجل البحث (Local storage/API)
      _keywords.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildSearchBar(),
              const SizedBox(height: 28),
              Expanded(child: _buildKeywordsSection()),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // فيلد البحث — Pill شكل بيضاوي بحدود tealGray، أيقونة بحث SVG
  // جوه الفيلد، وزرار X خارجه لإقفال شاشة البحث.
  // =====================================================
  Widget _buildSearchBar() {
    final bool isFocused = _searchFocusNode.hasFocus;
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: isFocused ? AppColors.fieldFocus : AppColors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.tealGray, width: 1.2),
            ),
            child: TextField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              autofocus: true,
              cursorColor: AppColors.tealGray,
              style: const TextStyle(fontSize: 15, color: AppColors.black),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                hintText: 'Enter your keyword',
                hintStyle: const TextStyle(color: AppColors.gray, fontSize: 15),
                prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: SvgPicture.asset(
                    'icons/search.svg',
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(AppColors.black, BlendMode.srcIn),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            _searchController.clear();
            Navigator.of(context).maybePop();
          },
          child: const Icon(Icons.close, color: AppColors.black, size: 24),
        ),
      ],
    );
  }

  // =====================================================
  // قائمة الكلمات — أول كلمة (Nike) و"Clear" في نفس السطر زي
  // التصميم، والباقي تحتها بالتلاشي التدريجي.
  // =====================================================
  Widget _buildKeywordsSection() {
    if (_keywords.isEmpty) {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: _buildKeywordItem(0)),
              GestureDetector(
                onTap: _clearHistory,
                child: const Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          ...List.generate(
            _keywords.length - 1,
            (i) => _buildKeywordItem(i + 1),
          ),
        ],
      ),
    );
  }

  Widget _buildKeywordItem(int index) {
    return Opacity(
      opacity: _opacityFor(index),
      child: InkWell(
        onTap: () => _selectKeyword(_keywords[index]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            _keywords[index],
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}