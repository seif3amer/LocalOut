// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_svg/flutter_svg.dart';
// // // // import 'package:project/colors.dart';

// // // // class ProductDetails extends StatefulWidget {
// // // //   const ProductDetails({super.key});

// // // //   @override
// // // //   State<ProductDetails> createState() => _ProductDetailsState();
// // // // }

// // // // class _ProductDetailsState extends State<ProductDetails> {
// // // //   // -1 يعني مفيش مقاس متحدد لسه
// // // //   int _selectedSizeIndex = -1;
// // // //   int _selectedColorIndex = 0;
// // // //   int _currentImageIndex = 1;
// // // //   bool _isFavorite = false;
// // // //   bool _isDescriptionExpanded = false;

// // // //   // true وقت ما إحنا بنملى التيكست فيلدز برمجياً (بعد الضغط على زرار مقاس)
// // // //   // عشان الـ onChanged مايعملش حسبة تانية على نفس القيمة ويلخبط الحالة.
// // // //   bool _isProgrammaticUpdate = false;

// // // //   final TextEditingController _heightController = TextEditingController();
// // // //   final TextEditingController _weightController = TextEditingController();

// // // //   final List<String> productSizes = ['S', 'M', 'L', 'XL', '2XL'];
// // // //   final List<Color> productColors = [
// // // //     const Color(0xFF98E4CE), // مينت جرين
// // // //     const Color(0xFF2C629E), // أزرق
// // // //     const Color(0xFF8B1A1A), // نبيتي
// // // //   ];
// // // //   final List<String> images = [
// // // //     'images/human.png',
// // // //     'images/human.png',
// // // //     'images/human.png',
// // // //   ];

// // // //   static const String _description =
// // // //       'The Nike Throwback Pullover Hoodie is made from premium French '
// // // //       'terry fabric that blends a performance feel with everyday comfort. '
// // // //       'A relaxed fit and soft brushed interior keep you warm without '
// // // //       'weighing you down, while the ribbed cuffs and hem lock in heat '
// // // //       'on cool days.';

// // // //   // كل مقاس وحدوده (طول/وزن) في مكان واحد — أسهل في الصيانة من
// // // //   // تكرار الأرقام في أكتر من دالة.
// // // //   static const List<_SizeRange> _sizeRanges = [
// // // //     _SizeRange(minH: 150, maxH: 164, minW: 50, maxW: 64),
// // // //     _SizeRange(minH: 165, maxH: 173, minW: 65, maxW: 73),
// // // //     _SizeRange(minH: 174, maxH: 180, minW: 74, maxW: 85),
// // // //     _SizeRange(minH: 181, maxH: 190, minW: 86, maxW: 95),
// // // //     _SizeRange(minH: 191, maxH: 200, minW: 96, maxW: 110),
// // // //   ];

// // // //   // -----------------------------------------------------------------
// // // //   // 1) المستخدم بيكتب طول ووزن بإيده -> نحدد المقاس المناسب أوتوماتيك
// // // //   // -----------------------------------------------------------------
// // // //   void _calculateSizeFromInput() {
// // // //     if (_isProgrammaticUpdate) return;

// // // //     final String heightText = _heightController.text.trim();
// // // //     final String weightText = _weightController.text.trim();

// // // //     if (heightText.isEmpty && weightText.isEmpty) {
// // // //       if (_selectedSizeIndex != -1) {
// // // //         setState(() => _selectedSizeIndex = -1);
// // // //       }
// // // //       return;
// // // //     }

// // // //     final double? height = double.tryParse(heightText);
// // // //     final double? weight = double.tryParse(weightText);

// // // //     // لسه المستخدم بيكتب / أو القيمة رينج جاية من زرار مقاس -> متعملش حاجة
// // // //     if (height == null && weight == null) return;

// // // //     final int newSizeIndex = _resolveSizeIndex(height, weight);

// // // //     if (newSizeIndex != _selectedSizeIndex) {
// // // //       setState(() => _selectedSizeIndex = newSizeIndex);
// // // //     }
// // // //   }

// // // //   /// بيدور على أفضل مقاس مطابق:
// // // //   /// 1) مطابقة كاملة: الطول والوزن الاتنين جوه نفس المقاس.
// // // //   /// 2) لو مفيش مطابقة كاملة، مطابقة جزئية بالوزن بس (لو موجود).
// // // //   /// 3) لو برضو مفيش، مطابقة جزئية بالطول بس (لو موجود).
// // // //   /// كده لو كتبت طول برا النطاق لكن الوزن صح، أو العكس، برضو
// // // //   /// هيتحدد مقاس بدل ما يفضل من غير أي اختيار.
// // // //   int _resolveSizeIndex(double? height, double? weight) {
// // // //     if (height != null && weight != null) {
// // // //       for (int i = 0; i < _sizeRanges.length; i++) {
// // // //         if (_sizeRanges[i].matchesBoth(height, weight)) return i;
// // // //       }
// // // //     }

// // // //     if (weight != null) {
// // // //       for (int i = 0; i < _sizeRanges.length; i++) {
// // // //         if (_sizeRanges[i].matchesWeight(weight)) return i;
// // // //       }
// // // //     }

// // // //     if (height != null) {
// // // //       for (int i = 0; i < _sizeRanges.length; i++) {
// // // //         if (_sizeRanges[i].matchesHeight(height)) return i;
// // // //       }
// // // //     }

// // // //     return -1;
// // // //   }

// // // //   // -----------------------------------------------------------------
// // // //   // 2) المستخدم بيضغط على زرار مقاس -> نملى الرينج المناسب في الفيلدز
// // // //   // -----------------------------------------------------------------
// // // //   void _setRangeFromSize(int sizeIndex) {
// // // //     final _SizeRange range = _sizeRanges[sizeIndex];
// // // //     _isProgrammaticUpdate = true;
// // // //     setState(() {
// // // //       _selectedSizeIndex = sizeIndex;
// // // //       _heightController.text = '${range.minH} ~ ${range.maxH}';
// // // //       _weightController.text = '${range.minW} ~ ${range.maxW}';
// // // //     });
// // // //     // نفك القفل بعد ما الفريم يخلص، عشان أي تعديل يدوي بعد كده
// // // //     // يترصد بشكل طبيعي تاني.
// // // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // // //       _isProgrammaticUpdate = false;
// // // //     });
// // // //   }

// // // //   @override
// // // //   void dispose() {
// // // //     _heightController.dispose();
// // // //     _weightController.dispose();
// // // //     super.dispose();
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Scaffold(
// // // //       appBar: AppBar(
// // // //         backgroundColor: AppColors.background,
// // // //         leading: const Icon(Icons.arrow_back_ios),
// // // //         title: const Text(
// // // //           'Product Details',
// // // //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // // //         ),
// // // //         centerTitle: true,
// // // //       ),
// // // //       body: Container(
// // // //         width: double.infinity,
// // // //         height: double.infinity,
// // // //         decoration: const BoxDecoration(color: AppColors.background),
// // // //         child: SingleChildScrollView(
// // // //           padding: const EdgeInsets.only(bottom: 30),
// // // //           child: Column(
// // // //             children: [
// // // //               const SizedBox(height: 24),
// // // //               _buildImageCarousel(),
// // // //               const SizedBox(height: 12),
// // // //               _buildImageIndicator(),
// // // //               const SizedBox(height: 33),
// // // //               _buildProductHeader(),
// // // //               const SizedBox(height: 24),
// // // //               _buildTryOnMe(),
// // // //               const SizedBox(height: 24),
// // // //               _buildColorSelector(),
// // // //               const SizedBox(height: 24),
// // // //               _buildSizeSelector(),
// // // //               const SizedBox(height: 24),
// // // //               _buildMeasurementRow(),
// // // //               const SizedBox(height: 32),
// // // //               _buildDescription(),
// // // //               const SizedBox(height: 24),
// // // //               _buildReviews(),
// // // //               const SizedBox(height: 24),
// // // //               _buildPriceAndCart(),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // صور الكاروسيل
// // // //   // =====================================================
// // // //   Widget _buildImageCarousel() {
// // // //     return SizedBox(
// // // //       height: 340,
// // // //       child: PageView.builder(
// // // //         controller: PageController(initialPage: 1, viewportFraction: 0.55),
// // // //         itemCount: images.length,
// // // //         onPageChanged: (index) {
// // // //           setState(() => _currentImageIndex = index);
// // // //         },
// // // //         itemBuilder: (context, index) {
// // // //           final bool isActive = _currentImageIndex == index;
// // // //           final double scale = isActive ? 1.0 : 0.85;
// // // //           // ظل "طيران" أقوى وأوضح على الصورة النشطة، وأخف على الصور
// // // //           // الجانبية عشان الإحساس بالعمق يبقى طبيعي مع تغيير الحجم.
// // // //           return Transform.scale(
// // // //             scale: scale,
// // // //             child: Container(
// // // //               margin: const EdgeInsets.symmetric(horizontal: 4),
// // // //               decoration: BoxDecoration(
// // // //                 borderRadius: BorderRadius.circular(24),
// // // //                 border: Border.all(
// // // //                   color: Colors.grey.withOpacity(0.3),
// // // //                   width: 1,
// // // //                 ),
// // // //                 image: DecorationImage(
// // // //                   image: AssetImage(images[index]),
// // // //                   fit: BoxFit.cover,
// // // //                 ),
// // // //                 boxShadow: [
// // // //                   BoxShadow(
// // // //                     color: Colors.black.withOpacity(isActive ? 0.22 : 0.12),
// // // //                     blurRadius: isActive ? 28 : 16,
// // // //                     spreadRadius: isActive ? 1 : 0,
// // // //                     offset: Offset(0, isActive ? 18 : 10),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildImageIndicator() {
// // // //     return Row(
// // // //       mainAxisAlignment: MainAxisAlignment.center,
// // // //       children: List.generate(images.length, (index) {
// // // //         final bool isActive = _currentImageIndex == index;
// // // //         return AnimatedContainer(
// // // //           duration: const Duration(milliseconds: 300),
// // // //           margin: const EdgeInsets.symmetric(horizontal: 3),
// // // //           height: 6,
// // // //           width: isActive ? 18 : 6,
// // // //           decoration: BoxDecoration(
// // // //             color: isActive ? AppColors.tealGray : const Color(0xFFCCCCCC),
// // // //             borderRadius: BorderRadius.circular(3),
// // // //           ),
// // // //         );
// // // //       }),
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // اسم المنتج + السعر + اللايك + التقييم
// // // //   // =====================================================
// // // //   Widget _buildProductHeader() {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //       child: Row(
// // // //         children: [
// // // //           const Column(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               Text(
// // // //                 'Best Seller',
// // // //                 style: TextStyle(
// // // //                   fontSize: 13,
// // // //                   fontWeight: FontWeight.w500,
// // // //                   color: Color(0xFF8F959E),
// // // //                 ),
// // // //               ),
// // // //               Text(
// // // //                 'Nike Club Fleece',
// // // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
// // // //               ),
// // // //               Text(
// // // //                 'L.E 600',
// // // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           const Spacer(),
// // // //           Column(
// // // //             children: [
// // // //               const SizedBox(height: 4),
// // // //               _buildFavoriteButton(),
// // // //               const SizedBox(height: 16),
// // // //               const Row(
// // // //                 children: [
// // // //                   Icon(Icons.star, color: Colors.amber),
// // // //                   SizedBox(width: 8),
// // // //                   Text('5.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
// // // //                 ],
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildFavoriteButton() {
// // // //     return GestureDetector(
// // // //       onTap: () => setState(() => _isFavorite = !_isFavorite),
// // // //       child: AnimatedContainer(
// // // //         duration: const Duration(milliseconds: 200),
// // // //         padding: const EdgeInsets.all(12),
// // // //         decoration: BoxDecoration(
// // // //           shape: BoxShape.circle,
// // // //           gradient: LinearGradient(
// // // //             begin: Alignment.topLeft,
// // // //             end: Alignment.bottomRight,
// // // //             colors: [
// // // //               const Color.fromARGB(103, 249, 248, 248).withOpacity(0.9),
// // // //               const Color.fromARGB(69, 201, 199, 199).withOpacity(0.6),
// // // //             ],
// // // //           ),
// // // //           boxShadow: [
// // // //             BoxShadow(
// // // //               color: Colors.black.withOpacity(0.08),
// // // //               blurRadius: 15,
// // // //               spreadRadius: 2,
// // // //               offset: const Offset(0, 5),
// // // //             ),
// // // //           ],
// // // //           border: Border.all(
// // // //             color: const Color.fromARGB(255, 192, 191, 191).withOpacity(0.6),
// // // //             width: 1.5,
// // // //           ),
// // // //         ),
// // // //         child: AnimatedSwitcher(
// // // //           duration: const Duration(milliseconds: 200),
// // // //           transitionBuilder: (child, animation) =>
// // // //               ScaleTransition(scale: animation, child: child),
// // // //           child: Icon(
// // // //             _isFavorite ? Icons.favorite : Icons.favorite_border,
// // // //             key: ValueKey<bool>(_isFavorite),
// // // //             color: _isFavorite ? Colors.red : Colors.black,
// // // //             size: 24,
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // Try on Me
// // // //   // =====================================================
// // // //   Widget _buildTryOnMe() {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           const Row(
// // // //             children: [
// // // //               Text('Try on Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // // //               Spacer(),
// // // //               Text(
// // // //                 'Virtual Simulation',
// // // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           const SizedBox(height: 15),
// // // //           Row(
// // // //             children: [
// // // //               Icon(Icons.info_outline, color: AppColors.gray, size: 14),
// // // //               const SizedBox(width: 4),
// // // //               Text(
// // // //                 'Confidence fit: 95%',
// // // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.gray),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           const SizedBox(height: 8),
// // // //           Center(child: Image.asset('images/avatar.png', height: 343)),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // الألوان
// // // //   // =====================================================
// // // //   Widget _buildColorSelector() {
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         const Padding(
// // // //           padding: EdgeInsets.symmetric(horizontal: 16),
// // // //           child: Row(
// // // //             children: [
// // // //               Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // // //               Spacer(),
// // // //               Text(
// // // //                 'Colors Available',
// // // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         const SizedBox(height: 12),
// // // //         Padding(
// // // //           padding: const EdgeInsets.only(left: 16),
// // // //           child: Row(
// // // //             children: List.generate(productColors.length, (index) {
// // // //               final bool isSelected = _selectedColorIndex == index;
// // // //               return GestureDetector(
// // // //                 onTap: () => setState(() => _selectedColorIndex = index),
// // // //                 child: Container(
// // // //                   margin: const EdgeInsets.only(right: 12),
// // // //                   decoration: BoxDecoration(
// // // //                     shape: BoxShape.circle,
// // // //                     border: Border.all(
// // // //                       color: isSelected ? AppColors.tealGray : Colors.transparent,
// // // //                       width: 2,
// // // //                     ),
// // // //                   ),
// // // //                   child: CircleAvatar(
// // // //                     radius: 18,
// // // //                     backgroundColor: productColors[index],
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             }),
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // المقاسات
// // // //   // =====================================================
// // // //   Widget _buildSizeSelector() {
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.start,
// // // //       children: [
// // // //         const Padding(
// // // //           padding: EdgeInsets.symmetric(horizontal: 16),
// // // //           child: Row(
// // // //             children: [
// // // //               Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // // //               Spacer(),
// // // //               Text(
// // // //                 'Size Guide',
// // // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         ),
// // // //         const SizedBox(height: 12),
// // // //         Padding(
// // // //           padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //           child: Row(
// // // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //             children: List.generate(productSizes.length, (index) {
// // // //               final bool isSelected = _selectedSizeIndex == index;
// // // //               return GestureDetector(
// // // //                 onTap: () => _setRangeFromSize(index),
// // // //                 child: AnimatedContainer(
// // // //                   duration: const Duration(milliseconds: 200),
// // // //                   width: 55,
// // // //                   height: 50,
// // // //                   decoration: BoxDecoration(
// // // //                     color: isSelected ? AppColors.tealGray : Colors.white,
// // // //                     borderRadius: BorderRadius.circular(12),
// // // //                     border: Border.all(
// // // //                       color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
// // // //                     ),
// // // //                   ),
// // // //                   alignment: Alignment.center,
// // // //                   child: Text(
// // // //                     productSizes[index],
// // // //                     style: TextStyle(
// // // //                       color: isSelected ? Colors.white : Colors.black,
// // // //                       fontWeight: FontWeight.bold,
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               );
// // // //             }),
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // حقول الطول والوزن
// // // //   // =====================================================
// // // //   Widget _buildMeasurementRow() {
// // // //     final bool isResolved = _selectedSizeIndex != -1;

// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //       child: Row(
// // // //         children: [
// // // //           Expanded(
// // // //             child: _buildMeasurementField(
// // // //               label: 'Height (cm)',
// // // //               hint: 'Enter your Height',
// // // //               controller: _heightController,
// // // //               isResolved: isResolved,
// // // //             ),
// // // //           ),
// // // //           Padding(
// // // //             padding: const EdgeInsets.symmetric(horizontal: 10),
// // // //             child: SvgPicture.asset('icons/fa6-solid_person.svg'),
// // // //           ),
// // // //           Expanded(
// // // //             child: _buildMeasurementField(
// // // //               label: 'Weight (kg)',
// // // //               hint: 'Enter your weight',
// // // //               controller: _weightController,
// // // //               isResolved: isResolved,
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildMeasurementField({
// // // //     required String label,
// // // //     required String hint,
// // // //     required TextEditingController controller,
// // // //     required bool isResolved,
// // // //   }) {
// // // //     return Column(
// // // //       crossAxisAlignment: CrossAxisAlignment.center,
// // // //       children: [
// // // //         Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
// // // //         const SizedBox(height: 6),
// // // //         TextField(
// // // //           controller: controller,
// // // //           keyboardType: TextInputType.number,
// // // //           onChanged: (value) => _calculateSizeFromInput(),
// // // //           textAlign: TextAlign.center,
// // // //           cursorColor: const Color.fromARGB(255, 243, 246, 246),
// // // //           cursorWidth: 1.5,
// // // //           style: TextStyle(
// // // //             color: isResolved ? Colors.white : Colors.black,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //           decoration: InputDecoration(
// // // //             hintText: hint,
// // // //             hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
// // // //             fillColor: isResolved
// // // //                 ? AppColors.tealGray
// // // //                 : AppColors.fieldFocus,
// // // //             filled: true,
// // // //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// // // //             enabledBorder: OutlineInputBorder(
// // // //               borderRadius: BorderRadius.circular(12),
// // // //               borderSide: BorderSide(
// // // //                 color: isResolved ? AppColors.tealGray : Colors.grey.withOpacity(0.3),
// // // //                 width: isResolved ? 1.5 : 1,
// // // //               ),
// // // //             ),
// // // //             focusedBorder: OutlineInputBorder(
// // // //               borderRadius: BorderRadius.circular(12),
// // // //               borderSide: const BorderSide(color: AppColors.tealGray, width: 2),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // الوصف — Read More / Read Less شغالة فعلياً
// // // //   // =====================================================
// // // //   Widget _buildDescription() {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           const Text(
// // // //             'Description',
// // // //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
// // // //           ),
// // // //           const SizedBox(height: 8),
// // // //           AnimatedCrossFade(
// // // //             duration: const Duration(milliseconds: 250),
// // // //             crossFadeState: _isDescriptionExpanded
// // // //                 ? CrossFadeState.showSecond
// // // //                 : CrossFadeState.showFirst,
// // // //             firstChild: const Text(
// // // //               _description,
// // // //               maxLines: 2,
// // // //               overflow: TextOverflow.ellipsis,
// // // //               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
// // // //             ),
// // // //             secondChild: const Text(
// // // //               _description,
// // // //               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
// // // //             ),
// // // //           ),
// // // //           const SizedBox(height: 4),
// // // //           GestureDetector(
// // // //             onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
// // // //             child: Text(
// // // //               _isDescriptionExpanded ? 'Read Less' : 'Read More...',
// // // //               style: const TextStyle(color: AppColors.tealGray, fontWeight: FontWeight.bold),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // المراجعات
// // // //   // =====================================================
// // // //   Widget _buildReviews() {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // // //       child: Column(
// // // //         children: [
// // // //           Row(
// // // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // // //             children: [
// // // //               const Text(
// // // //                 'Reviews',
// // // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
// // // //               ),
// // // //               TextButton(
// // // //                 onPressed: () {},
// // // //                 style: TextButton.styleFrom(
// // // //                   padding: EdgeInsets.zero,
// // // //                   minimumSize: Size.zero,
// // // //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// // // //                 ),
// // // //                 child: const Text(
// // // //                   'View All',
// // // //                   style: TextStyle(fontSize: 14, color: AppColors.tealGray, fontWeight: FontWeight.w500),
// // // //                 ),
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           _buildReviewCard(),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildReviewCard() {
// // // //     return Container(
// // // //       width: double.infinity,
// // // //       padding: const EdgeInsets.all(16),
// // // //       decoration: BoxDecoration(
// // // //         color: AppColors.background,
// // // //         borderRadius: BorderRadius.circular(16),
// // // //         border: Border.all(color: const Color(0xFFEFEFEF), width: 1),
// // // //         boxShadow: [
// // // //           BoxShadow(
// // // //             color: Colors.black.withOpacity(0.04),
// // // //             blurRadius: 12,
// // // //             offset: const Offset(0, 4),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           Row(
// // // //             crossAxisAlignment: CrossAxisAlignment.start,
// // // //             children: [
// // // //               const CircleAvatar(
// // // //                 radius: 22,
// // // //                 backgroundColor: Colors.white,
// // // //                 backgroundImage: AssetImage('images/human.png'),
// // // //               ),
// // // //               const SizedBox(width: 12),
// // // //               Expanded(
// // // //                 child: Column(
// // // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // // //                   children: [
// // // //                     const Text(
// // // //                       'Ronald Richards',
// // // //                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
// // // //                     ),
// // // //                     const SizedBox(height: 4),
// // // //                     Row(
// // // //                       children: [
// // // //                         Icon(Icons.access_time, size: 14, color: const Color(0xFF8F959E).withOpacity(0.7)),
// // // //                         const SizedBox(width: 4),
// // // //                         const Text(
// // // //                           '13 Sep, 2020',
// // // //                           style: TextStyle(fontSize: 11, color: Color(0xFF8F959E)),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ],
// // // //                 ),
// // // //               ),
// // // //               Column(
// // // //                 crossAxisAlignment: CrossAxisAlignment.end,
// // // //                 children: [
// // // //                   RichText(
// // // //                     text: const TextSpan(
// // // //                       style: TextStyle(fontSize: 14, color: Colors.black),
// // // //                       children: [
// // // //                         TextSpan(text: '4.0 ', style: TextStyle(fontWeight: FontWeight.bold)),
// // // //                         TextSpan(text: 'rating', style: TextStyle(color: Color(0xFF8F959E), fontSize: 12)),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                   const SizedBox(height: 4),
// // // //                   Row(
// // // //                     children: List.generate(5, (index) {
// // // //                       return Icon(
// // // //                         index < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
// // // //                         size: 16,
// // // //                         color: index < 4 ? const Color(0xFFFFD700) : const Color(0xFFD1D1D6),
// // // //                       );
// // // //                     }),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //             ],
// // // //           ),
// // // //           const SizedBox(height: 12),
// // // //           const Text(
// // // //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
// // // //             'Pellentesque malesuada eget vitae amet...',
// // // //             style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.4),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }

// // // //   // =====================================================
// // // //   // السعر الإجمالي + Add to Cart
// // // //   // =====================================================
// // // //   Widget _buildPriceAndCart() {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.only(left: 16, right: 16),
// // // //       child: Row(
// // // //         children: [
// // // //           const Expanded(
// // // //             child: Column(
// // // //               crossAxisAlignment: CrossAxisAlignment.start,
// // // //               children: [
// // // //                 Text('Total Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // // //                 Text('with VAT, SD 2%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF8F959E))),
// // // //                 Text('EGP 612', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //           Expanded(
// // // //             child: SizedBox(
// // // //               height: 60,
// // // //               child: ElevatedButton(
// // // //                 onPressed: () {
// // // //                   // TODO: أكشن إضافة المنتج للعربة
// // // //                 },
// // // //                 style: ElevatedButton.styleFrom(
// // // //                   backgroundColor: const Color(0xFFF5F6F8),
// // // //                   foregroundColor: AppColors.tealGray,
// // // //                   elevation: 6,
// // // //                   shadowColor: Colors.black.withOpacity(0.3),
// // // //                   shape: const StadiumBorder(),
// // // //                 ),
// // // //                 child: const Text(
// // // //                   'Add to Cart',
// // // //                   style: TextStyle(
// // // //                     color: AppColors.tealGray,
// // // //                     fontSize: 18,
// // // //                     fontWeight: FontWeight.bold,
// // // //                     letterSpacing: 0.5,
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // /// حدود مقاس واحد (طول ووزن) — يسهّل مطابقة وحفظ المقاسات في مكان واحد
// // // // /// بدل تكرار أرقام مبعثرة في أكتر من دالة.
// // // // class _SizeRange {
// // // //   final double minH;
// // // //   final double maxH;
// // // //   final double minW;
// // // //   final double maxW;

// // // //   const _SizeRange({
// // // //     required this.minH,
// // // //     required this.maxH,
// // // //     required this.minW,
// // // //     required this.maxW,
// // // //   });

// // // //   bool matchesBoth(double height, double weight) {
// // // //     return matchesHeight(height) && matchesWeight(weight);
// // // //   }

// // // //   bool matchesHeight(double height) => height >= minH && height <= maxH;

// // // //   bool matchesWeight(double weight) => weight >= minW && weight <= maxW;
// // // // }


// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_svg/flutter_svg.dart';
// // // import 'package:project/colors.dart';

// // // class ProductDetails extends StatefulWidget {
// // //   const ProductDetails({super.key});

// // //   @override
// // //   State<ProductDetails> createState() => _ProductDetailsState();
// // // }

// // // class _ProductDetailsState extends State<ProductDetails> {
// // //   // -1 يعني مفيش مقاس متحدد لسه
// // //   int _selectedSizeIndex = -1;
// // //   int _selectedColorIndex = 0;
// // //   int _currentImageIndex = 1;
// // //   bool _isFavorite = false;
// // //   bool _isDescriptionExpanded = false;

// // //   // true وقت ما إحنا بنملى التيكست فيلدز برمجياً (بعد الضغط على زرار مقاس)
// // //   // عشان الـ onChanged مايعملش حسبة تانية على نفس القيمة ويلخبط الحالة.
// // //   bool _isProgrammaticUpdate = false;

// // //   final TextEditingController _heightController = TextEditingController();
// // //   final TextEditingController _weightController = TextEditingController();

// // //   final List<String> productSizes = ['S', 'M', 'L', 'XL', '2XL'];
// // //   final List<Color> productColors = [
// // //     const Color(0xFF98E4CE), // مينت جرين
// // //     const Color(0xFF2C629E), // أزرق
// // //     const Color(0xFF8B1A1A), // نبيتي
// // //   ];
// // //   final List<String> images = [
// // //     'images/human.png',
// // //     'images/human.png',
// // //     'images/human.png',
// // //   ];

// // //   static const String _description =
// // //       'The Nike Throwback Pullover Hoodie is made from premium French '
// // //       'terry fabric that blends a performance feel with everyday comfort. '
// // //       'A relaxed fit and soft brushed interior keep you warm without '
// // //       'weighing you down, while the ribbed cuffs and hem lock in heat '
// // //       'on cool days.';

// // //   // كل مقاس وحدوده (طول/وزن) في مكان واحد — أسهل في الصيانة من
// // //   // تكرار الأرقام في أكتر من دالة.
// // //   static const List<_SizeRange> _sizeRanges = [
// // //     _SizeRange(minH: 150, maxH: 164, minW: 50, maxW: 64),
// // //     _SizeRange(minH: 165, maxH: 173, minW: 65, maxW: 73),
// // //     _SizeRange(minH: 174, maxH: 180, minW: 74, maxW: 85),
// // //     _SizeRange(minH: 181, maxH: 190, minW: 86, maxW: 95),
// // //     _SizeRange(minH: 191, maxH: 200, minW: 96, maxW: 110),
// // //   ];

// // //   // -----------------------------------------------------------------
// // //   // 1) المستخدم بيكتب طول ووزن بإيده -> نحدد المقاس المناسب أوتوماتيك
// // //   // -----------------------------------------------------------------
// // //   void _calculateSizeFromInput() {
// // //     if (_isProgrammaticUpdate) return;

// // //     final String heightText = _heightController.text.trim();
// // //     final String weightText = _weightController.text.trim();

// // //     if (heightText.isEmpty && weightText.isEmpty) {
// // //       if (_selectedSizeIndex != -1) {
// // //         setState(() => _selectedSizeIndex = -1);
// // //       }
// // //       return;
// // //     }

// // //     final double? height = double.tryParse(heightText);
// // //     final double? weight = double.tryParse(weightText);

// // //     // لسه المستخدم بيكتب / أو القيمة رينج جاية من زرار مقاس -> متعملش حاجة
// // //     if (height == null && weight == null) return;

// // //     final int newSizeIndex = _resolveSizeIndex(height, weight);

// // //     if (newSizeIndex != _selectedSizeIndex) {
// // //       setState(() => _selectedSizeIndex = newSizeIndex);
// // //     }
// // //   }

// // //   /// بيدور على أفضل مقاس مطابق:
// // //   /// 1) مطابقة كاملة: الطول والوزن الاتنين جوه نفس المقاس.
// // //   /// 2) لو مفيش مطابقة كاملة، مطابقة جزئية بالوزن بس (لو موجود).
// // //   /// 3) لو برضو مفيش، مطابقة جزئية بالطول بس (لو موجود).
// // //   /// كده لو كتبت طول برا النطاق لكن الوزن صح، أو العكس، برضو
// // //   /// هيتحدد مقاس بدل ما يفضل من غير أي اختيار.
// // //   int _resolveSizeIndex(double? height, double? weight) {
// // //     if (height != null && weight != null) {
// // //       for (int i = 0; i < _sizeRanges.length; i++) {
// // //         if (_sizeRanges[i].matchesBoth(height, weight)) return i;
// // //       }
// // //     }

// // //     if (weight != null) {
// // //       for (int i = 0; i < _sizeRanges.length; i++) {
// // //         if (_sizeRanges[i].matchesWeight(weight)) return i;
// // //       }
// // //     }

// // //     if (height != null) {
// // //       for (int i = 0; i < _sizeRanges.length; i++) {
// // //         if (_sizeRanges[i].matchesHeight(height)) return i;
// // //       }
// // //     }

// // //     return -1;
// // //   }

// // //   // -----------------------------------------------------------------
// // //   // 2) المستخدم بيضغط على زرار مقاس -> نملى الرينج المناسب في الفيلدز
// // //   // -----------------------------------------------------------------
// // //   void _setRangeFromSize(int sizeIndex) {
// // //     final _SizeRange range = _sizeRanges[sizeIndex];
// // //     _isProgrammaticUpdate = true;
// // //     setState(() {
// // //       _selectedSizeIndex = sizeIndex;
// // //       _heightController.text = '${range.minH} ~ ${range.maxH}';
// // //       _weightController.text = '${range.minW} ~ ${range.maxW}';
// // //     });
// // //     // نفك القفل بعد ما الفريم يخلص، عشان أي تعديل يدوي بعد كده
// // //     // يترصد بشكل طبيعي تاني.
// // //     WidgetsBinding.instance.addPostFrameCallback((_) {
// // //       _isProgrammaticUpdate = false;
// // //     });
// // //   }

// // //   @override
// // //   void dispose() {
// // //     _heightController.dispose();
// // //     _weightController.dispose();
// // //     super.dispose();
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //         backgroundColor: AppColors.background,
// // //         leading: const Icon(Icons.arrow_back_ios),
// // //         title: const Text(
// // //           'Product Details',
// // //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// // //         ),
// // //         centerTitle: true,
// // //       ),
// // //       body: Container(
// // //         width: double.infinity,
// // //         height: double.infinity,
// // //         decoration: const BoxDecoration(color: AppColors.background),
// // //         child: SingleChildScrollView(
// // //           padding: const EdgeInsets.only(bottom: 30),
// // //           child: Column(
// // //             children: [
// // //               const SizedBox(height: 24),
// // //               _buildImageCarousel(),
// // //               const SizedBox(height: 12),
// // //               _buildImageIndicator(),
// // //               const SizedBox(height: 33),
// // //               _buildProductHeader(),
// // //               const SizedBox(height: 24),
// // //               _buildTryOnMe(),
// // //               const SizedBox(height: 24),
// // //               _buildColorSelector(),
// // //               const SizedBox(height: 24),
// // //               _buildSizeSelector(),
// // //               const SizedBox(height: 24),
// // //               _buildMeasurementRow(),
// // //               const SizedBox(height: 32),
// // //               _buildDescription(),
// // //               const SizedBox(height: 24),
// // //               _buildReviews(),
// // //               const SizedBox(height: 24),
// // //               _buildPriceAndCart(),
// // //             ],
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // =====================================================
// // //   // صور الكاروسيل
// // //   // =====================================================
// // //   Widget _buildImageCarousel() {
// // //     return SizedBox(
// // //       height: 340,
// // //       child: PageView.builder(
// // //         controller: PageController(initialPage: 1, viewportFraction: 0.55),
// // //         itemCount: images.length,
// // //         onPageChanged: (index) {
// // //           setState(() => _currentImageIndex = index);
// // //         },
// // //         itemBuilder: (context, index) {
// // //           final bool isActive = _currentImageIndex == index;
// // //           final double scale = isActive ? 1.0 : 0.85;
// // //           // ظل "طيران" أقوى وأوضح على الصورة النشطة، وأخف على الصور
// // //           // الجانبية عشان الإحساس بالعمق يبقى طبيعي مع تغيير الحجم.
// // //           return Transform.scale(
// // //             scale: scale,
// // //             child: Container(
// // //               margin: const EdgeInsets.symmetric(horizontal: 4),
// // //               decoration: BoxDecoration(
// // //                 borderRadius: BorderRadius.circular(24),
// // //                 border: Border.all(
// // //                   color: Colors.grey.withOpacity(0.3),
// // //                   width: 1,
// // //                 ),
// // //                 image: DecorationImage(
// // //                   image: AssetImage(images[index]),
// // //                   fit: BoxFit.cover,
// // //                 ),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.black.withOpacity(isActive ? 0.22 : 0.12),
// // //                     blurRadius: isActive ? 28 : 16,
// // //                     spreadRadius: isActive ? 1 : 0,
// // //                     offset: Offset(0, isActive ? 18 : 10),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildImageIndicator() {
// // //     return Row(
// // //       mainAxisAlignment: MainAxisAlignment.center,
// // //       children: List.generate(images.length, (index) {
// // //         final bool isActive = _currentImageIndex == index;
// // //         return AnimatedContainer(
// // //           duration: const Duration(milliseconds: 300),
// // //           margin: const EdgeInsets.symmetric(horizontal: 3),
// // //           height: 6,
// // //           width: isActive ? 18 : 6,
// // //           decoration: BoxDecoration(
// // //             color: isActive ? AppColors.tealGray : const Color(0xFFCCCCCC),
// // //             borderRadius: BorderRadius.circular(3),
// // //           ),
// // //         );
// // //       }),
// // //     );
// // //   }

// // //   // =====================================================
// // //   // اسم المنتج + السعر + اللايك + التقييم
// // //   // =====================================================
// // //   Widget _buildProductHeader() {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // //       child: Row(
// // //         children: [
// // //           const Column(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               Text(
// // //                 'Best Seller',
// // //                 style: TextStyle(
// // //                   fontSize: 13,
// // //                   fontWeight: FontWeight.w500,
// // //                   color: Color(0xFF8F959E),
// // //                 ),
// // //               ),
// // //               Text(
// // //                 'Nike Club Fleece',
// // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
// // //               ),
// // //               Text(
// // //                 'L.E 600',
// // //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
// // //               ),
// // //             ],
// // //           ),
// // //           const Spacer(),
// // //           Column(
// // //             children: [
// // //               const SizedBox(height: 4),
// // //               _buildFavoriteButton(),
// // //               const SizedBox(height: 16),
// // //               const Row(
// // //                 children: [
// // //                   Icon(Icons.star, color: Colors.amber),
// // //                   SizedBox(width: 8),
// // //                   Text('5.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildFavoriteButton() {
// // //     return GestureDetector(
// // //       onTap: () => setState(() => _isFavorite = !_isFavorite),
// // //       child: AnimatedContainer(
// // //         duration: const Duration(milliseconds: 200),
// // //         padding: const EdgeInsets.all(12),
// // //         decoration: BoxDecoration(
// // //           shape: BoxShape.circle,
// // //           gradient: LinearGradient(
// // //             begin: Alignment.topLeft,
// // //             end: Alignment.bottomRight,
// // //             colors: [
// // //               const Color.fromARGB(103, 249, 248, 248).withOpacity(0.9),
// // //               const Color.fromARGB(69, 201, 199, 199).withOpacity(0.6),
// // //             ],
// // //           ),
// // //           boxShadow: [
// // //             BoxShadow(
// // //               color: Colors.black.withOpacity(0.08),
// // //               blurRadius: 15,
// // //               spreadRadius: 2,
// // //               offset: const Offset(0, 5),
// // //             ),
// // //           ],
// // //           border: Border.all(
// // //             color: const Color.fromARGB(255, 192, 191, 191).withOpacity(0.6),
// // //             width: 1.5,
// // //           ),
// // //         ),
// // //         child: AnimatedSwitcher(
// // //           duration: const Duration(milliseconds: 200),
// // //           transitionBuilder: (child, animation) =>
// // //               ScaleTransition(scale: animation, child: child),
// // //           child: Icon(
// // //             _isFavorite ? Icons.favorite : Icons.favorite_border,
// // //             key: ValueKey<bool>(_isFavorite),
// // //             color: _isFavorite ? Colors.red : Colors.black,
// // //             size: 24,
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   // =====================================================
// // //   // Try on Me
// // //   // =====================================================
// // //   Widget _buildTryOnMe() {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           const Row(
// // //             children: [
// // //               Text('Try on Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // //               Spacer(),
// // //               Text(
// // //                 'Virtual Simulation',
// // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 15),
// // //           Row(
// // //             children: [
// // //               Icon(Icons.info_outline, color: AppColors.gray, size: 14),
// // //               const SizedBox(width: 4),
// // //               Text(
// // //                 'Confidence fit: 95%',
// // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.gray),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 8),
// // //           Center(child: Image.asset('images/avatar.png', height: 343)),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // =====================================================
// // //   // الألوان
// // //   // =====================================================
// // //   Widget _buildColorSelector() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const Padding(
// // //           padding: EdgeInsets.symmetric(horizontal: 16),
// // //           child: Row(
// // //             children: [
// // //               Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // //               Spacer(),
// // //               Text(
// // //                 'Colors Available',
// // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         Padding(
// // //           padding: const EdgeInsets.only(left: 16),
// // //           child: Row(
// // //             children: List.generate(productColors.length, (index) {
// // //               final bool isSelected = _selectedColorIndex == index;
// // //               return GestureDetector(
// // //                 onTap: () => setState(() => _selectedColorIndex = index),
// // //                 child: Container(
// // //                   margin: const EdgeInsets.only(right: 12),
// // //                   decoration: BoxDecoration(
// // //                     shape: BoxShape.circle,
// // //                     border: Border.all(
// // //                       color: isSelected ? AppColors.tealGray : Colors.transparent,
// // //                       width: 2,
// // //                     ),
// // //                     boxShadow: [
// // //                       BoxShadow(
// // //                         // ظل بلون الدائرة نفسها بدل ظل رمادي عادي، عشان
// // //                         // يبان كل لون طاير بتوهجه الخاص بدل ظل موحد.
// // //                         color: productColors[index].withOpacity(0.45),
// // //                         blurRadius: isSelected ? 14 : 8,
// // //                         spreadRadius: isSelected ? 1 : 0,
// // //                         offset: const Offset(0, 4),
// // //                       ),
// // //                     ],
// // //                   ),
// // //                   child: CircleAvatar(
// // //                     radius: 18,
// // //                     backgroundColor: productColors[index],
// // //                   ),
// // //                 ),
// // //               );
// // //             }),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // =====================================================
// // //   // المقاسات
// // //   // =====================================================
// // //   Widget _buildSizeSelector() {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.start,
// // //       children: [
// // //         const Padding(
// // //           padding: EdgeInsets.symmetric(horizontal: 16),
// // //           child: Row(
// // //             children: [
// // //               Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // //               Spacer(),
// // //               Text(
// // //                 'Size Guide',
// // //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// // //               ),
// // //             ],
// // //           ),
// // //         ),
// // //         const SizedBox(height: 12),
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 16),
// // //           child: Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: List.generate(productSizes.length, (index) {
// // //               final bool isSelected = _selectedSizeIndex == index;
// // //               return GestureDetector(
// // //                 onTap: () => _setRangeFromSize(index),
// // //                 child: AnimatedContainer(
// // //                   duration: const Duration(milliseconds: 200),
// // //                   width: 55,
// // //                   height: 50,
// // //                   decoration: BoxDecoration(
// // //                     color: isSelected ? AppColors.tealGray : Colors.white,
// // //                     borderRadius: BorderRadius.circular(12),
// // //                     border: Border.all(
// // //                       color: isSelected ? Colors.transparent : Colors.grey.withOpacity(0.2),
// // //                     ),
// // //                   ),
// // //                   alignment: Alignment.center,
// // //                   child: Text(
// // //                     productSizes[index],
// // //                     style: TextStyle(
// // //                       color: isSelected ? Colors.white : Colors.black,
// // //                       fontWeight: FontWeight.bold,
// // //                     ),
// // //                   ),
// // //                 ),
// // //               );
// // //             }),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // =====================================================
// // //   // حقول الطول والوزن
// // //   // =====================================================
// // //   Widget _buildMeasurementRow() {
// // //     final bool isResolved = _selectedSizeIndex != -1;

// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // //       child: Row(
// // //         children: [
// // //           Expanded(
// // //             child: _buildMeasurementField(
// // //               label: 'Height (cm)',
// // //               hint: 'Enter your Height',
// // //               controller: _heightController,
// // //               isResolved: isResolved,
// // //             ),
// // //           ),
// // //           Padding(
// // //             padding: const EdgeInsets.symmetric(horizontal: 10),
// // //             child: SvgPicture.asset('icons/fa6-solid_person.svg'),
// // //           ),
// // //           Expanded(
// // //             child: _buildMeasurementField(
// // //               label: 'Weight (kg)',
// // //               hint: 'Enter your weight',
// // //               controller: _weightController,
// // //               isResolved: isResolved,
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildMeasurementField({
// // //     required String label,
// // //     required String hint,
// // //     required TextEditingController controller,
// // //     required bool isResolved,
// // //   }) {
// // //     return Column(
// // //       crossAxisAlignment: CrossAxisAlignment.center,
// // //       children: [
// // //         Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
// // //         const SizedBox(height: 6),
// // //         TextField(
// // //           controller: controller,
// // //           keyboardType: TextInputType.number,
// // //           onChanged: (value) => _calculateSizeFromInput(),
// // //           textAlign: TextAlign.center,
// // //           cursorColor: const Color.fromARGB(255, 243, 246, 246),
// // //           cursorWidth: 1.5,
// // //           style: TextStyle(
// // //             color: isResolved ? Colors.white : Colors.black,
// // //             fontWeight: FontWeight.bold,
// // //           ),
// // //           decoration: InputDecoration(
// // //             hintText: hint,
// // //             hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
// // //             fillColor: isResolved
// // //                 ? AppColors.tealGray
// // //                 : AppColors.fieldFocus,
// // //             filled: true,
// // //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// // //             enabledBorder: OutlineInputBorder(
// // //               borderRadius: BorderRadius.circular(12),
// // //               borderSide: BorderSide(
// // //                 color: isResolved ? AppColors.tealGray : Colors.grey.withOpacity(0.3),
// // //                 width: isResolved ? 1.5 : 1,
// // //               ),
// // //             ),
// // //             focusedBorder: OutlineInputBorder(
// // //               borderRadius: BorderRadius.circular(12),
// // //               borderSide: const BorderSide(color: AppColors.tealGray, width: 2),
// // //             ),
// // //           ),
// // //         ),
// // //       ],
// // //     );
// // //   }

// // //   // =====================================================
// // //   // الوصف — Read More / Read Less شغالة فعلياً
// // //   // =====================================================
// // //   Widget _buildDescription() {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           const Text(
// // //             'Description',
// // //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
// // //           ),
// // //           const SizedBox(height: 8),
// // //           AnimatedCrossFade(
// // //             duration: const Duration(milliseconds: 250),
// // //             crossFadeState: _isDescriptionExpanded
// // //                 ? CrossFadeState.showSecond
// // //                 : CrossFadeState.showFirst,
// // //             firstChild: const Text(
// // //               _description,
// // //               maxLines: 2,
// // //               overflow: TextOverflow.ellipsis,
// // //               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
// // //             ),
// // //             secondChild: const Text(
// // //               _description,
// // //               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
// // //             ),
// // //           ),
// // //           const SizedBox(height: 4),
// // //           GestureDetector(
// // //             onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
// // //             child: Text(
// // //               _isDescriptionExpanded ? 'Read Less' : 'Read More...',
// // //               style: const TextStyle(color: AppColors.tealGray, fontWeight: FontWeight.bold),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // =====================================================
// // //   // المراجعات
// // //   // =====================================================
// // //   Widget _buildReviews() {
// // //     return Padding(
// // //       padding: const EdgeInsets.symmetric(horizontal: 16),
// // //       child: Column(
// // //         children: [
// // //           Row(
// // //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //             children: [
// // //               const Text(
// // //                 'Reviews',
// // //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
// // //               ),
// // //               TextButton(
// // //                 onPressed: () {},
// // //                 style: TextButton.styleFrom(
// // //                   padding: EdgeInsets.zero,
// // //                   minimumSize: Size.zero,
// // //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// // //                 ),
// // //                 child: const Text(
// // //                   'View All',
// // //                   style: TextStyle(fontSize: 14, color: AppColors.tealGray, fontWeight: FontWeight.w500),
// // //                 ),
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 12),
// // //           _buildReviewCard(),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildReviewCard() {
// // //     return Container(
// // //       width: double.infinity,
// // //       padding: const EdgeInsets.all(16),
// // //       decoration: BoxDecoration(
// // //         color: AppColors.background,
// // //         borderRadius: BorderRadius.circular(16),
// // //         border: Border.all(color: const Color(0xFFEFEFEF), width: 1),
// // //         boxShadow: [
// // //           BoxShadow(
// // //             color: Colors.black.withOpacity(0.04),
// // //             blurRadius: 12,
// // //             offset: const Offset(0, 4),
// // //           ),
// // //         ],
// // //       ),
// // //       child: Column(
// // //         crossAxisAlignment: CrossAxisAlignment.start,
// // //         children: [
// // //           Row(
// // //             crossAxisAlignment: CrossAxisAlignment.start,
// // //             children: [
// // //               const CircleAvatar(
// // //                 radius: 22,
// // //                 backgroundColor: Colors.white,
// // //                 backgroundImage: AssetImage('images/human.png'),
// // //               ),
// // //               const SizedBox(width: 12),
// // //               Expanded(
// // //                 child: Column(
// // //                   crossAxisAlignment: CrossAxisAlignment.start,
// // //                   children: [
// // //                     const Text(
// // //                       'Ronald Richards',
// // //                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
// // //                     ),
// // //                     const SizedBox(height: 4),
// // //                     Row(
// // //                       children: [
// // //                         Icon(Icons.access_time, size: 14, color: const Color(0xFF8F959E).withOpacity(0.7)),
// // //                         const SizedBox(width: 4),
// // //                         const Text(
// // //                           '13 Sep, 2020',
// // //                           style: TextStyle(fontSize: 11, color: Color(0xFF8F959E)),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //               Column(
// // //                 crossAxisAlignment: CrossAxisAlignment.end,
// // //                 children: [
// // //                   RichText(
// // //                     text: const TextSpan(
// // //                       style: TextStyle(fontSize: 14, color: Colors.black),
// // //                       children: [
// // //                         TextSpan(text: '4.0 ', style: TextStyle(fontWeight: FontWeight.bold)),
// // //                         TextSpan(text: 'rating', style: TextStyle(color: Color(0xFF8F959E), fontSize: 12)),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 4),
// // //                   Row(
// // //                     children: List.generate(5, (index) {
// // //                       return Icon(
// // //                         index < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
// // //                         size: 16,
// // //                         color: index < 4 ? const Color(0xFFFFD700) : const Color(0xFFD1D1D6),
// // //                       );
// // //                     }),
// // //                   ),
// // //                 ],
// // //               ),
// // //             ],
// // //           ),
// // //           const SizedBox(height: 12),
// // //           const Text(
// // //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
// // //             'Pellentesque malesuada eget vitae amet...',
// // //             style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.4),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   // =====================================================
// // //   // السعر الإجمالي + Add to Cart
// // //   // =====================================================
// // //   Widget _buildPriceAndCart() {
// // //     return Padding(
// // //       padding: const EdgeInsets.only(left: 16, right: 16),
// // //       child: Row(
// // //         children: [
// // //           const Expanded(
// // //             child: Column(
// // //               crossAxisAlignment: CrossAxisAlignment.start,
// // //               children: [
// // //                 Text('Total Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// // //                 Text('with VAT, SD 2%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF8F959E))),
// // //                 Text('EGP 612', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
// // //               ],
// // //             ),
// // //           ),
// // //           Expanded(
// // //             child: SizedBox(
// // //               height: 60,
// // //               child: ElevatedButton(
// // //                 onPressed: () {
// // //                   // TODO: أكشن إضافة المنتج للعربة
// // //                 },
// // //                 style: ElevatedButton.styleFrom(
// // //                   backgroundColor: const Color(0xFFF5F6F8),
// // //                   foregroundColor: AppColors.tealGray,
// // //                   elevation: 6,
// // //                   shadowColor: Colors.black.withOpacity(0.3),
// // //                   shape: const StadiumBorder(),
// // //                 ),
// // //                 child: const Text(
// // //                   'Add to Cart',
// // //                   style: TextStyle(
// // //                     color: AppColors.tealGray,
// // //                     fontSize: 18,
// // //                     fontWeight: FontWeight.bold,
// // //                     letterSpacing: 0.5,
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }

// // // /// حدود مقاس واحد (طول ووزن) — يسهّل مطابقة وحفظ المقاسات في مكان واحد
// // // /// بدل تكرار أرقام مبعثرة في أكتر من دالة.
// // // class _SizeRange {
// // //   final double minH;
// // //   final double maxH;
// // //   final double minW;
// // //   final double maxW;

// // //   const _SizeRange({
// // //     required this.minH,
// // //     required this.maxH,
// // //     required this.minW,
// // //     required this.maxW,
// // //   });

// // //   bool matchesBoth(double height, double weight) {
// // //     return matchesHeight(height) && matchesWeight(weight);
// // //   }

// // //   bool matchesHeight(double height) => height >= minH && height <= maxH;

// // //   bool matchesWeight(double weight) => weight >= minW && weight <= maxW;
// // // }


// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:project/colors.dart';

// // class ProductDetails extends StatefulWidget {
// //   const ProductDetails({super.key});

// //   @override
// //   State<ProductDetails> createState() => _ProductDetailsState();
// // }

// // class _ProductDetailsState extends State<ProductDetails> {
// //   // -1 يعني مفيش مقاس متحدد لسه
// //   int _selectedSizeIndex = -1;
// //   int _selectedColorIndex = 0;
// //   int _currentImageIndex = 1;
// //   bool _isFavorite = false;
// //   bool _isDescriptionExpanded = false;

// //   // true وقت ما إحنا بنملى التيكست فيلدز برمجياً (بعد الضغط على زرار مقاس)
// //   // عشان الـ onChanged مايعملش حسبة تانية على نفس القيمة ويلخبط الحالة.
// //   bool _isProgrammaticUpdate = false;

// //   // true لما المستخدم يدوس Add to Cart من غير ما يختار مقاس -> نظهر رسالة
// //   // تحذير حمرا تحت الأحجام. بترجع false تاني أول ما يختار مقاس.
// //   bool _showSizeError = false;

// //   final TextEditingController _heightController = TextEditingController();
// //   final TextEditingController _weightController = TextEditingController();

// //   final List<String> productSizes = ['S', 'M', 'L', 'XL', '2XL'];
// //   final List<Color> productColors = [
// //     const Color(0xFF98E4CE), // مينت جرين
// //     const Color(0xFF2C629E), // أزرق
// //     const Color(0xFF8B1A1A), // نبيتي
// //   ];
// //   final List<String> images = [
// //     'images/human.png',
// //     'images/human.png',
// //     'images/human.png',
// //   ];

// //   static const String _description =
// //       'The Nike Throwback Pullover Hoodie is made from premium French '
// //       'terry fabric that blends a performance feel with everyday comfort. '
// //       'A relaxed fit and soft brushed interior keep you warm without '
// //       'weighing you down, while the ribbed cuffs and hem lock in heat '
// //       'on cool days.';

// //   // كل مقاس وحدوده (طول/وزن) في مكان واحد — أسهل في الصيانة من
// //   // تكرار الأرقام في أكتر من دالة.
// //   static const List<_SizeRange> _sizeRanges = [
// //     _SizeRange(minH: 150, maxH: 164, minW: 50, maxW: 64),
// //     _SizeRange(minH: 165, maxH: 173, minW: 65, maxW: 73),
// //     _SizeRange(minH: 174, maxH: 180, minW: 74, maxW: 85),
// //     _SizeRange(minH: 181, maxH: 190, minW: 86, maxW: 95),
// //     _SizeRange(minH: 191, maxH: 200, minW: 96, maxW: 110),
// //   ];

// //   // -----------------------------------------------------------------
// //   // 1) المستخدم بيكتب طول ووزن بإيده -> نحدد المقاس المناسب أوتوماتيك
// //   // -----------------------------------------------------------------
// //   void _calculateSizeFromInput() {
// //     if (_isProgrammaticUpdate) return;

// //     final String heightText = _heightController.text.trim();
// //     final String weightText = _weightController.text.trim();

// //     if (heightText.isEmpty && weightText.isEmpty) {
// //       if (_selectedSizeIndex != -1) {
// //         setState(() => _selectedSizeIndex = -1);
// //       }
// //       return;
// //     }

// //     final double? height = double.tryParse(heightText);
// //     final double? weight = double.tryParse(weightText);

// //     // لسه المستخدم بيكتب / أو القيمة رينج جاية من زرار مقاس -> متعملش حاجة
// //     if (height == null && weight == null) return;

// //     final int newSizeIndex = _resolveSizeIndex(height, weight);

// //     if (newSizeIndex != _selectedSizeIndex) {
// //       setState(() {
// //         _selectedSizeIndex = newSizeIndex;
// //         if (newSizeIndex != -1) _showSizeError = false;
// //       });
// //     }
// //   }

// //   /// بيدور على أفضل مقاس مطابق:
// //   /// 1) مطابقة كاملة: الطول والوزن الاتنين جوه نفس المقاس.
// //   /// 2) لو مفيش مطابقة كاملة، مطابقة جزئية بالوزن بس (لو موجود).
// //   /// 3) لو برضو مفيش، مطابقة جزئية بالطول بس (لو موجود).
// //   /// كده لو كتبت طول برا النطاق لكن الوزن صح، أو العكس، برضو
// //   /// هيتحدد مقاس بدل ما يفضل من غير أي اختيار.
// //   int _resolveSizeIndex(double? height, double? weight) {
// //     if (height != null && weight != null) {
// //       for (int i = 0; i < _sizeRanges.length; i++) {
// //         if (_sizeRanges[i].matchesBoth(height, weight)) return i;
// //       }
// //     }

// //     if (weight != null) {
// //       for (int i = 0; i < _sizeRanges.length; i++) {
// //         if (_sizeRanges[i].matchesWeight(weight)) return i;
// //       }
// //     }

// //     if (height != null) {
// //       for (int i = 0; i < _sizeRanges.length; i++) {
// //         if (_sizeRanges[i].matchesHeight(height)) return i;
// //       }
// //     }

// //     return -1;
// //   }

// //   // -----------------------------------------------------------------
// //   // 2) المستخدم بيضغط على زرار مقاس -> نملى الرينج المناسب في الفيلدز
// //   // -----------------------------------------------------------------
// //   void _setRangeFromSize(int sizeIndex) {
// //     final _SizeRange range = _sizeRanges[sizeIndex];
// //     _isProgrammaticUpdate = true;
// //     setState(() {
// //       _selectedSizeIndex = sizeIndex;
// //       _heightController.text = '${range.minH} ~ ${range.maxH}';
// //       _weightController.text = '${range.minW} ~ ${range.maxW}';
// //       _showSizeError = false;
// //     });
// //     // نفك القفل بعد ما الفريم يخلص، عشان أي تعديل يدوي بعد كده
// //     // يترصد بشكل طبيعي تاني.
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       _isProgrammaticUpdate = false;
// //     });
// //   }

// //   // -----------------------------------------------------------------
// //   // 3) دوسة Add to Cart -> لازم يكون فيه مقاس متحدد
// //   // -----------------------------------------------------------------
// //   void _onAddToCartPressed() {
// //     if (_selectedSizeIndex == -1) {
// //       setState(() => _showSizeError = true);
// //       return;
// //     }

// //     setState(() => _showSizeError = false);
// //     // TODO: أكشن إضافة المنتج للعربة الفعلي
// //   }

// //   @override
// //   void dispose() {
// //     _heightController.dispose();
// //     _weightController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: AppColors.background,
// //         leading: const Icon(Icons.arrow_back_ios),
// //         title: const Text(
// //           'Product Details',
// //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //         ),
// //         centerTitle: true,
// //       ),
// //       // الشريط بتاع السعر و Add to Cart بقى ثابت تحت الشاشة دايماً
// //       // ومبيتحركش مع السكرول.
// //       bottomNavigationBar: _buildBottomBar(),
// //       body: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         decoration: const BoxDecoration(color: AppColors.background),
// //         child: SingleChildScrollView(
// //           padding: const EdgeInsets.only(bottom: 16),
// //           child: Column(
// //             children: [
// //               const SizedBox(height: 24),
// //               _buildImageCarousel(),
// //               const SizedBox(height: 12),
// //               _buildImageIndicator(),
// //               const SizedBox(height: 33),
// //               _buildProductHeader(),
// //               const SizedBox(height: 24),
// //               _buildTryOnMe(),
// //               const SizedBox(height: 24),
// //               _buildColorSelector(),
// //               const SizedBox(height: 24),
// //               _buildSizeSelector(),
// //               const SizedBox(height: 24),
// //               _buildMeasurementRow(),
// //               const SizedBox(height: 32),
// //               _buildDescription(),
// //               const SizedBox(height: 24),
// //               _buildReviews(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // =====================================================
// //   // صور الكاروسيل
// //   // =====================================================
// //   Widget _buildImageCarousel() {
// //     return SizedBox(
// //       height: 340,
// //       child: PageView.builder(
// //         controller: PageController(initialPage: 1, viewportFraction: 0.55),
// //         itemCount: images.length,
// //         onPageChanged: (index) {
// //           setState(() => _currentImageIndex = index);
// //         },
// //         itemBuilder: (context, index) {
// //           final bool isActive = _currentImageIndex == index;
// //           final double scale = isActive ? 1.0 : 0.85;
// //           // ظل "طيران" أقوى وأوضح على الصورة النشطة، وأخف على الصور
// //           // الجانبية عشان الإحساس بالعمق يبقى طبيعي مع تغيير الحجم.
// //           return Transform.scale(
// //             scale: scale,
// //             child: Container(
// //               margin: const EdgeInsets.symmetric(horizontal: 4),
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(24),
// //                 border: Border.all(
// //                   color: Colors.grey.withOpacity(0.3),
// //                   width: 1,
// //                 ),
// //                 image: DecorationImage(
// //                   image: AssetImage(images[index]),
// //                   fit: BoxFit.cover,
// //                 ),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(isActive ? 0.22 : 0.12),
// //                     blurRadius: isActive ? 28 : 16,
// //                     spreadRadius: isActive ? 1 : 0,
// //                     offset: Offset(0, isActive ? 18 : 10),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildImageIndicator() {
// //     return Row(
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: List.generate(images.length, (index) {
// //         final bool isActive = _currentImageIndex == index;
// //         return AnimatedContainer(
// //           duration: const Duration(milliseconds: 300),
// //           margin: const EdgeInsets.symmetric(horizontal: 3),
// //           height: 6,
// //           width: isActive ? 18 : 6,
// //           decoration: BoxDecoration(
// //             color: isActive ? AppColors.tealGray : const Color(0xFFCCCCCC),
// //             borderRadius: BorderRadius.circular(3),
// //           ),
// //         );
// //       }),
// //     );
// //   }

// //   // =====================================================
// //   // اسم المنتج + السعر + اللايك + التقييم
// //   // =====================================================
// //   Widget _buildProductHeader() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Row(
// //         children: [
// //           const Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 'Best Seller',
// //                 style: TextStyle(
// //                   fontSize: 13,
// //                   fontWeight: FontWeight.w500,
// //                   color: Color(0xFF8F959E),
// //                 ),
// //               ),
// //               Text(
// //                 'Nike Club Fleece',
// //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
// //               ),
// //               Text(
// //                 'L.E 600',
// //                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
// //               ),
// //             ],
// //           ),
// //           const Spacer(),
// //           Column(
// //             children: [
// //               const SizedBox(height: 4),
// //               _buildFavoriteButton(),
// //               const SizedBox(height: 16),
// //               const Row(
// //                 children: [
// //                   Icon(Icons.star, color: Colors.amber),
// //                   SizedBox(width: 8),
// //                   Text('5.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
// //                 ],
// //               ),
// //             ],
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildFavoriteButton() {
// //     return GestureDetector(
// //       onTap: () => setState(() => _isFavorite = !_isFavorite),
// //       child: AnimatedContainer(
// //         duration: const Duration(milliseconds: 200),
// //         padding: const EdgeInsets.all(12),
// //         decoration: BoxDecoration(
// //           shape: BoxShape.circle,
// //           gradient: LinearGradient(
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //             colors: [
// //               const Color.fromARGB(103, 249, 248, 248).withOpacity(0.9),
// //               const Color.fromARGB(69, 201, 199, 199).withOpacity(0.6),
// //             ],
// //           ),
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.08),
// //               blurRadius: 15,
// //               spreadRadius: 2,
// //               offset: const Offset(0, 5),
// //             ),
// //           ],
// //           border: Border.all(
// //             color: const Color.fromARGB(255, 192, 191, 191).withOpacity(0.6),
// //             width: 1.5,
// //           ),
// //         ),
// //         child: AnimatedSwitcher(
// //           duration: const Duration(milliseconds: 200),
// //           transitionBuilder: (child, animation) =>
// //               ScaleTransition(scale: animation, child: child),
// //           child: Icon(
// //             _isFavorite ? Icons.favorite : Icons.favorite_border,
// //             key: ValueKey<bool>(_isFavorite),
// //             color: _isFavorite ? Colors.red : Colors.black,
// //             size: 24,
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   // =====================================================
// //   // Try on Me
// //   // =====================================================
// //   Widget _buildTryOnMe() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Row(
// //             children: [
// //               Text('Try on Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// //               Spacer(),
// //               Text(
// //                 'Virtual Simulation',
// //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 15),
// //           Row(
// //             children: [
// //               Icon(Icons.info_outline, color: AppColors.gray, size: 14),
// //               const SizedBox(width: 4),
// //               Text(
// //                 'Confidence fit: 95%',
// //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.gray),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 8),
// //           Center(child: Image.asset('images/avatar.png', height: 343)),
// //         ],
// //       ),
// //     );
// //   }

// //   // =====================================================
// //   // الألوان
// //   // =====================================================
// //   Widget _buildColorSelector() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 16),
// //           child: Row(
// //             children: [
// //               Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// //               Spacer(),
// //               Text(
// //                 'Colors Available',
// //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         Padding(
// //           padding: const EdgeInsets.only(left: 16),
// //           child: Row(
// //             children: List.generate(productColors.length, (index) {
// //               final bool isSelected = _selectedColorIndex == index;
// //               return GestureDetector(
// //                 onTap: () => setState(() => _selectedColorIndex = index),
// //                 child: Container(
// //                   margin: const EdgeInsets.only(right: 12),
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     border: Border.all(
// //                       color: isSelected ? AppColors.tealGray : Colors.transparent,
// //                       width: 2,
// //                     ),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         // ظل بلون الدائرة نفسها بدل ظل رمادي عادي، عشان
// //                         // يبان كل لون طاير بتوهجه الخاص بدل ظل موحد.
// //                         color: productColors[index].withOpacity(0.45),
// //                         blurRadius: isSelected ? 14 : 8,
// //                         spreadRadius: isSelected ? 1 : 0,
// //                         offset: const Offset(0, 4),
// //                       ),
// //                     ],
// //                   ),
// //                   child: CircleAvatar(
// //                     radius: 18,
// //                     backgroundColor: productColors[index],
// //                   ),
// //                 ),
// //               );
// //             }),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // =====================================================
// //   // المقاسات
// //   // =====================================================
// //   Widget _buildSizeSelector() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Padding(
// //           padding: EdgeInsets.symmetric(horizontal: 16),
// //           child: Row(
// //             children: [
// //               Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// //               Spacer(),
// //               Text(
// //                 'Size Guide',
// //                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16),
// //           child: Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: List.generate(productSizes.length, (index) {
// //               final bool isSelected = _selectedSizeIndex == index;
// //               return GestureDetector(
// //                 onTap: () => _setRangeFromSize(index),
// //                 child: AnimatedContainer(
// //                   duration: const Duration(milliseconds: 200),
// //                   width: 55,
// //                   height: 50,
// //                   decoration: BoxDecoration(
// //                     color: isSelected ? AppColors.tealGray : Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                     border: Border.all(
// //                       color: isSelected
// //                           ? Colors.transparent
// //                           : (_showSizeError
// //                               ? Colors.red.withOpacity(0.6)
// //                               : Colors.grey.withOpacity(0.2)),
// //                       width: (!isSelected && _showSizeError) ? 1.4 : 1,
// //                     ),
// //                   ),
// //                   alignment: Alignment.center,
// //                   child: Text(
// //                     productSizes[index],
// //                     style: TextStyle(
// //                       color: isSelected ? Colors.white : Colors.black,
// //                       fontWeight: FontWeight.bold,
// //                     ),
// //                   ),
// //                 ),
// //               );
// //             }),
// //           ),
// //         ),
// //         // رسالة التحذير بتظهر بس لما يدوس Add to Cart من غير ما
// //         // يكون مختار مقاس، وبتختفي أول ما يختار.
// //         AnimatedSize(
// //           duration: const Duration(milliseconds: 200),
// //           child: _showSizeError
// //               ? Padding(
// //                   padding: const EdgeInsets.only(left: 16, top: 8),
// //                   child: Row(
// //                     children: [
// //                       const Icon(Icons.error_outline, size: 15, color: Colors.red),
// //                       const SizedBox(width: 6),
// //                       Text(
// //                         'من فضلك اختر مقاس قبل الإضافة للعربة',
// //                         style: TextStyle(
// //                           fontSize: 12.5,
// //                           color: Colors.red.shade600,
// //                           fontWeight: FontWeight.w600,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 )
// //               : const SizedBox(width: double.infinity),
// //         ),
// //       ],
// //     );
// //   }

// //   // =====================================================
// //   // حقول الطول والوزن
// //   // =====================================================
// //   Widget _buildMeasurementRow() {
// //     final bool isResolved = _selectedSizeIndex != -1;

// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: _buildMeasurementField(
// //               label: 'Height (cm)',
// //               hint: 'Enter your Height',
// //               controller: _heightController,
// //               isResolved: isResolved,
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 10),
// //             child: SvgPicture.asset('icons/fa6-solid_person.svg'),
// //           ),
// //           Expanded(
// //             child: _buildMeasurementField(
// //               label: 'Weight (kg)',
// //               hint: 'Enter your weight',
// //               controller: _weightController,
// //               isResolved: isResolved,
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildMeasurementField({
// //     required String label,
// //     required String hint,
// //     required TextEditingController controller,
// //     required bool isResolved,
// //   }) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.center,
// //       children: [
// //         Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
// //         const SizedBox(height: 6),
// //         TextField(
// //           controller: controller,
// //           keyboardType: TextInputType.number,
// //           onChanged: (value) => _calculateSizeFromInput(),
// //           textAlign: TextAlign.center,
// //           cursorColor: const Color.fromARGB(255, 243, 246, 246),
// //           cursorWidth: 1.5,
// //           style: TextStyle(
// //             color: isResolved ? Colors.white : Colors.black,
// //             fontWeight: FontWeight.bold,
// //           ),
// //           decoration: InputDecoration(
// //             hintText: hint,
// //             hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
// //             fillColor: isResolved
// //                 ? AppColors.tealGray
// //                 : AppColors.fieldFocus,
// //             filled: true,
// //             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
// //             enabledBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: BorderSide(
// //                 color: isResolved ? AppColors.tealGray : Colors.grey.withOpacity(0.3),
// //                 width: isResolved ? 1.5 : 1,
// //               ),
// //             ),
// //             focusedBorder: OutlineInputBorder(
// //               borderRadius: BorderRadius.circular(12),
// //               borderSide: const BorderSide(color: AppColors.tealGray, width: 2),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   // =====================================================
// //   // الوصف — Read More / Read Less شغالة فعلياً
// //   // =====================================================
// //   Widget _buildDescription() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const Text(
// //             'Description',
// //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
// //           ),
// //           const SizedBox(height: 8),
// //           AnimatedCrossFade(
// //             duration: const Duration(milliseconds: 250),
// //             crossFadeState: _isDescriptionExpanded
// //                 ? CrossFadeState.showSecond
// //                 : CrossFadeState.showFirst,
// //             firstChild: const Text(
// //               _description,
// //               maxLines: 2,
// //               overflow: TextOverflow.ellipsis,
// //               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
// //             ),
// //             secondChild: const Text(
// //               _description,
// //               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
// //             ),
// //           ),
// //           const SizedBox(height: 4),
// //           GestureDetector(
// //             onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
// //             child: Text(
// //               _isDescriptionExpanded ? 'Read Less' : 'Read More...',
// //               style: const TextStyle(color: AppColors.tealGray, fontWeight: FontWeight.bold),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // =====================================================
// //   // المراجعات
// //   // =====================================================
// //   Widget _buildReviews() {
// //     return Padding(
// //       padding: const EdgeInsets.symmetric(horizontal: 16),
// //       child: Column(
// //         children: [
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               const Text(
// //                 'Reviews',
// //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
// //               ),
// //               TextButton(
// //                 onPressed: () {},
// //                 style: TextButton.styleFrom(
// //                   padding: EdgeInsets.zero,
// //                   minimumSize: Size.zero,
// //                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
// //                 ),
// //                 child: const Text(
// //                   'View All',
// //                   style: TextStyle(fontSize: 14, color: AppColors.tealGray, fontWeight: FontWeight.w500),
// //                 ),
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           _buildReviewCard(),
// //         ],
// //       ),
// //     );
// //   }

// //   Widget _buildReviewCard() {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(16),
// //       decoration: BoxDecoration(
// //         color: AppColors.background,
// //         borderRadius: BorderRadius.circular(16),
// //         border: Border.all(color: const Color(0xFFEFEFEF), width: 1),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black.withOpacity(0.04),
// //             blurRadius: 12,
// //             offset: const Offset(0, 4),
// //           ),
// //         ],
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Row(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const CircleAvatar(
// //                 radius: 22,
// //                 backgroundColor: Colors.white,
// //                 backgroundImage: AssetImage('images/human.png'),
// //               ),
// //               const SizedBox(width: 12),
// //               Expanded(
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     const Text(
// //                       'Ronald Richards',
// //                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
// //                     ),
// //                     const SizedBox(height: 4),
// //                     Row(
// //                       children: [
// //                         Icon(Icons.access_time, size: 14, color: const Color(0xFF8F959E).withOpacity(0.7)),
// //                         const SizedBox(width: 4),
// //                         const Text(
// //                           '13 Sep, 2020',
// //                           style: TextStyle(fontSize: 11, color: Color(0xFF8F959E)),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               Column(
// //                 crossAxisAlignment: CrossAxisAlignment.end,
// //                 children: [
// //                   RichText(
// //                     text: const TextSpan(
// //                       style: TextStyle(fontSize: 14, color: Colors.black),
// //                       children: [
// //                         TextSpan(text: '4.0 ', style: TextStyle(fontWeight: FontWeight.bold)),
// //                         TextSpan(text: 'rating', style: TextStyle(color: Color(0xFF8F959E), fontSize: 12)),
// //                       ],
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Row(
// //                     children: List.generate(5, (index) {
// //                       return Icon(
// //                         index < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
// //                         size: 16,
// //                         color: index < 4 ? const Color(0xFFFFD700) : const Color(0xFFD1D1D6),
// //                       );
// //                     }),
// //                   ),
// //                 ],
// //               ),
// //             ],
// //           ),
// //           const SizedBox(height: 12),
// //           const Text(
// //             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
// //             'Pellentesque malesuada eget vitae amet...',
// //             style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.4),
// //           ),
// //         ],
// //       ),
// //     );
// //   }

// //   // =====================================================
// //   // السعر الإجمالي + Add to Cart — دلوقتي ثابت تحت في bottomNavigationBar
// //   // =====================================================
// //   Widget _buildBottomBar() {
// //     return SafeArea(
// //       top: false,
// //       child: Container(
// //         padding: const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
// //         decoration: BoxDecoration(
// //           color: AppColors.background,
// //           boxShadow: [
// //             BoxShadow(
// //               color: Colors.black.withOpacity(0.06),
// //               blurRadius: 16,
// //               offset: const Offset(0, -4),
// //             ),
// //           ],
// //         ),
// //         child: Row(
// //           children: [
// //             const Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text('Total Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
// //                   Text('with VAT, SD 2%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF8F959E))),
// //                   Text('EGP 612', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
// //                 ],
// //               ),
// //             ),
// //             Expanded(
// //               child: SizedBox(
// //                 height: 60,
// //                 child: ElevatedButton(
// //                   onPressed: _onAddToCartPressed,
// //                   style: ElevatedButton.styleFrom(
// //                     backgroundColor: const Color(0xFFF5F6F8),
// //                     foregroundColor: AppColors.tealGray,
// //                     elevation: 6,
// //                     shadowColor: Colors.black.withOpacity(0.3),
// //                     shape: const StadiumBorder(),
// //                   ),
// //                   child: const Text(
// //                     'Add to Cart',
// //                     style: TextStyle(
// //                       color: AppColors.tealGray,
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       letterSpacing: 0.5,
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // /// حدود مقاس واحد (طول ووزن) — يسهّل مطابقة وحفظ المقاسات في مكان واحد
// // /// بدل تكرار أرقام مبعثرة في أكتر من دالة.
// // class _SizeRange {
// //   final double minH;
// //   final double maxH;
// //   final double minW;
// //   final double maxW;

// //   const _SizeRange({
// //     required this.minH,
// //     required this.maxH,
// //     required this.minW,
// //     required this.maxW,
// //   });

// //   bool matchesBoth(double height, double weight) {
// //     return matchesHeight(height) && matchesWeight(weight);
// //   }

// //   bool matchesHeight(double height) => height >= minH && height <= maxH;

// //   bool matchesWeight(double weight) => weight >= minW && weight <= maxW;
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/colors.dart';

// class ProductDetails extends StatefulWidget {
//   const ProductDetails({super.key});

//   @override
//   State<ProductDetails> createState() => _ProductDetailsState();
// }

// class _ProductDetailsState extends State<ProductDetails> {
//   // -1 يعني مفيش مقاس متحدد لسه
//   int _selectedSizeIndex = -1;
//   int _selectedColorIndex = 0;
//   int _currentImageIndex = 1;
//   bool _isFavorite = false;
//   bool _isDescriptionExpanded = false;

//   // true وقت ما إحنا بنملى التيكست فيلدز برمجياً (بعد الضغط على زرار مقاس)
//   // عشان الـ onChanged مايعملش حسبة تانية على نفس القيمة ويلخبط الحالة.
//   bool _isProgrammaticUpdate = false;

//   // true لما المستخدم يدوس Add to Cart من غير ما يختار مقاس -> نظهر رسالة
//   // تحذير حمرا تحت الأحجام. بترجع false تاني أول ما يختار مقاس.
//   bool _showSizeError = false;

//   final TextEditingController _heightController = TextEditingController();
//   final TextEditingController _weightController = TextEditingController();

//   final List<String> productSizes = ['S', 'M', 'L', 'XL', '2XL'];
//   final List<Color> productColors = [
//     const Color(0xFF98E4CE), // مينت جرين
//     const Color(0xFF2C629E), // أزرق
//     const Color(0xFF8B1A1A), // نبيتي
//   ];
//   final List<String> images = [
//     'images/human.png',
//     'images/human.png',
//     'images/human.png',
//   ];

//   static const String _description =
//       'The Nike Throwback Pullover Hoodie is made from premium French '
//       'terry fabric that blends a performance feel with everyday comfort. '
//       'A relaxed fit and soft brushed interior keep you warm without '
//       'weighing you down, while the ribbed cuffs and hem lock in heat '
//       'on cool days.';

//   // كل مقاس وحدوده (طول/وزن) في مكان واحد — أسهل في الصيانة من
//   // تكرار الأرقام في أكتر من دالة.
//   static const List<_SizeRange> _sizeRanges = [
//     _SizeRange(minH: 150, maxH: 164, minW: 50, maxW: 64),
//     _SizeRange(minH: 165, maxH: 173, minW: 65, maxW: 73),
//     _SizeRange(minH: 174, maxH: 180, minW: 74, maxW: 85),
//     _SizeRange(minH: 181, maxH: 190, minW: 86, maxW: 95),
//     _SizeRange(minH: 191, maxH: 200, minW: 96, maxW: 110),
//   ];

//   // -----------------------------------------------------------------
//   // 1) المستخدم بيكتب طول ووزن بإيده -> نحدد المقاس المناسب أوتوماتيك
//   // -----------------------------------------------------------------
//   void _calculateSizeFromInput() {
//     if (_isProgrammaticUpdate) return;

//     final String heightText = _heightController.text.trim();
//     final String weightText = _weightController.text.trim();

//     if (heightText.isEmpty && weightText.isEmpty) {
//       if (_selectedSizeIndex != -1) {
//         setState(() => _selectedSizeIndex = -1);
//       }
//       return;
//     }

//     final double? height = double.tryParse(heightText);
//     final double? weight = double.tryParse(weightText);

//     // لسه المستخدم بيكتب / أو القيمة رينج جاية من زرار مقاس -> متعملش حاجة
//     if (height == null && weight == null) return;

//     final int newSizeIndex = _resolveSizeIndex(height, weight);

//     if (newSizeIndex != _selectedSizeIndex) {
//       setState(() {
//         _selectedSizeIndex = newSizeIndex;
//         if (newSizeIndex != -1) _showSizeError = false;
//       });
//     }
//   }

//   /// بيدور على أفضل مقاس مطابق:
//   /// 1) مطابقة كاملة: الطول والوزن الاتنين جوه نفس المقاس.
//   /// 2) لو مفيش مطابقة كاملة، مطابقة جزئية بالوزن بس (لو موجود).
//   /// 3) لو برضو مفيش، مطابقة جزئية بالطول بس (لو موجود).
//   /// كده لو كتبت طول برا النطاق لكن الوزن صح، أو العكس، برضو
//   /// هيتحدد مقاس بدل ما يفضل من غير أي اختيار.
//   int _resolveSizeIndex(double? height, double? weight) {
//     if (height != null && weight != null) {
//       for (int i = 0; i < _sizeRanges.length; i++) {
//         if (_sizeRanges[i].matchesBoth(height, weight)) return i;
//       }
//     }

//     if (weight != null) {
//       for (int i = 0; i < _sizeRanges.length; i++) {
//         if (_sizeRanges[i].matchesWeight(weight)) return i;
//       }
//     }

//     if (height != null) {
//       for (int i = 0; i < _sizeRanges.length; i++) {
//         if (_sizeRanges[i].matchesHeight(height)) return i;
//       }
//     }

//     return -1;
//   }

//   // -----------------------------------------------------------------
//   // 2) المستخدم بيضغط على زرار مقاس -> نملى الرينج المناسب في الفيلدز
//   // -----------------------------------------------------------------
//   void _setRangeFromSize(int sizeIndex) {
//     final _SizeRange range = _sizeRanges[sizeIndex];
//     _isProgrammaticUpdate = true;
//     setState(() {
//       _selectedSizeIndex = sizeIndex;
//       _heightController.text = '${range.minH} ~ ${range.maxH}';
//       _weightController.text = '${range.minW} ~ ${range.maxW}';
//       _showSizeError = false;
//     });
//     // نفك القفل بعد ما الفريم يخلص، عشان أي تعديل يدوي بعد كده
//     // يترصد بشكل طبيعي تاني.
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _isProgrammaticUpdate = false;
//     });
//   }

//   // -----------------------------------------------------------------
//   // 3) دوسة Add to Cart -> لازم يكون فيه مقاس متحدد
//   // -----------------------------------------------------------------
//   void _onAddToCartPressed() {
//     if (_selectedSizeIndex == -1) {
//       setState(() => _showSizeError = true);
//       return;
//     }

//     setState(() => _showSizeError = false);
//     // TODO: أكشن إضافة المنتج للعربة الفعلي
//   }

//   @override
//   void dispose() {
//     _heightController.dispose();
//     _weightController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         leading: const Icon(Icons.arrow_back_ios),
//         title: const Text(
//           'Product Details',
//           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       // الشريط بتاع السعر و Add to Cart بقى ثابت تحت الشاشة دايماً
//       // ومبيتحركش مع السكرول.
//       bottomNavigationBar: _buildBottomBar(),
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(color: AppColors.background),
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(bottom: 16),
//           child: Column(
//             children: [
//               const SizedBox(height: 24),
//               _buildImageCarousel(),
//               const SizedBox(height: 12),
//               _buildImageIndicator(),
//               const SizedBox(height: 33),
//               _buildProductHeader(),
//               const SizedBox(height: 24),
//               _buildTryOnMe(),
//               const SizedBox(height: 24),
//               _buildColorSelector(),
//               const SizedBox(height: 24),
//               _buildSizeSelector(),
//               const SizedBox(height: 24),
//               _buildMeasurementRow(),
//               const SizedBox(height: 32),
//               _buildDescription(),
//               const SizedBox(height: 24),
//               _buildReviews(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // =====================================================
//   // صور الكاروسيل
//   // =====================================================
//   Widget _buildImageCarousel() {
//     return SizedBox(
//       height: 340,
//       child: PageView.builder(
//         controller: PageController(initialPage: 1, viewportFraction: 0.55),
//         itemCount: images.length,
//         onPageChanged: (index) {
//           setState(() => _currentImageIndex = index);
//         },
//         itemBuilder: (context, index) {
//           final bool isActive = _currentImageIndex == index;
//           final double scale = isActive ? 1.0 : 0.85;
//           // ظل "طيران" أقوى وأوضح على الصورة النشطة، وأخف على الصور
//           // الجانبية عشان الإحساس بالعمق يبقى طبيعي مع تغيير الحجم.
//           return Transform.scale(
//             scale: scale,
//             child: Container(
//               margin: const EdgeInsets.symmetric(horizontal: 4),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(
//                   color: Colors.grey.withOpacity(0.3),
//                   width: 1,
//                 ),
//                 image: DecorationImage(
//                   image: AssetImage(images[index]),
//                   fit: BoxFit.cover,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(isActive ? 0.22 : 0.12),
//                     blurRadius: isActive ? 28 : 16,
//                     spreadRadius: isActive ? 1 : 0,
//                     offset: Offset(0, isActive ? 18 : 10),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildImageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(images.length, (index) {
//         final bool isActive = _currentImageIndex == index;
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 300),
//           margin: const EdgeInsets.symmetric(horizontal: 3),
//           height: 6,
//           width: isActive ? 18 : 6,
//           decoration: BoxDecoration(
//             color: isActive ? AppColors.tealGray : const Color(0xFFCCCCCC),
//             borderRadius: BorderRadius.circular(3),
//           ),
//         );
//       }),
//     );
//   }

//   // =====================================================
//   // اسم المنتج + السعر + اللايك + التقييم
//   // =====================================================
//   Widget _buildProductHeader() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           const Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Best Seller',
//                 style: TextStyle(
//                   fontSize: 13,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF8F959E),
//                 ),
//               ),
//               Text(
//                 'Nike Club Fleece',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
//               ),
//               Text(
//                 'L.E 600',
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Column(
//             children: [
//               const SizedBox(height: 4),
//               _buildFavoriteButton(),
//               const SizedBox(height: 16),
//               const Row(
//                 children: [
//                   Icon(Icons.star, color: Colors.amber),
//                   SizedBox(width: 8),
//                   Text('5.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFavoriteButton() {
//     return GestureDetector(
//       onTap: () => setState(() => _isFavorite = !_isFavorite),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         padding: const EdgeInsets.all(12),
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [
//               const Color.fromARGB(103, 249, 248, 248).withOpacity(0.9),
//               const Color.fromARGB(69, 201, 199, 199).withOpacity(0.6),
//             ],
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.08),
//               blurRadius: 15,
//               spreadRadius: 2,
//               offset: const Offset(0, 5),
//             ),
//           ],
//           border: Border.all(
//             color: const Color.fromARGB(255, 192, 191, 191).withOpacity(0.6),
//             width: 1.5,
//           ),
//         ),
//         child: AnimatedSwitcher(
//           duration: const Duration(milliseconds: 200),
//           transitionBuilder: (child, animation) =>
//               ScaleTransition(scale: animation, child: child),
//           child: Icon(
//             _isFavorite ? Icons.favorite : Icons.favorite_border,
//             key: ValueKey<bool>(_isFavorite),
//             color: _isFavorite ? Colors.red : Colors.black,
//             size: 24,
//           ),
//         ),
//       ),
//     );
//   }

//   // =====================================================
//   // Try on Me
//   // =====================================================
//   Widget _buildTryOnMe() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Row(
//             children: [
//               Text('Try on Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//               Spacer(),
//               Text(
//                 'Virtual Simulation',
//                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Row(
//             children: [
//               Icon(Icons.info_outline, color: AppColors.gray, size: 14),
//               const SizedBox(width: 4),
//               Text(
//                 'Confidence fit: 95%',
//                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.gray),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Center(child: Image.asset('images/avatar.png', height: 343)),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // الألوان
//   // =====================================================
//   Widget _buildColorSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//               Spacer(),
//               Text(
//                 'Colors Available',
//                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: Row(
//             children: List.generate(productColors.length, (index) {
//               final bool isSelected = _selectedColorIndex == index;
//               return GestureDetector(
//                 onTap: () => setState(() => _selectedColorIndex = index),
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 12),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: isSelected ? AppColors.tealGray : Colors.transparent,
//                       width: 2,
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         // ظل بلون الدائرة نفسها بدل ظل رمادي عادي، عشان
//                         // يبان كل لون طاير بتوهجه الخاص بدل ظل موحد.
//                         color: productColors[index].withOpacity(0.45),
//                         blurRadius: isSelected ? 14 : 8,
//                         spreadRadius: isSelected ? 1 : 0,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: CircleAvatar(
//                     radius: 18,
//                     backgroundColor: productColors[index],
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ],
//     );
//   }

//   // =====================================================
//   // المقاسات
//   // =====================================================
//   Widget _buildSizeSelector() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             children: [
//               Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//               Spacer(),
//               Text(
//                 'Size Guide',
//                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: List.generate(productSizes.length, (index) {
//               final bool isSelected = _selectedSizeIndex == index;
//               return GestureDetector(
//                 onTap: () => _setRangeFromSize(index),
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   width: 55,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: isSelected ? AppColors.tealGray : Colors.white,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: isSelected
//                           ? Colors.transparent
//                           : (_showSizeError
//                               ? Colors.red.withOpacity(0.6)
//                               : Colors.grey.withOpacity(0.2)),
//                       width: (!isSelected && _showSizeError) ? 1.4 : 1,
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     productSizes[index],
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : Colors.black,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//         // رسالة التحذير بتظهر بس لما يدوس Add to Cart من غير ما
//         // يكون مختار مقاس، وبتختفي أول ما يختار.
//         AnimatedSize(
//           duration: const Duration(milliseconds: 200),
//           child: _showSizeError
//               ? Padding(
//                   padding: const EdgeInsets.only(left: 16, top: 8),
//                   child: Row(
//                     children: [
//                       const Icon(Icons.error_outline, size: 15, color: Colors.red),
//                       const SizedBox(width: 6),
//                       Text(
//                         'Please Choose Size',
//                         style: TextStyle(
//                           fontSize: 12.5,
//                           color: Colors.red.shade600,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : const SizedBox(width: double.infinity),
//         ),
//       ],
//     );
//   }

//   // =====================================================
//   // حقول الطول والوزن
//   // =====================================================
//   Widget _buildMeasurementRow() {
//     final bool isResolved = _selectedSizeIndex != -1;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         children: [
//           Expanded(
//             child: _buildMeasurementField(
//               label: 'Height (cm)',
//               hint: 'Enter your Height',
//               controller: _heightController,
//               isResolved: isResolved,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: SvgPicture.asset('icons/fa6-solid_person.svg'),
//           ),
//           Expanded(
//             child: _buildMeasurementField(
//               label: 'Weight (kg)',
//               hint: 'Enter your weight',
//               controller: _weightController,
//               isResolved: isResolved,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMeasurementField({
//     required String label,
//     required String hint,
//     required TextEditingController controller,
//     required bool isResolved,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//         const SizedBox(height: 6),
//         TextField(
//           controller: controller,
//           keyboardType: TextInputType.number,
//           onChanged: (value) => _calculateSizeFromInput(),
//           textAlign: TextAlign.center,
//           cursorColor: const Color.fromARGB(255, 243, 246, 246),
//           cursorWidth: 1.5,
//           style: TextStyle(
//             color: isResolved ? Colors.white : Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//           decoration: InputDecoration(
//             hintText: hint,
//             hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
//             fillColor: isResolved
//                 ? AppColors.tealGray
//                 : AppColors.fieldFocus,
//             filled: true,
//             contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             enabledBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: BorderSide(
//                 color: isResolved ? AppColors.tealGray : Colors.grey.withOpacity(0.3),
//                 width: isResolved ? 1.5 : 1,
//               ),
//             ),
//             focusedBorder: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide: const BorderSide(color: AppColors.tealGray, width: 2),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   // =====================================================
//   // الوصف — Read More / Read Less شغالة فعلياً
//   // =====================================================
//   Widget _buildDescription() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Description',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//           const SizedBox(height: 8),
//           AnimatedCrossFade(
//             duration: const Duration(milliseconds: 250),
//             crossFadeState: _isDescriptionExpanded
//                 ? CrossFadeState.showSecond
//                 : CrossFadeState.showFirst,
//             firstChild: const Text(
//               _description,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
//             ),
//             secondChild: const Text(
//               _description,
//               style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
//             ),
//           ),
//           const SizedBox(height: 4),
//           GestureDetector(
//             onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
//             child: Text(
//               _isDescriptionExpanded ? 'Read Less' : 'Read More...',
//               style: const TextStyle(color: AppColors.tealGray, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // المراجعات
//   // =====================================================
//   Widget _buildReviews() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text(
//                 'Reviews',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 style: TextButton.styleFrom(
//                   padding: EdgeInsets.zero,
//                   minimumSize: Size.zero,
//                   tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//                 child: const Text(
//                   'View All',
//                   style: TextStyle(fontSize: 14, color: AppColors.tealGray, fontWeight: FontWeight.w500),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           _buildReviewCard(),
//         ],
//       ),
//     );
//   }

//   Widget _buildReviewCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFEFEFEF), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const CircleAvatar(
//                 radius: 22,
//                 backgroundColor: Colors.white,
//                 backgroundImage: AssetImage('images/human.png'),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'Ronald Richards',
//                       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time, size: 14, color: const Color(0xFF8F959E).withOpacity(0.7)),
//                         const SizedBox(width: 4),
//                         const Text(
//                           '13 Sep, 2020',
//                           style: TextStyle(fontSize: 11, color: Color(0xFF8F959E)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   RichText(
//                     text: const TextSpan(
//                       style: TextStyle(fontSize: 14, color: Colors.black),
//                       children: [
//                         TextSpan(text: '4.0 ', style: TextStyle(fontWeight: FontWeight.bold)),
//                         TextSpan(text: 'rating', style: TextStyle(color: Color(0xFF8F959E), fontSize: 12)),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Row(
//                     children: List.generate(5, (index) {
//                       return Icon(
//                         index < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
//                         size: 16,
//                         color: index < 4 ? const Color(0xFFFFD700) : const Color(0xFFD1D1D6),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
//             'Pellentesque malesuada eget vitae amet...',
//             style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.4),
//           ),
//         ],
//       ),
//     );
//   }

//   // =====================================================
//   // السعر الإجمالي + Add to Cart — دلوقتي ثابت تحت في bottomNavigationBar
//   // =====================================================
//   Widget _buildBottomBar() {
//     return SafeArea(
//       top: false,
//       // ارتفاع ثابت صريح للشريط كله (Row + الـ padding) عشان ميتمددش
//       // ياخد المساحة المتاحة كلها لو اتحط جوه أي Layout بيديله ارتفاع
//       // غير محدود.
//       child: Container(
//         height: 92,
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//         decoration: BoxDecoration(
//           color: AppColors.background,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.06),
//               blurRadius: 16,
//               offset: const Offset(0, -4),
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.max,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const Expanded(
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Total Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
//                   Text('with VAT, SD 2%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF8F959E))),
//                   Text('EGP 612', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: 56,
//                 child: ElevatedButton(
//                   onPressed: _onAddToCartPressed,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFF5F6F8),
//                     foregroundColor: AppColors.tealGray,
//                     elevation: 6,
//                     shadowColor: Colors.black.withOpacity(0.3),
//                     shape: const StadiumBorder(),
//                   ),
//                   child: const Text(
//                     'Add to Cart',
//                     style: TextStyle(
//                       color: AppColors.tealGray,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 0.5,
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
// }

// /// حدود مقاس واحد (طول ووزن) — يسهّل مطابقة وحفظ المقاسات في مكان واحد
// /// بدل تكرار أرقام مبعثرة في أكتر من دالة.
// class _SizeRange {
//   final double minH;
//   final double maxH;
//   final double minW;
//   final double maxW;

//   const _SizeRange({
//     required this.minH,
//     required this.maxH,
//     required this.minW,
//     required this.maxW,
//   });

//   bool matchesBoth(double height, double weight) {
//     return matchesHeight(height) && matchesWeight(weight);
//   }

//   bool matchesHeight(double height) => height >= minH && height <= maxH;

//   bool matchesWeight(double weight) => weight >= minW && weight <= maxW;
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // -1 يعني مفيش مقاس متحدد لسه
  int _selectedSizeIndex = -1;
  int _selectedColorIndex = 0;
  int _currentImageIndex = 1;
  bool _isFavorite = false;
  bool _isDescriptionExpanded = false;

  // true وقت ما إحنا بنملى التيكست فيلدز برمجياً (بعد الضغط على زرار مقاس)
  // عشان الـ onChanged مايعملش حسبة تانية على نفس القيمة ويلخبط الحالة.
  bool _isProgrammaticUpdate = false;

  // true لما المستخدم يدوس Add to Cart من غير ما يختار مقاس -> نظهر رسالة
  // تحذير حمرا تحت الأحجام. بترجع false تاني أول ما يختار مقاس.
  bool _showSizeError = false;

  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final List<String> productSizes = ['S', 'M', 'L', 'XL', '2XL'];
  final List<Color> productColors = [
    const Color(0xFF98E4CE), // مينت جرين
    const Color(0xFF2C629E), // أزرق
    const Color(0xFF8B1A1A), // نبيتي
  ];
  final List<String> images = [
    'images/human.png',
    'images/human.png',
    'images/human.png',
  ];

  static const String _description =
      'The Nike Throwback Pullover Hoodie is made from premium French '
      'terry fabric that blends a performance feel with everyday comfort. '
      'A relaxed fit and soft brushed interior keep you warm without '
      'weighing you down, while the ribbed cuffs and hem lock in heat '
      'on cool days.';

  // كل مقاس وحدوده (طول/وزن) في مكان واحد — أسهل في الصيانة من
  // تكرار الأرقام في أكتر من دالة.
  static const List<_SizeRange> _sizeRanges = [
    _SizeRange(minH: 150, maxH: 164, minW: 50, maxW: 64),
    _SizeRange(minH: 165, maxH: 173, minW: 65, maxW: 73),
    _SizeRange(minH: 174, maxH: 180, minW: 74, maxW: 85),
    _SizeRange(minH: 181, maxH: 190, minW: 86, maxW: 95),
    _SizeRange(minH: 191, maxH: 200, minW: 96, maxW: 110),
  ];

  // -----------------------------------------------------------------
  // 1) المستخدم بيكتب طول ووزن بإيده -> نحدد المقاس المناسب أوتوماتيك
  // -----------------------------------------------------------------
  void _calculateSizeFromInput() {
    if (_isProgrammaticUpdate) return;

    final String heightText = _heightController.text.trim();
    final String weightText = _weightController.text.trim();

    if (heightText.isEmpty && weightText.isEmpty) {
      if (_selectedSizeIndex != -1) {
        setState(() => _selectedSizeIndex = -1);
      }
      return;
    }

    final double? height = double.tryParse(heightText);
    final double? weight = double.tryParse(weightText);

    // لسه المستخدم بيكتب / أو القيمة رينج جاية من زرار مقاس -> متعملش حاجة
    if (height == null && weight == null) return;

    final int newSizeIndex = _resolveSizeIndex(height, weight);

    if (newSizeIndex != _selectedSizeIndex) {
      setState(() {
        _selectedSizeIndex = newSizeIndex;
        if (newSizeIndex != -1) _showSizeError = false;
      });
    }
  }

  /// بيدور على أفضل مقاس مطابق:
  /// 1) مطابقة كاملة: الطول والوزن الاتنين جوه نفس المقاس.
  /// 2) لو مفيش مطابقة كاملة، مطابقة جزئية بالوزن بس (لو موجود).
  /// 3) لو برضو مفيش، مطابقة جزئية بالطول بس (لو موجود).
  /// كده لو كتبت طول برا النطاق لكن الوزن صح، أو العكس، برضو
  /// هيتحدد مقاس بدل ما يفضل من غير أي اختيار.
  int _resolveSizeIndex(double? height, double? weight) {
    if (height != null && weight != null) {
      for (int i = 0; i < _sizeRanges.length; i++) {
        if (_sizeRanges[i].matchesBoth(height, weight)) return i;
      }
    }

    if (weight != null) {
      for (int i = 0; i < _sizeRanges.length; i++) {
        if (_sizeRanges[i].matchesWeight(weight)) return i;
      }
    }

    if (height != null) {
      for (int i = 0; i < _sizeRanges.length; i++) {
        if (_sizeRanges[i].matchesHeight(height)) return i;
      }
    }

    return -1;
  }

  // -----------------------------------------------------------------
  // 2) المستخدم بيضغط على زرار مقاس -> نملى الرينج المناسب في الفيلدز
  // -----------------------------------------------------------------
  void _setRangeFromSize(int sizeIndex) {
    final _SizeRange range = _sizeRanges[sizeIndex];
    _isProgrammaticUpdate = true;
    setState(() {
      _selectedSizeIndex = sizeIndex;
      _heightController.text = '${range.minH} ~ ${range.maxH}';
      _weightController.text = '${range.minW} ~ ${range.maxW}';
      _showSizeError = false;
    });
    // نفك القفل بعد ما الفريم يخلص، عشان أي تعديل يدوي بعد كده
    // يترصد بشكل طبيعي تاني.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _isProgrammaticUpdate = false;
    });
  }

  // -----------------------------------------------------------------
  // 3) دوسة Add to Cart -> لازم يكون فيه مقاس متحدد
  // -----------------------------------------------------------------
  void _onAddToCartPressed() {
    if (_selectedSizeIndex == -1) {
      setState(() => _showSizeError = true);
      return;
    }

    setState(() => _showSizeError = false);
    // TODO: أكشن إضافة المنتج للعربة الفعلي
  }

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: const Icon(Icons.arrow_back_ios),
        title: const Text(
          'Product Details',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // الشريط بتاع السعر و Add to Cart بقى ثابت تحت الشاشة دايماً
      // ومبيتحركش مع السكرول.
      bottomNavigationBar: _buildBottomBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(color: AppColors.background),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              _buildImageCarousel(),
              const SizedBox(height: 12),
              _buildImageIndicator(),
              const SizedBox(height: 33),
              _buildProductHeader(),
              const SizedBox(height: 24),
              _buildTryOnMe(),
              const SizedBox(height: 24),
              _buildColorSelector(),
              const SizedBox(height: 24),
              _buildSizeSelector(),
              const SizedBox(height: 24),
              _buildMeasurementRow(),
              const SizedBox(height: 32),
              _buildDescription(),
              const SizedBox(height: 24),
              _buildReviews(),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // صور الكاروسيل
  // =====================================================
  Widget _buildImageCarousel() {
    return SizedBox(
      height: 340,
      child: PageView.builder(
        controller: PageController(initialPage: 1, viewportFraction: 0.55),
        itemCount: images.length,
        onPageChanged: (index) {
          setState(() => _currentImageIndex = index);
        },
        itemBuilder: (context, index) {
          final bool isActive = _currentImageIndex == index;
          final double scale = isActive ? 1.0 : 0.85;
          // ظل "طيران" أقوى وأوضح على الصورة النشطة، وأخف على الصور
          // الجانبية عشان الإحساس بالعمق يبقى طبيعي مع تغيير الحجم.
          return Transform.scale(
            scale: scale,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3),
                  width: 1,
                ),
                image: DecorationImage(
                  image: AssetImage(images[index]),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isActive ? 0.22 : 0.12),
                    blurRadius: isActive ? 28 : 16,
                    spreadRadius: isActive ? 1 : 0,
                    offset: Offset(0, isActive ? 18 : 10),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        final bool isActive = _currentImageIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          height: 6,
          width: isActive ? 18 : 6,
          decoration: BoxDecoration(
            color: isActive ? AppColors.tealGray : const Color(0xFFCCCCCC),
            borderRadius: BorderRadius.circular(3),
          ),
        );
      }),
    );
  }

  // =====================================================
  // اسم المنتج + السعر + اللايك + التقييم
  // =====================================================
  Widget _buildProductHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Best Seller',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF8F959E),
                ),
              ),
              Text(
                'Nike Club Fleece',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
              Text(
                'L.E 600',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              const SizedBox(height: 4),
              _buildFavoriteButton(),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('5.0', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteButton() {
    return GestureDetector(
      onTap: () => setState(() => _isFavorite = !_isFavorite),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(103, 249, 248, 248).withOpacity(0.9),
              const Color.fromARGB(69, 201, 199, 199).withOpacity(0.6),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 15,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: const Color.fromARGB(255, 192, 191, 191).withOpacity(0.6),
            width: 1.5,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (child, animation) =>
              ScaleTransition(scale: animation, child: child),
          child: Icon(
            _isFavorite ? Icons.favorite : Icons.favorite_border,
            key: ValueKey<bool>(_isFavorite),
            color: _isFavorite ? Colors.red : Colors.black,
            size: 24,
          ),
        ),
      ),
    );
  }

  // =====================================================
  // Try on Me
  // =====================================================
  Widget _buildTryOnMe() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('Try on Me', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Spacer(),
              Text(
                'Virtual Simulation',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(Icons.info_outline, color: AppColors.gray, size: 14),
              const SizedBox(width: 4),
              Text(
                'Confidence fit: 95%',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.gray),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Center(child: Image.asset('images/avatar.png', height: 343)),
        ],
      ),
    );
  }

  // =====================================================
  // الألوان
  // =====================================================
  Widget _buildColorSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Spacer(),
              Text(
                'Colors Available',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            children: List.generate(productColors.length, (index) {
              final bool isSelected = _selectedColorIndex == index;
              return GestureDetector(
                onTap: () => setState(() => _selectedColorIndex = index),
                child: Container(
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.tealGray : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        // ظل بلون الدائرة نفسها بدل ظل رمادي عادي، عشان
                        // يبان كل لون طاير بتوهجه الخاص بدل ظل موحد.
                        color: productColors[index].withOpacity(0.45),
                        blurRadius: isSelected ? 14 : 8,
                        spreadRadius: isSelected ? 1 : 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: productColors[index],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // المقاسات
  // =====================================================
  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              Spacer(),
              Text(
                'Size Guide',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF8F959E)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(productSizes.length, (index) {
              final bool isSelected = _selectedSizeIndex == index;
              return GestureDetector(
                onTap: () => _setRangeFromSize(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 55,
                  height: 50,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.tealGray : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : (_showSizeError
                              ? Colors.red.withOpacity(0.6)
                              : Colors.grey.withOpacity(0.2)),
                      width: (!isSelected && _showSizeError) ? 1.4 : 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    productSizes[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
        // رسالة التحذير بتظهر بس لما يدوس Add to Cart من غير ما
        // يكون مختار مقاس، وبتختفي أول ما يختار.
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: _showSizeError
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline, size: 15, color: Colors.red),
                      const SizedBox(width: 6),
                      Text(
                        'Please Choose Size',
                        style: TextStyle(
                          fontSize: 12.5,
                          color: Colors.red.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  // =====================================================
  // حقول الطول والوزن
  // =====================================================
  Widget _buildMeasurementRow() {
    final bool isResolved = _selectedSizeIndex != -1;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _buildMeasurementField(
              label: 'Height (cm)',
              hint: 'Enter your Height',
              controller: _heightController,
              isResolved: isResolved,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SvgPicture.asset('icons/fa6-solid_person.svg'),
          ),
          Expanded(
            child: _buildMeasurementField(
              label: 'Weight (kg)',
              hint: 'Enter your weight',
              controller: _weightController,
              isResolved: isResolved,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required bool isResolved,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: (value) => _calculateSizeFromInput(),
          textAlign: TextAlign.center,
          cursorColor: const Color.fromARGB(255, 243, 246, 246),
          cursorWidth: 1.5,
          style: TextStyle(
            color: isResolved ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
            fillColor: isResolved
                ? AppColors.tealGray
                : AppColors.fieldFocus,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: isResolved ? AppColors.tealGray : Colors.grey.withOpacity(0.3),
                width: isResolved ? 1.5 : 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.tealGray, width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // الوصف — Read More / Read Less شغالة فعلياً
  // =====================================================
  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isDescriptionExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const Text(
              _description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
            ),
            secondChild: const Text(
              _description,
              style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.5),
            ),
          ),
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () => setState(() => _isDescriptionExpanded = !_isDescriptionExpanded),
            child: Text(
              _isDescriptionExpanded ? 'Read Less' : 'Read More...',
              style: const TextStyle(color: AppColors.tealGray, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // المراجعات
  // =====================================================
  Widget _buildReviews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reviews',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'View All',
                  style: TextStyle(fontSize: 14, color: AppColors.tealGray, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildReviewCard(),
        ],
      ),
    );
  }

  Widget _buildReviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFEFEF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('images/human.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ronald Richards',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 14, color: const Color(0xFF8F959E).withOpacity(0.7)),
                        const SizedBox(width: 4),
                        const Text(
                          '13 Sep, 2020',
                          style: TextStyle(fontSize: 11, color: Color(0xFF8F959E)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(text: '4.0 ', style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: 'rating', style: TextStyle(color: Color(0xFF8F959E), fontSize: 12)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                      return Icon(
                        index < 4 ? Icons.star_rounded : Icons.star_outline_rounded,
                        size: 16,
                        color: index < 4 ? const Color(0xFFFFD700) : const Color(0xFFD1D1D6),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Pellentesque malesuada eget vitae amet...',
            style: TextStyle(fontSize: 14, color: Color(0xFF8F959E), height: 1.4),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // السعر الإجمالي + Add to Cart — دلوقتي ثابت تحت في bottomNavigationBar
  // =====================================================
  Widget _buildBottomBar() {
    return SafeArea(
      top: false,
      // ارتفاع ثابت صريح للشريط كله (Row + الـ padding) عشان ميتمددش
      // ياخد المساحة المتاحة كلها لو اتحط جوه أي Layout بيديله ارتفاع
      // غير محدود.
      child: Container(
        height: 104,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Price', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text('with VAT, SD 2%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFF8F959E))),
                  Text('EGP 612', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _onAddToCartPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF5F6F8),
                    foregroundColor: AppColors.tealGray,
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(0.3),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: AppColors.tealGray,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
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

/// حدود مقاس واحد (طول ووزن) — يسهّل مطابقة وحفظ المقاسات في مكان واحد
/// بدل تكرار أرقام مبعثرة في أكتر من دالة.
class _SizeRange {
  final double minH;
  final double maxH;
  final double minW;
  final double maxW;

  const _SizeRange({
    required this.minH,
    required this.maxH,
    required this.minW,
    required this.maxW,
  });

  bool matchesBoth(double height, double weight) {
    return matchesHeight(height) && matchesWeight(weight);
  }

  bool matchesHeight(double height) => height >= minH && height <= maxH;

  bool matchesWeight(double weight) => weight >= minW && weight <= maxW;
}