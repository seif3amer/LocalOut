// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:project/colors.dart';

// class FilterBottomSheet extends StatefulWidget {
//   const FilterBottomSheet({super.key});

//   @override
//   State<FilterBottomSheet> createState() => _FilterBottomSheetState();
// }

// class _FilterBottomSheetState extends State<FilterBottomSheet> {
//   // State variables
//   String? _selectedGender;
//   String _selectedCategory = 'All';
//   String? _selectedSize;

//   // Controllers
//   final TextEditingController _minPriceController = TextEditingController();
//   final TextEditingController _maxPriceController = TextEditingController();

//   // Static options
//   final List<String> _genders = ['Men', 'Women', 'Unisex'];
//   final List<String> _categories = [
//     'All',
//     'Shoes',
//     'T-Shirts',
//     'Pants',
//     'Jackets',
//     'Accessories'
//   ];
//   final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

//   // Styling palette constants
//   static const Color unselectedBg = Color(0xFFF3F4F6);

//   // بيرجع true لو اليوزر فعلاً اختار/كتب أي حاجة تخالف الوضع الافتراضي
//   bool get _hasActiveFilters {
//     return _selectedGender != null ||
//         _selectedCategory != 'All' ||
//         _selectedSize != null ||
//         _minPriceController.text.trim().isNotEmpty ||
//         _maxPriceController.text.trim().isNotEmpty;
//   }

//   @override
//   void initState() {
//     super.initState();
//     // نعمل listen على حقول السعر عشان أي كتابة فيها تحدّث حالة زرار الـ Reset
//     _minPriceController.addListener(_onFiltersMaybeChanged);
//     _maxPriceController.addListener(_onFiltersMaybeChanged);
//   }

//   void _onFiltersMaybeChanged() {
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _minPriceController.removeListener(_onFiltersMaybeChanged);
//     _maxPriceController.removeListener(_onFiltersMaybeChanged);
//     _minPriceController.dispose();
//     _maxPriceController.dispose();
//     super.dispose();
//   }

//   void _resetAll() {
//     FocusScope.of(context).unfocus();
//     setState(() {
//       _selectedGender = null;
//       _selectedCategory = 'All';
//       _selectedSize = null;
//       _minPriceController.clear();
//       _maxPriceController.clear();
//     });
//   }

//   void _applyFilters() {
//     Navigator.pop(context, {
//       "gender": _selectedGender,
//       "category": _selectedCategory,
//       "size": _selectedSize,
//       "minPrice": _minPriceController.text.trim(),
//       "maxPrice": _maxPriceController.text.trim(),
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);

//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: mediaQuery.size.height * 0.62,
//       ),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         border: Border(
//           top: BorderSide(
//             color: AppColors.tealGray,
//             width: 1.5,
//           )
//         ),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24.0),
//           topRight: Radius.circular(24.0),
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // 1. Drag Handle
//             const SizedBox(height: 12),
//             Container(
//               width: 40,
//               height: 4,
//               decoration: BoxDecoration(
//                 color: Colors.grey,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//             const SizedBox(height: 16),

//             // 2. Header Row
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Opacity(
//                     opacity: 0,
//                     child: Text('Reset', style: TextStyle(fontSize: 16)),
//                   ),
//                   const Text(
//                     'Filters',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                   ),
//                   TextButton(
//                     // لو مفيش أي فلتر فعّال، الزرار بيتعطل تلقائيًا (onPressed = null)
//                     onPressed: _hasActiveFilters ? _resetAll : null,
//                     style: TextButton.styleFrom(
//                       foregroundColor: AppColors.tealGray,
//                       disabledForegroundColor: Colors.grey.shade400,
//                       padding: EdgeInsets.zero,
//                       minimumSize: Size.zero,
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                     child: const Text(
//                       'Reset',
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 24, thickness: 1),

//             // 3. Scrollable Body Contents
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: const ClampingScrollPhysics(),
//                 padding: EdgeInsets.only(
//                   left: 20.0,
//                   right: 20.0,
//                   bottom: mediaQuery.viewInsets.bottom + 20.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _buildSectionTitle('Gender'),
//                     const SizedBox(height: 12),
//                     _buildGenderSelection(),
//                     const SizedBox(height: 24),

//                     _buildSectionTitle('Category'),
//                     const SizedBox(height: 12),
//                     _buildCategoryDropdown(),
//                     const SizedBox(height: 24),

//                     _buildSectionTitle('Size'),
//                     const SizedBox(height: 12),
//                     _buildSizeSelection(),
//                     const SizedBox(height: 24),

//                     _buildSectionTitle('Price'),
//                     const SizedBox(height: 12),
//                     _buildPriceFields(),
//                     const SizedBox(height: 32),
//                   ],
//                 ),
//               ),
//             ),

//             // 4. Sticky Apply Button
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: SizedBox(
//                 width: double.infinity,
//                 height: 52,
//                 child: ElevatedButton(
//                   onPressed: _applyFilters,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.tealGray,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(26.0),
//                     ),
//                     elevation: 0,
//                   ),
//                   child: const Text(
//                     'Apply',
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontSize: 16,
//         fontWeight: FontWeight.bold,
//         color: Colors.black,
//       ),
//     );
//   }

//   Widget _buildGenderSelection() {
//     return Row(
//       children: _genders.map((gender) {
//         final isSelected = _selectedGender == gender;
//         return Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 4.0),
//             child: GestureDetector(
//               onTap: () {
//                 setState(() {
//                   _selectedGender = gender;
//                 });
//               },
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 200),
//                 curve: Curves.easeInOut,
//                 alignment: Alignment.center,
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: isSelected ? AppColors.tealGray : unselectedBg,
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   gender,
//                   style: TextStyle(
//                     color: isSelected ? Colors.white : Colors.black,
//                     fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildCategoryDropdown() {
//     return DropdownButtonFormField<String>(
//       value: _selectedCategory,
//       icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: unselectedBg,
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide.none,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.tealGray, width: 1.5),
//         ),
//       ),
//       dropdownColor: Colors.white,
//       items: _categories.map((String category) {
//         return DropdownMenuItem<String>(
//           value: category,
//           child: Text(
//             category,
//             style: const TextStyle(color: Colors.black),
//           ),
//         );
//       }).toList(),
//       onChanged: (newValue) {
//         if (newValue != null) {
//           setState(() {
//             _selectedCategory = newValue;
//           });
//         }
//       },
//     );
//   }

//   Widget _buildSizeSelection() {
//     return Wrap(
//       spacing: 10,
//       runSpacing: 10,
//       children: _sizes.map((size) {
//         final isSelected = _selectedSize == size;
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               _selectedSize = size;
//             });
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 200),
//             curve: Curves.easeInOut,
//             width: 50,
//             height: 50,
//             alignment: Alignment.center,
//             decoration: BoxDecoration(
//               color: isSelected ? AppColors.tealGray : unselectedBg,
//               shape: BoxShape.circle,
//             ),
//             child: Text(
//               size,
//               style: TextStyle(
//                 color: isSelected ? Colors.white : Colors.black,
//                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//               ),
//             ),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildPriceFields() {
//     return Row(
//       children: [
//         Expanded(child: _buildPriceTextField('Min.', _minPriceController)),
//         const SizedBox(width: 16),
//         Expanded(child: _buildPriceTextField('Max.', _maxPriceController)),
//       ],
//     );
//   }

//   Widget _buildPriceTextField(String hint, TextEditingController controller) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: TextField(
//         controller: controller,
//         cursorColor: AppColors.tealGray,
//         keyboardType: TextInputType.number,
//         inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//         style: const TextStyle(color: Colors.black, fontSize: 15),
//         decoration: InputDecoration(
//           hintText: hint,
//           hintStyle: TextStyle(color: Colors.grey.shade400),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: AppColors.tealGray, width: 1.5),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/colors.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  // State variables
  String? _selectedGender;
  String _selectedCategory = 'All';
  String? _selectedSize;

  // Controllers
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  // Static options
  final List<String> _genders = ['Men', 'Women', 'Unisex'];
  final List<String> _categories = [
    'All',
    'Shoes',
    'T-Shirts',
    'Pants',
    'Jackets',
    'Accessories'
  ];
  final List<String> _sizes = ['S', 'M', 'L', 'XL', 'XXL', 'XXXL'];

  // Styling palette constants
  static const Color unselectedBg = Color(0xFFEFF2F4);

  bool get _hasActiveFilters {
    return _selectedGender != null ||
        _selectedCategory != 'All' ||
        _selectedSize != null ||
        _minPriceController.text.trim().isNotEmpty ||
        _maxPriceController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _minPriceController.addListener(_onFiltersMaybeChanged);
    _maxPriceController.addListener(_onFiltersMaybeChanged);
  }

  void _onFiltersMaybeChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _minPriceController.removeListener(_onFiltersMaybeChanged);
    _maxPriceController.removeListener(_onFiltersMaybeChanged);
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _resetAll() {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedGender = null;
      _selectedCategory = 'All';
      _selectedSize = null;
      _minPriceController.clear();
      _maxPriceController.clear();
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      "gender": _selectedGender,
      "category": _selectedCategory,
      "size": _selectedSize,
      "minPrice": _minPriceController.text.trim(),
      "maxPrice": _maxPriceController.text.trim(),
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      constraints: BoxConstraints(
        maxHeight: mediaQuery.size.height * 0.65,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppColors.tealGray,
            width: 1.5,
          ),
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Drag Handle
            const SizedBox(height: 12),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // 2. Header Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Opacity(
                    opacity: 0,
                    child: Text('Reset', style: TextStyle(fontSize: 16)),
                  ),
                  const Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: _hasActiveFilters ? _resetAll : null,
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.tealGray,
                      disabledForegroundColor: Colors.grey.shade400,
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 24, thickness: 1),

            // 3. Scrollable Body Contents
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  bottom: mediaQuery.viewInsets.bottom + 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle('Gender'),
                    const SizedBox(height: 12),
                    _buildGenderSelection(),
                    const SizedBox(height: 24),

                    _buildSectionTitle('Category'),
                    const SizedBox(height: 12),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 24),

                    // --- Size Section ---
                    _buildSectionTitle('Size'),
                    const SizedBox(height: 12),
                    _buildSizeSelection(),
                    const SizedBox(height: 24),

                    // --- Price Section ---
                    _buildSectionTitle('Price'),
                    const SizedBox(height: 16),
                    _buildPriceFields(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // 4. Sticky Apply Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.tealGray,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26.0),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
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

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: _genders.map((gender) {
        final isSelected = _selectedGender == gender;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedGender = gender;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.tealGray : unselectedBg,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  gender,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      value: _selectedCategory,
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
      decoration: InputDecoration(
        filled: true,
        fillColor: unselectedBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.tealGray, width: 1.5),
        ),
      ),
      dropdownColor: Colors.white,
      items: _categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(
            category,
            style: const TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        if (newValue != null) {
          setState(() {
            _selectedCategory = newValue;
          });
        }
      },
    );
  }

  // --- Size Selection (Horizontal Scrollable Circle List) ---
  Widget _buildSizeSelection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      clipBehavior: Clip.none,
      child: Row(
        
        children: _sizes.map((size) {
          final isSelected = _selectedSize == size;
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = size;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.tealGray : unselectedBg,
                  shape: BoxShape.circle,
                  boxShadow: [
                    if (!isSelected)
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                  ],
                ),
                child: Text(
                  size,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // --- Price Fields Row ---
  Widget _buildPriceFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildPriceItem('Min.', _minPriceController),
        const SizedBox(width: 24),
        _buildPriceItem('Max.', _maxPriceController),
      ],
    );
  }

  Widget _buildPriceItem(String label, TextEditingController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 75,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            textAlign: TextAlign.center,
            cursorColor: AppColors.tealGray,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '0',
              hintStyle: TextStyle(color: Colors.grey.shade500),
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.tealGray, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}