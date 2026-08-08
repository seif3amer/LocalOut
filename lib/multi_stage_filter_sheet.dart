// // import 'package:flutter/material.dart';

// // class MultiStageFilterSheet extends StatefulWidget {
// //   const MultiStageFilterSheet({super.key});

// //   @override
// //   State<MultiStageFilterSheet> createState() => _MultiStageFilterSheetState();
// // }

// // class _MultiStageFilterSheetState extends State<MultiStageFilterSheet> {
// //   // 0 = المرحلة الأولى (المنتجات والزرار رمادي)
// //   // 1 = المرحلة الثانية (صفحة الفلاتر)
// //   // 2 = المرحلة الثالثة (المنتجات بعد الفلترة والزرار أزرق)
// //   int _currentStage = 0;

// //   // قيم الفلتر (كمثال)
// //   double _priceValue = 400;
// //   String _selectedGender = 'All';
// //   String _selectedSize = 'All';
// //   String _selectedCategory = 'All';

// //   @override
// //   Widget build(BuildContext context) {
// //     final double screenHeight = MediaQuery.of(context).size.height;

// //     return Container(
// //       height: screenHeight * 0.85, // الارتفاع زي الصورة حوالي 85%
// //       decoration: const BoxDecoration(
// //         color: Color(0xFF222222), // الخلفية الداكنة نفس الصورة
// //         borderRadius: BorderRadius.only(
// //           topLeft: Radius.circular(24),
// //           topRight: Radius.circular(24),
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           // خط السحب العلوي (Drag Handle) والـ Header
// //           const SizedBox(height: 12),
// //           Container(
// //             width: 40,
// //             height: 4,
// //             decoration: BoxDecoration(
// //               color: Colors.grey.shade600,
// //               borderRadius: BorderRadius.circular(2),
// //             ),
// //           ),
// //           const SizedBox(height: 16),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 const SizedBox(width: 24), // موازنة الأيقونة
// //                 const Text(
// //                   'New Arrivals',
// //                   style: TextStyle(
// //                     color: Colors.white,
// //                     fontSize: 18,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                 ),
// //                 IconButton(
// //                   icon: const Icon(Icons.close, color: Colors.white),
// //                   onPressed: () => Navigator.pop(context),
// //                 ),
// //               ],
// //             ),
// //           ),
          
// //           // عرض المرحلة الحالية بناءً على الـ _currentStage
// //           Expanded(
// //             child: AnimatedSwitcher(
// //               duration: const Duration(milliseconds: 300),
// //               child: _buildStageContent(),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // دالة بتحدد أنهي شاشة تظهر حسب المرحلة
// //   Widget _buildStageContent() {
// //     if (_currentStage == 0) {
// //       return _buildProductsStage(isFiltered: false);
// //     } else if (_currentStage == 1) {
// //       return _buildFilterOptionsStage();
// //     } else {
// //       return _buildProductsStage(isFiltered: true);
// //     }
// //   }

// //   // المرحلة الأولى والثالثة (عرض المنتجات)
// //   Widget _buildProductsStage({required bool isFiltered}) {
// //     return Column(
// //       key: ValueKey<int>(isFiltered ? 2 : 0),
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         // صف أزرار التحكم (Sort / Clear filters)
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               GestureDetector(
// //                 onTap: () {
// //                   setState(() {
// //                     _currentStage = 1; // انقل للمرحلة الثانية (الفلتر)
// //                   });
// //                 },
// //                 child: Container(
// //                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
// //                   decoration: BoxDecoration(
// //                     color: isFiltered ? const Color(0xFF00A896) : const Color(0xFF444444), // لون أزرق لو متفلتر، رمادي لو مش متفلتر
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                   child: Row(
// //                     children: [
// //                       Icon(
// //                         isFiltered ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_right,
// //                         color: Colors.white,
// //                         size: 18,
// //                       ),
// //                       const SizedBox(width: 4),
// //                       const Text('Sort', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               if (isFiltered)
// //                 TextButton(
// //                   onPressed: () {
// //                     setState(() {
// //                       _currentStage = 0; // رجوع للمرحلة الأولى وإلغاء الفلتر
// //                     });
// //                   },
// //                   child: const Text('Clear filters', style: TextStyle(color: Colors.grey)),
// //                 ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 16),
// //         // قائمة المنتجات كمثال (تظهر زي الصورة بشكل أفقي أو شبكي)
// //         Expanded(
// //           child: GridView.builder(
// //             padding: const EdgeInsets.symmetric(horizontal: 16),
// //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// //               crossAxisCount: 2,
// //               childAspectRatio: 0.7,
// //               crossAxisSpacing: 16,
// //               mainAxisSpacing: 16,
// //             ),
// //             itemCount: 2,
// //             itemBuilder: (context, index) {
// //               return Container(
                
// //                 color: const Color(0xFF333333),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Expanded(
// //                       child: Container(
// //                         margin: const EdgeInsets.all(8),
// //                         decoration: BoxDecoration(
// //                           color: Colors.white,
// //                           borderRadius: BorderRadius.circular(12),
// //                           image: const DecorationImage(
// //                             image: Image.asset('images/Tshirt.png'), // ضع روابط صورك هنا
// //                             fit: BoxFit.cover,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 8.0),
// //                       child: Text('Nike Sportswear', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
// //                     ),
// //                     const Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
// //                       child: Text('L.E 600', style: TextStyle(color: Colors.grey)),
// //                     ),
// //                   ],
// //                 ),
// //               );
// //             },
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // المرحلة الثانية: خيارات الفلترة (Filter By)
// //   Widget _buildFilterOptionsStage() {
// //     return Column(
// //       key: const ValueKey<int>(1),
// //       children: [
// //         Expanded(
// //           child: SingleChildScrollView(
// //             padding: const EdgeInsets.all(20.0),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 const Center(
// //                   child: Text(
// //                     'Filter By',
// //                     style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
// //                   ),
// //                 ),
// //                 const SizedBox(height: 24),
                
// //                 // براند كمثال
// //                 _buildFilterLabel('Brand Name:'),
// //                 _buildDummyDropdown('Type Brand name...'),
// //                 const SizedBox(height: 16),

// //                 // النوع
// //                 _buildFilterLabel('Gender'),
// //                 _buildDummyDropdown('All'),
// //                 const SizedBox(height: 16),

// //                 // المقاس
// //                 _buildFilterLabel('Size:'),
// //                 _buildDummyDropdown('All'),
// //                 const SizedBox(height: 16),

// //                 // السعر والـ Slider
// //                 _buildFilterLabel('Price:'),
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     Text('L.E 400', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
// //                     Text('L.E 1200', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
// //                   ],
// //                 ),
// //                 Slider(
// //                   value: _priceValue,
// //                   min: 400,
// //                   max: 1200,
// //                   activeColor: const Color(0xFF00A896),
// //                   inactiveColor: Colors.grey.shade700,
// //                   onChanged: (val) {
// //                     setState(() {
// //                       _priceValue = val;
// //                     });
// //                   },
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
        
// //         // أزرار التحكم السفلية للمرحلة الثانية
// //         Padding(
// //           padding: const EdgeInsets.all(20.0),
// //           child: Row(
// //             children: [
// //               TextButton(
// //                 onPressed: () {
// //                   setState(() {
// //                     _currentStage = 0; // يرجع للمرحلة الأولى ويلغي الاختيارات
// //                   });
// //                 },
// //                 child: const Text('Clear All', style: TextStyle(color: Colors.grey, fontSize: 16)),
// //               ),
// //               const Spacer(),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   setState(() {
// //                     _currentStage = 2; // يروح للمرحلة التالتة (الفلتر شغال والزرار أزرق)
// //                   });
// //                 },
// //                 style: ElevatedButton.styleFrom(
// //                   backgroundColor: const Color(0xFF444444),
// //                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
// //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
// //                 ),
// //                 child: const Text('Apply Filters', style: TextStyle(color: Colors.white)),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildFilterLabel(String text) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 8.0),
// //       child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
// //     );
// //   }

// //   Widget _buildDummyDropdown(String hint) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
// //       decoration: BoxDecoration(
// //         color: const Color(0xFF333333),
// //         borderRadius: BorderRadius.circular(20),
// //       ),
// //       child: Row(
// //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //         children: [
// //           Text(hint, style: const TextStyle(color: Colors.white70)),
// //           const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
// //         ],
// //       ),
// //     );
// //   }
// // }



// import 'dart:ui'; // مطلوب لتأثير الـ Blur (الجلاس)
// import 'package:flutter/material.dart';

// class MultiStageFilterSheet extends StatefulWidget {
//   const MultiStageFilterSheet({super.key});

//   @override
//   State<MultiStageFilterSheet> createState() => _MultiStageFilterSheetState();
// }

// class _MultiStageFilterSheetState extends State<MultiStageFilterSheet> {
//   // 0 = المرحلة الأولى (المنتجات والزرار رمادي)
//   // 1 = المرحلة الثانية (صفحة الفلاتر)
//   // 2 = المرحلة الثالثة (المنتجات بعد الفلترة والزرار أزرق)
//   int _currentStage = 0;

//   // قيم الفلتر
//   double _priceValue = 400;
//   String _selectedGender = 'All';
//   String _selectedSize = 'All';
//   String _selectedBrand = '';

//   // خيارات القوايم (نفس الأماكن اللي كانت Dummy قبل كده، دلوقتي شغالة فعلاً)
//   final List<String> _genderOptions = const ['All', 'Men', 'Women', 'Kids'];
//   final List<String> _sizeOptions = const ['All', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];
//   final List<String> _brandOptions = const [
//     'Nike',
//     'Adidas',
//     'Puma',
//     'Fila',
//     'Under Armour',
//     'Reebok',
//     'New Balance',
//     'Converse',
//     'Vans',
//     'Skechers',
//   ];

//   // حالة فتح / قفل كل قايمة
//   bool _genderExpanded = false;
//   bool _sizeExpanded = false;
//   bool _brandExpanded = false;

//   final TextEditingController _brandController = TextEditingController();

//   @override
//   void dispose() {
//     _brandController.dispose();
//     super.dispose();
//   }

//   void _resetFilters() {
//     setState(() {
//       _selectedGender = 'All';
//       _selectedSize = 'All';
//       _selectedBrand = '';
//       _brandController.clear();
//       _priceValue = 400;
//       _genderExpanded = false;
//       _sizeExpanded = false;
//       _brandExpanded = false;
//       _currentStage = 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // الحاوية بقت "جلاس" (شفافة + بلور) بدل اللون الصلب،
//     // وبقت مستديرة من الأربع جوانب عشان بتتفتح في نص الشاشة دلوقتي.
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(28),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//         child: Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height * 0.75,
//           decoration: BoxDecoration(
//             color: const Color(0xFF222222).withOpacity(0.55),
//             borderRadius: BorderRadius.circular(28),
//             border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.2),
//           ),
//           child: Column(
//             children: [
//               const SizedBox(height: 12),
//               Container(
//                 width: 40,
//                 height: 4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade400.withOpacity(0.6),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const SizedBox(width: 24), // موازنة الأيقونة
//                     const Text(
//                       'New Arrivals',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.close, color: Colors.white),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ],
//                 ),
//               ),

//               // عرض المرحلة الحالية بناءً على الـ _currentStage
//               Expanded(
//                 child: AnimatedSwitcher(
//                   duration: const Duration(milliseconds: 300),
//                   child: _buildStageContent(),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // دالة بتحدد أنهي شاشة تظهر حسب المرحلة
//   Widget _buildStageContent() {
//     if (_currentStage == 0) {
//       return _buildProductsStage(isFiltered: false);
//     } else if (_currentStage == 1) {
//       return _buildFilterOptionsStage();
//     } else {
//       return _buildProductsStage(isFiltered: true);
//     }
//   }

//   // المرحلة الأولى والثالثة (عرض المنتجات)
//   Widget _buildProductsStage({required bool isFiltered}) {
//     return Column(
//       key: ValueKey<int>(isFiltered ? 2 : 0),
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // صف أزرار التحكم (Sort / Clear filters)
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     _currentStage = 1; // انقل للمرحلة الثانية (الفلتر)
//                   });
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     color: isFiltered
//                         ? const Color(0xFF00A896).withOpacity(0.85)
//                         : Colors.white.withOpacity(0.12),
//                     borderRadius: BorderRadius.circular(20),
//                     border: Border.all(color: Colors.white.withOpacity(0.2)),
//                   ),
//                   child: const Row(
//                     children: [
//                       Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 18),
//                       SizedBox(width: 4),
//                       Text('Sort', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//               ),
//               if (isFiltered)
//                 TextButton(
//                   onPressed: _resetFilters, // رجوع للمرحلة الأولى وإلغاء الفلتر
//                   child: const Text('Clear filters', style: TextStyle(color: Colors.grey)),
//                 ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 16),
//         // قائمة المنتجات كمثال
//         Expanded(
//           child: GridView.builder(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.7,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemCount: 2,
//             itemBuilder: (context, index) {
//               return Container(
//                 color: const Color(0xFF333333),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Container(
//                         margin: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           image: const DecorationImage(
//                             image: AssetImage('images/Tshirt.png'), // ضع روابط صورك هنا
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text('Nike Sportswear', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
//                       child: Text('L.E 600', style: TextStyle(color: Colors.grey)),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }

//   // المرحلة الثانية: خيارات الفلترة (Filter By)
//   Widget _buildFilterOptionsStage() {
//     return Column(
//       key: const ValueKey<int>(1),
//       children: [
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(20.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Center(
//                   child: Text(
//                     'Filter By',
//                     style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // البراند - دلوقتي فيه بحث حقيقي واقتراحات بتظهر تحت
//                 _buildSelectField(
//                   label: 'Brand Name:',
//                   displayValue: _selectedBrand,
//                   hint: 'Type Brand name...',
//                   options: _brandOptions,
//                   expanded: _brandExpanded,
//                   searchable: true,
//                   searchController: _brandController,
//                   onToggle: () => setState(() {
//                     _brandExpanded = !_brandExpanded;
//                     if (_brandExpanded) {
//                       _genderExpanded = false;
//                       _sizeExpanded = false;
//                     }
//                   }),
//                   onSelect: (val) {
//                     setState(() {
//                       _selectedBrand = val;
//                       _brandController.text = val;
//                     });
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // النوع - قايمة شغالة فعلياً
//                 _buildSelectField(
//                   label: 'Gender',
//                   displayValue: _selectedGender,
//                   hint: 'All',
//                   options: _genderOptions,
//                   expanded: _genderExpanded,
//                   onToggle: () => setState(() {
//                     _genderExpanded = !_genderExpanded;
//                     if (_genderExpanded) {
//                       _brandExpanded = false;
//                       _sizeExpanded = false;
//                     }
//                   }),
//                   onSelect: (val) => setState(() => _selectedGender = val),
//                 ),
//                 const SizedBox(height: 16),

//                 // المقاس - قايمة شغالة فعلياً
//                 _buildSelectField(
//                   label: 'Size:',
//                   displayValue: _selectedSize,
//                   hint: 'All',
//                   options: _sizeOptions,
//                   expanded: _sizeExpanded,
//                   onToggle: () => setState(() {
//                     _sizeExpanded = !_sizeExpanded;
//                     if (_sizeExpanded) {
//                       _brandExpanded = false;
//                       _genderExpanded = false;
//                     }
//                   }),
//                   onSelect: (val) => setState(() => _selectedSize = val),
//                 ),
//                 const SizedBox(height: 16),

//                 // السعر والـ Slider
//                 _buildFilterLabel('Price:'),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('L.E 400', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
//                     Text('L.E 1200', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
//                   ],
//                 ),
//                 Slider(
//                   value: _priceValue,
//                   min: 400,
//                   max: 1200,
//                   activeColor: const Color(0xFF00A896),
//                   inactiveColor: Colors.grey.shade700,
//                   onChanged: (val) {
//                     setState(() {
//                       _priceValue = val;
//                     });
//                   },
//                 ),
//                 Text('L.E ${_priceValue.round()}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
//               ],
//             ),
//           ),
//         ),

//         // أزرار التحكم السفلية للمرحلة الثانية
//         Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             children: [
//               TextButton(
//                 onPressed: _resetFilters, // يرجع للمرحلة الأولى ويلغي الاختيارات
//                 child: const Text('Clear All', style: TextStyle(color: Colors.grey, fontSize: 16)),
//               ),
//               const Spacer(),
//               ElevatedButton(
//                 onPressed: () {
//                   setState(() {
//                     _currentStage = 2; // يروح للمرحلة التالتة (الفلتر شغال والزرار أزرق)
//                   });
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white.withOpacity(0.15),
//                   padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     side: BorderSide(color: Colors.white.withOpacity(0.25)),
//                   ),
//                 ),
//                 child: const Text('Apply Filters', style: TextStyle(color: Colors.white)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildFilterLabel(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
//     );
//   }

//   /// ودجت قايمة قابلة للفتح والاختيار منها (بتتستخدم لـ Gender و Size و Brand).
//   /// - لو searchable = true بيظهر مربع بحث بيفلتر القايمة وهي بتترسم زي الاقتراحات.
//   /// - القايمة بتفتح تحت الحقل مباشرة، وبالضغط على أي عنصر بيتحفظ الاختيار.
//   Widget _buildSelectField({
//     required String label,
//     required String displayValue,
//     required String hint,
//     required List<String> options,
//     required bool expanded,
//     required VoidCallback onToggle,
//     required ValueChanged<String> onSelect,
//     bool searchable = false,
//     TextEditingController? searchController,
//   }) {
//     final query = searchable ? (searchController?.text ?? '') : '';
//     final List<String> displayList = (searchable && query.isNotEmpty)
//         ? options.where((o) => o.toLowerCase().contains(query.toLowerCase())).toList()
//         : options;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildFilterLabel(label),
//         ClipRRect(
//           borderRadius: BorderRadius.circular(20),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
//               ),
//               child: searchable
//                   ? Row(
//                       children: [
//                         const Icon(Icons.search, color: Colors.white54, size: 20),
//                         const SizedBox(width: 8),
//                         Expanded(
//                           child: TextField(
//                             controller: searchController,
//                             style: const TextStyle(color: Colors.white),
//                             onTap: () {
//                               if (!expanded) onToggle();
//                             },
//                             onChanged: (_) {
//                               if (!expanded) onToggle();
//                               setState(() {});
//                             },
//                             decoration: InputDecoration(
//                               hintText: hint,
//                               hintStyle: const TextStyle(color: Colors.white54),
//                               border: InputBorder.none,
//                               isDense: true,
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: onToggle,
//                           child: Icon(
//                             expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                             color: Colors.white54,
//                           ),
//                         ),
//                       ],
//                     )
//                   : InkWell(
//                       onTap: onToggle,
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 8),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(displayValue, style: const TextStyle(color: Colors.white70)),
//                             Icon(
//                               expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                               color: Colors.white54,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//             ),
//           ),
//         ),
//         AnimatedCrossFade(
//           duration: const Duration(milliseconds: 200),
//           crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
//           firstChild: const SizedBox(width: double.infinity, height: 0),
//           secondChild: Container(
//             margin: const EdgeInsets.only(top: 6),
//             constraints: const BoxConstraints(maxHeight: 200),
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.06),
//               borderRadius: BorderRadius.circular(16),
//               border: Border.all(color: Colors.white.withOpacity(0.15)),
//             ),
//             child: displayList.isEmpty
//                 ? const Padding(
//                     padding: EdgeInsets.all(12),
//                     child: Text('No results', style: TextStyle(color: Colors.white54)),
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     padding: const EdgeInsets.symmetric(vertical: 4),
//                     itemCount: displayList.length,
//                     itemBuilder: (context, i) {
//                       final item = displayList[i];
//                       return ListTile(
//                         dense: true,
//                         title: Text(item, style: const TextStyle(color: Colors.white)),
//                         onTap: () {
//                           onSelect(item);
//                           onToggle();
//                         },
//                       );
//                     },
//                   ),
//           ),
//         ),
//       ],
//     );
//   }
// }












import 'dart:ui'; // مطلوب لتأثير الـ Blur (الجلاس)
import 'package:flutter/material.dart';

class MultiStageFilterSheet extends StatefulWidget {
  const MultiStageFilterSheet({super.key});

  @override
  State<MultiStageFilterSheet> createState() => _MultiStageFilterSheetState();
}

class _MultiStageFilterSheetState extends State<MultiStageFilterSheet> {
  // 0 = المرحلة الأولى (المنتجات والزرار رمادي)
  // 1 = المرحلة الثانية (صفحة الفلاتر)
  // 2 = المرحلة الثالثة (المنتجات بعد الفلترة والزرار أزرق)
  int _currentStage = 0;

  // قيم الفلتر
  double _priceValue = 400;
  String _selectedGender = 'All';
  String _selectedSize = 'All';
  String _selectedBrand = '';

  // خيارات القوايم (نفس الأماكن اللي كانت Dummy قبل كده، دلوقتي شغالة فعلاً)
  final List<String> _genderOptions = const ['All', 'Men', 'Women', 'Kids'];
  final List<String> _sizeOptions = const ['All', 'XS', 'S', 'M', 'L', 'XL', 'XXL'];
  final List<String> _brandOptions = const [
    'Nike',
    'Adidas',
    'Puma',
    'Fila',
    'Under Armour',
    'Reebok',
    'New Balance',
    'Converse',
    'Vans',
    'Skechers',
  ];

  // حالة فتح / قفل كل قايمة
  bool _genderExpanded = false;
  bool _sizeExpanded = false;
  bool _brandExpanded = false;

  // حالة القلب (Favorite) لكل كارت في الجريد، بنفس فكرة الهوم سكرين
  final List<bool> _favorites = [true, true];

  final TextEditingController _brandController = TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _selectedGender = 'All';
      _selectedSize = 'All';
      _selectedBrand = '';
      _brandController.clear();
      _priceValue = 400;
      _genderExpanded = false;
      _sizeExpanded = false;
      _brandExpanded = false;
      _currentStage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // الحاوية بقت "جلاس" (شفافة + بلور) بدل اللون الصلب،
    // وبقت مستديرة من الأربع جوانب عشان بتتفتح في نص الشاشة دلوقتي.
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: BoxDecoration(
            color: const Color(0xFF222222).withOpacity(0.55),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white.withOpacity(0.15), width: 1.2),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 24), // موازنة الأيقونة
                    const Text(
                      'New Arrivals',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // عرض المرحلة الحالية بناءً على الـ _currentStage
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildStageContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة بتحدد أنهي شاشة تظهر حسب المرحلة
  Widget _buildStageContent() {
    if (_currentStage == 0) {
      return _buildProductsStage(isFiltered: false);
    } else if (_currentStage == 1) {
      return _buildFilterOptionsStage();
    } else {
      return _buildProductsStage(isFiltered: true);
    }
  }

  // المرحلة الأولى والثالثة (عرض المنتجات)
  Widget _buildProductsStage({required bool isFiltered}) {
    return Column(
      key: ValueKey<int>(isFiltered ? 2 : 0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // صف أزرار التحكم (Sort / Clear filters)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentStage = 1; // انقل للمرحلة الثانية (الفلتر)
                  });
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isFiltered
                        ? const Color(0xFF00A896).withOpacity(0.85)
                        : Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 18),
                      SizedBox(width: 4),
                      Text('Sort', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
              if (isFiltered)
                TextButton(
                  onPressed: _resetFilters, // رجوع للمرحلة الأولى وإلغاء الفلتر
                  child: const Text('Clear filters', style: TextStyle(color: Colors.grey)),
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        // قائمة المنتجات كمثال
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _buildProductCard(index);
            },
          ),
        ),
      ],
    );
  }

  // كارت المنتج - بنفس شكل ولون كروت الهوم سكرين بالظبط (كارت أبيض + قلب فوق الصورة)
  Widget _buildProductCard(int index) {
    final bool isFav = index < _favorites.length ? _favorites[index] : true;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.asset(
                    "images/Tshirt.png",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                // زرار القلب - جوه حدود الكارت (نفس اللي في الهوم سكرين)
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (index < _favorites.length) {
                          _favorites[index] = !_favorites[index];
                        }
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
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: isFav ? Colors.red : Colors.grey.shade400,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Nike Sportswear\nClub Fleece',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          const Text('L.E 600', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black87)),
        ],
      ),
    );
  }

  // المرحلة الثانية: خيارات الفلترة (Filter By)
  Widget _buildFilterOptionsStage() {
    return Column(
      key: const ValueKey<int>(1),
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Filter By',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),

                // البراند - دلوقتي فيه بحث حقيقي واقتراحات بتظهر تحت
                _buildSelectField(
                  label: 'Brand Name:',
                  displayValue: _selectedBrand,
                  hint: 'Type Brand name...',
                  options: _brandOptions,
                  expanded: _brandExpanded,
                  searchable: true,
                  searchController: _brandController,
                  onToggle: () => setState(() {
                    _brandExpanded = !_brandExpanded;
                    if (_brandExpanded) {
                      _genderExpanded = false;
                      _sizeExpanded = false;
                    }
                  }),
                  onSelect: (val) {
                    setState(() {
                      _selectedBrand = val;
                      _brandController.text = val;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // النوع - قايمة شغالة فعلياً
                _buildSelectField(
                  label: 'Gender',
                  displayValue: _selectedGender,
                  hint: 'All',
                  options: _genderOptions,
                  expanded: _genderExpanded,
                  onToggle: () => setState(() {
                    _genderExpanded = !_genderExpanded;
                    if (_genderExpanded) {
                      _brandExpanded = false;
                      _sizeExpanded = false;
                    }
                  }),
                  onSelect: (val) => setState(() => _selectedGender = val),
                ),
                const SizedBox(height: 16),

                // المقاس - قايمة شغالة فعلياً
                _buildSelectField(
                  label: 'Size:',
                  displayValue: _selectedSize,
                  hint: 'All',
                  options: _sizeOptions,
                  expanded: _sizeExpanded,
                  onToggle: () => setState(() {
                    _sizeExpanded = !_sizeExpanded;
                    if (_sizeExpanded) {
                      _brandExpanded = false;
                      _genderExpanded = false;
                    }
                  }),
                  onSelect: (val) => setState(() => _selectedSize = val),
                ),
                const SizedBox(height: 16),

                // السعر والـ Slider
                _buildFilterLabel('Price:'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('L.E 400', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                    Text('L.E 1200', style: TextStyle(color: Colors.grey.shade400, fontSize: 12)),
                  ],
                ),
                Slider(
                  value: _priceValue,
                  min: 400,
                  max: 1200,
                  activeColor: const Color(0xFF00A896),
                  inactiveColor: Colors.grey.shade700,
                  onChanged: (val) {
                    setState(() {
                      _priceValue = val;
                    });
                  },
                ),
                Text('L.E ${_priceValue.round()}', style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
        ),

        // أزرار التحكم السفلية للمرحلة الثانية
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              TextButton(
                onPressed: _resetFilters, // يرجع للمرحلة الأولى ويلغي الاختيارات
                child: const Text('Clear All', style: TextStyle(color: Colors.grey, fontSize: 16)),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentStage = 2; // يروح للمرحلة التالتة (الفلتر شغال والزرار أزرق)
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.15),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: Colors.white.withOpacity(0.25)),
                  ),
                ),
                child: const Text('Apply Filters', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14)),
    );
  }

  /// ودجت قايمة قابلة للفتح والاختيار منها (بتتستخدم لـ Gender و Size و Brand).
  /// - لو searchable = true بيظهر مربع بحث بيفلتر القايمة وهي بتترسم زي الاقتراحات.
  /// - القايمة بتفتح تحت الحقل مباشرة، وبالضغط على أي عنصر بيتحفظ الاختيار.
  Widget _buildSelectField({
    required String label,
    required String displayValue,
    required String hint,
    required List<String> options,
    required bool expanded,
    required VoidCallback onToggle,
    required ValueChanged<String> onSelect,
    bool searchable = false,
    TextEditingController? searchController,
  }) {
    final query = searchable ? (searchController?.text ?? '') : '';
    final List<String> displayList = (searchable && query.isNotEmpty)
        ? options.where((o) => o.toLowerCase().contains(query.toLowerCase())).toList()
        : options;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFilterLabel(label),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.18), width: 1),
              ),
              child: searchable
                  ? Row(
                      children: [
                        const Icon(Icons.search, color: Colors.white54, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            style: const TextStyle(color: Colors.white),
                            onTap: () {
                              if (!expanded) onToggle();
                            },
                            onChanged: (_) {
                              if (!expanded) onToggle();
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              hintText: hint,
                              hintStyle: const TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              isDense: true,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: onToggle,
                          child: Icon(
                            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: onToggle,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(displayValue, style: const TextStyle(color: Colors.white70)),
                            Icon(
                              expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              color: Colors.white54,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ),
        ),
        AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          firstChild: const SizedBox(width: double.infinity, height: 0),
          secondChild: Container(
            margin: const EdgeInsets.only(top: 6),
            constraints: const BoxConstraints(maxHeight: 200),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: displayList.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text('No results', style: TextStyle(color: Colors.white54)),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: displayList.length,
                    itemBuilder: (context, i) {
                      final item = displayList[i];
                      return ListTile(
                        dense: true,
                        title: Text(item, style: const TextStyle(color: Colors.white)),
                        onTap: () {
                          onSelect(item);
                          onToggle();
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}