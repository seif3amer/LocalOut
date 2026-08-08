// // // // // // // import 'dart:ui';
// // // // // // // import 'package:flutter/material.dart';
// // // // // // // import 'package:flutter_svg/flutter_svg.dart';
// // // // // // // import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// // // // // // // class _NavItemData {
// // // // // // //   final String icon;
// // // // // // //   final String label;

// // // // // // //   const _NavItemData({required this.icon, required this.label});
// // // // // // // }

// // // // // // // class CustomBottomNavBar extends StatelessWidget {
// // // // // // //   final int currentIndex;
// // // // // // //   final ValueChanged<int> onTap;
// // // // // // //   final int cartItemCount;

// // // // // // //   const CustomBottomNavBar({
// // // // // // //     Key? key,
// // // // // // //     required this.currentIndex,
// // // // // // //     required this.onTap,
// // // // // // //     this.cartItemCount = 0,
// // // // // // //   }) : super(key: key);

// // // // // // //   static const List<_NavItemData> _items = [
// // // // // // //     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
// // // // // // //     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
// // // // // // //     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
// // // // // // //     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
// // // // // // //     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
// // // // // // //   ];

// // // // // // //   @override
// // // // // // //   Widget build(BuildContext context) {
// // // // // // //     return SafeArea(
// // // // // // //       top: false,
// // // // // // //       child: LayoutBuilder(
// // // // // // //         builder: (context, constraints) {
// // // // // // //           final double fullWidth = constraints.maxWidth;
// // // // // // //           final double horizontalMargin = fullWidth * 0.05;
// // // // // // //           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
// // // // // // //           final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
// // // // // // //           final double bottomMargin = navBarHeight * 0.24;

// // // // // // //           final double iconSize = navBarHeight * 0.38;
// // // // // // //           final double fontSize = navBarHeight * 0.15;
// // // // // // //           final double labelSpacing = navBarHeight * 0.01;
// // // // // // //           final double pillHeight = navBarHeight * 1.007;

// // // // // // //           final double itemWidth = navBarWidth / _items.length;
// // // // // // //           final double pillWidth = itemWidth * 1.59;

// // // // // // //           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
// // // // // // //           final double pillLeft = segmentCenter - pillWidth / 2;
// // // // // // //           final double pillTop = navBarHeight - pillHeight;

// // // // // // //           return Padding(
// // // // // // //             padding: EdgeInsets.only(
// // // // // // //               left: horizontalMargin,
// // // // // // //               right: horizontalMargin,
// // // // // // //               bottom: bottomMargin,
// // // // // // //             ),
// // // // // // //             child: ClipRRect(
// // // // // // //               borderRadius: BorderRadius.circular(navBarHeight),
// // // // // // //               child: BackdropFilter(
// // // // // // //                 filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // // // // //                 child: Container(
// // // // // // //                   width: navBarWidth,
// // // // // // //                   height: navBarHeight,
// // // // // // //                   decoration: BoxDecoration(
// // // // // // //                     color: Colors.white.withOpacity(0.22),
// // // // // // //                     borderRadius: BorderRadius.circular(navBarHeight),
// // // // // // //                     border: Border.all(
// // // // // // //                       color: Colors.white.withOpacity(0.75),
// // // // // // //                       width: 1.0,
// // // // // // //                     ),
// // // // // // //                     boxShadow: [
// // // // // // //                       BoxShadow(
// // // // // // //                         color: Colors.black.withOpacity(0.1),
// // // // // // //                         blurRadius: 20,
// // // // // // //                         offset: const Offset(0, 6),
// // // // // // //                       ),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                   child: Stack(
// // // // // // //                     clipBehavior: Clip.none,
// // // // // // //                     children: [
// // // // // // //                       // خلفية العنصر المحدد المتحركة
// // // // // // //                       ClipRRect(
// // // // // // //                         borderRadius: BorderRadius.circular(navBarHeight),
// // // // // // //                         child: Stack(
// // // // // // //                           children: [
// // // // // // //                             AnimatedPositioned(
// // // // // // //                               duration: const Duration(milliseconds: 320),
// // // // // // //                               curve: Curves.easeInOutCubic,
// // // // // // //                               left: pillLeft,
// // // // // // //                               top: pillTop,
// // // // // // //                               child: AnimatedContainer(
// // // // // // //                                 duration: const Duration(milliseconds: 320),
// // // // // // //                                 curve: Curves.easeInOutCubic,
// // // // // // //                                 width: pillWidth,
// // // // // // //                                 height: pillHeight,
// // // // // // //                                 alignment: Alignment.bottomCenter,
// // // // // // //                                 child: SvgPicture.asset(
// // // // // // //                                   'icons/Subtract.svg',
// // // // // // //                                   width: pillWidth,
// // // // // // //                                   height: pillHeight,
// // // // // // //                                   fit: BoxFit.fill,
// // // // // // //                                   colorFilter: const ColorFilter.mode(
// // // // // // //                                     AppColors.tealGray,
// // // // // // //                                     BlendMode.srcIn,
// // // // // // //                                   ),
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                             ),
// // // // // // //                           ],
// // // // // // //                         ),
// // // // // // //                       ),

// // // // // // //                       // عناصر القائمة
// // // // // // //                       Row(
// // // // // // //                         children: List.generate(_items.length, (index) {
// // // // // // //                           final bool isSelected = index == currentIndex;
// // // // // // //                           final _NavItemData item = _items[index];

// // // // // // //                           return SizedBox(
// // // // // // //                             width: itemWidth,
// // // // // // //                             height: navBarHeight,
// // // // // // //                             child: GestureDetector(
// // // // // // //                               behavior: HitTestBehavior.opaque,
// // // // // // //                               onTap: () => onTap(index),
// // // // // // //                               child: Center(
// // // // // // //                                 child: Column(
// // // // // // //                                   mainAxisSize: MainAxisSize.min,
// // // // // // //                                   mainAxisAlignment: MainAxisAlignment.center,
// // // // // // //                                   children: [
// // // // // // //                                     _buildIcon(item, isSelected, iconSize),
// // // // // // //                                     AnimatedSize(
// // // // // // //                                       duration: const Duration(milliseconds: 320),
// // // // // // //                                       curve: Curves.easeInOutCubic,
// // // // // // //                                       child: isSelected
// // // // // // //                                           ? Padding(
// // // // // // //                                               padding: EdgeInsets.only(top: labelSpacing),
// // // // // // //                                               child: FittedBox(
// // // // // // //                                                 fit: BoxFit.scaleDown,
// // // // // // //                                                 child: Text(
// // // // // // //                                                   item.label,
// // // // // // //                                                   maxLines: 1,
// // // // // // //                                                   style: TextStyle(
// // // // // // //                                                     color: Colors.white,
// // // // // // //                                                     fontSize: fontSize,
// // // // // // //                                                     fontWeight: FontWeight.w600,
// // // // // // //                                                   ),
// // // // // // //                                                 ),
// // // // // // //                                               ),
// // // // // // //                                             )
// // // // // // //                                           : const SizedBox(width: 0, height: 0),
// // // // // // //                                     ),
// // // // // // //                                   ],
// // // // // // //                                 ),
// // // // // // //                               ),
// // // // // // //                             ),
// // // // // // //                           );
// // // // // // //                         }),
// // // // // // //                       ),
// // // // // // //                     ],
// // // // // // //                   ),
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           );
// // // // // // //         },
// // // // // // //       ),
// // // // // // //     );
// // // // // // //   }

// // // // // // //   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
// // // // // // //     final bool isBag = item.icon == 'icons/Bag.svg';

// // // // // // //     final Widget icon = SvgPicture.asset(
// // // // // // //       item.icon,
// // // // // // //       width: iconSize,
// // // // // // //       height: iconSize,
// // // // // // //       colorFilter: ColorFilter.mode(
// // // // // // //         isSelected ? Colors.white : Colors.black,
// // // // // // //         BlendMode.srcIn,
// // // // // // //       ),
// // // // // // //     );

// // // // // // //     if (!isBag) return icon;

// // // // // // //     return Stack(
// // // // // // //       clipBehavior: Clip.none,
// // // // // // //       children: [
// // // // // // //         icon,
// // // // // // //         if (cartItemCount > 0)
// // // // // // //           Positioned(
// // // // // // //             right: -2,
// // // // // // //             top: -2,
// // // // // // //             child: Container(
// // // // // // //               padding: const EdgeInsets.all(2),
// // // // // // //               constraints: BoxConstraints(
// // // // // // //                 minWidth: iconSize * 0.45,
// // // // // // //                 minHeight: iconSize * 0.45,
// // // // // // //               ),
// // // // // // //               alignment: Alignment.center,
// // // // // // //               decoration: const BoxDecoration(
// // // // // // //                 color: Colors.redAccent,
// // // // // // //                 shape: BoxShape.circle,
// // // // // // //               ),
// // // // // // //               child: Text(
// // // // // // //                 '$cartItemCount',
// // // // // // //                 style: TextStyle(
// // // // // // //                   color: Colors.white,
// // // // // // //                   fontSize: iconSize * 0.28,
// // // // // // //                   fontWeight: FontWeight.bold,
// // // // // // //                 ),
// // // // // // //               ),
// // // // // // //             ),
// // // // // // //           ),
// // // // // // //       ],
// // // // // // //     );
// // // // // // //   }
// // // // // // // }

// // // // // // import 'dart:ui';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:flutter_svg/flutter_svg.dart';
// // // // // // import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// // // // // // class _NavItemData {
// // // // // //   final String icon;
// // // // // //   final String label;

// // // // // //   const _NavItemData({required this.icon, required this.label});
// // // // // // }

// // // // // // class CustomBottomNavBar extends StatelessWidget {
// // // // // //   final int currentIndex;
// // // // // //   final ValueChanged<int> onTap;
// // // // // //   final int cartItemCount;

// // // // // //   const CustomBottomNavBar({
// // // // // //     Key? key,
// // // // // //     required this.currentIndex,
// // // // // //     required this.onTap,
// // // // // //     this.cartItemCount = 0,
// // // // // //   }) : super(key: key);

// // // // // //   static const List<_NavItemData> _items = [
// // // // // //     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
// // // // // //     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
// // // // // //     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
// // // // // //     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
// // // // // //     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
// // // // // //   ];

// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return SafeArea(
// // // // // //       top: false,
// // // // // //       child: LayoutBuilder(
// // // // // //         builder: (context, constraints) {
// // // // // //           final double fullWidth = constraints.maxWidth;
// // // // // //           final double horizontalMargin = fullWidth * 0.05;
// // // // // //           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
// // // // // //           final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
// // // // // //           final double bottomMargin = navBarHeight * 0.24;

// // // // // //           final double iconSize = navBarHeight * 0.38;
// // // // // //           final double fontSize = navBarHeight * 0.15;
// // // // // //           final double labelSpacing = navBarHeight * 0.01;
// // // // // //           final double pillHeight = navBarHeight * 1.007;

// // // // // //           final double itemWidth = navBarWidth / _items.length;
// // // // // //           final double pillWidth = itemWidth * 1.59;

// // // // // //           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
// // // // // //           final double pillLeft = segmentCenter - pillWidth / 2;
// // // // // //           final double pillTop = navBarHeight - pillHeight;

// // // // // //           return Padding(
// // // // // //             padding: EdgeInsets.only(
// // // // // //               left: horizontalMargin,
// // // // // //               right: horizontalMargin,
// // // // // //               bottom: bottomMargin,
// // // // // //             ),
// // // // // //             child: Container(
// // // // // //               decoration: BoxDecoration(
// // // // // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // // // // //                 boxShadow: [
// // // // // //                   BoxShadow(
// // // // // //                     color: Colors.black.withOpacity(0.12),
// // // // // //                     blurRadius: 16,
// // // // // //                     spreadRadius: 2,
// // // // // //                     offset: const Offset(0, 8),
// // // // // //                   ),
// // // // // //                 ],
// // // // // //               ),
// // // // // //               child: ClipRRect(
// // // // // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // // // // //                 child: BackdropFilter(
// // // // // //                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // // // //                   child: Container(
// // // // // //                     width: navBarWidth,
// // // // // //                     height: navBarHeight,
// // // // // //                     decoration: BoxDecoration(
// // // // // //                       color: Colors.white.withOpacity(0.22),
// // // // // //                       borderRadius: BorderRadius.circular(navBarHeight),
// // // // // //                       border: Border.all(
// // // // // //                         color: Colors.white.withOpacity(0.75),
// // // // // //                         width: 1.0,
// // // // // //                       ),
// // // // // //                       boxShadow: [
// // // // // //                         BoxShadow(
// // // // // //                           color: Colors.black.withOpacity(0.1),
// // // // // //                           blurRadius: 20,
// // // // // //                           offset: const Offset(0, 6),
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                     child: Stack(
// // // // // //                       clipBehavior: Clip.none,
// // // // // //                       children: [
// // // // // //                         // خلفية العنصر المحدد المتحركة
// // // // // //                         ClipRRect(
// // // // // //                           borderRadius: BorderRadius.circular(navBarHeight),
// // // // // //                           child: Stack(
// // // // // //                             children: [
// // // // // //                               AnimatedPositioned(
// // // // // //                                 duration: const Duration(milliseconds: 320),
// // // // // //                                 curve: Curves.easeInOutCubic,
// // // // // //                                 left: pillLeft,
// // // // // //                                 top: pillTop,
// // // // // //                                 child: AnimatedContainer(
// // // // // //                                   duration: const Duration(milliseconds: 320),
// // // // // //                                   curve: Curves.easeInOutCubic,
// // // // // //                                   width: pillWidth,
// // // // // //                                   height: pillHeight,
// // // // // //                                   alignment: Alignment.bottomCenter,
// // // // // //                                   child: SvgPicture.asset(
// // // // // //                                     'icons/Subtract.svg',
// // // // // //                                     width: pillWidth,
// // // // // //                                     height: pillHeight,
// // // // // //                                     fit: BoxFit.fill,
// // // // // //                                     colorFilter: const ColorFilter.mode(
// // // // // //                                       AppColors.tealGray,
// // // // // //                                       BlendMode.srcIn,
// // // // // //                                     ),
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             ],
// // // // // //                           ),
// // // // // //                         ),

// // // // // //                         // عناصر القائمة
// // // // // //                         Row(
// // // // // //                           children: List.generate(_items.length, (index) {
// // // // // //                             final bool isSelected = index == currentIndex;
// // // // // //                             final _NavItemData item = _items[index];

// // // // // //                             return SizedBox(
// // // // // //                               width: itemWidth,
// // // // // //                               height: navBarHeight,
// // // // // //                               child: GestureDetector(
// // // // // //                                 behavior: HitTestBehavior.opaque,
// // // // // //                                 onTap: () => onTap(index),
// // // // // //                                 child: Center(
// // // // // //                                   child: Column(
// // // // // //                                     mainAxisSize: MainAxisSize.min,
// // // // // //                                     mainAxisAlignment: MainAxisAlignment.center,
// // // // // //                                     children: [
// // // // // //                                       _buildIcon(item, isSelected, iconSize),
// // // // // //                                       AnimatedSize(
// // // // // //                                         duration: const Duration(milliseconds: 320),
// // // // // //                                         curve: Curves.easeInOutCubic,
// // // // // //                                         child: isSelected
// // // // // //                                             ? Padding(
// // // // // //                                                 padding: EdgeInsets.only(top: labelSpacing),
// // // // // //                                                 child: FittedBox(
// // // // // //                                                   fit: BoxFit.scaleDown,
// // // // // //                                                   child: Text(
// // // // // //                                                     item.label,
// // // // // //                                                     maxLines: 1,
// // // // // //                                                     style: TextStyle(
// // // // // //                                                       color: Colors.white,
// // // // // //                                                       fontSize: fontSize,
// // // // // //                                                       fontWeight: FontWeight.w600,
// // // // // //                                                     ),
// // // // // //                                                   ),
// // // // // //                                                 ),
// // // // // //                                               )
// // // // // //                                             : const SizedBox(width: 0, height: 0),
// // // // // //                                       ),
// // // // // //                                     ],
// // // // // //                                   ),
// // // // // //                                 ),
// // // // // //                               ),
// // // // // //                             );
// // // // // //                           }),
// // // // // //                         ),
// // // // // //                       ],
// // // // // //                     ),
// // // // // //                   ),
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           );
// // // // // //         },
// // // // // //       ),
// // // // // //     );
// // // // // //   }

// // // // // //   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
// // // // // //     final bool isBag = item.icon == 'icons/Bag.svg';

// // // // // //     final Widget icon = SvgPicture.asset(
// // // // // //       item.icon,
// // // // // //       width: iconSize,
// // // // // //       height: iconSize,
// // // // // //       colorFilter: ColorFilter.mode(
// // // // // //         isSelected ? Colors.white : Colors.black,
// // // // // //         BlendMode.srcIn,
// // // // // //       ),
// // // // // //     );

// // // // // //     if (!isBag) return icon;

// // // // // //     return Stack(
// // // // // //       clipBehavior: Clip.none,
// // // // // //       children: [
// // // // // //         icon,
// // // // // //         if (cartItemCount > 0)
// // // // // //           Positioned(
// // // // // //             right: -2,
// // // // // //             top: -2,
// // // // // //             child: Container(
// // // // // //               padding: const EdgeInsets.all(2),
// // // // // //               constraints: BoxConstraints(
// // // // // //                 minWidth: iconSize * 0.45,
// // // // // //                 minHeight: iconSize * 0.45,
// // // // // //               ),
// // // // // //               alignment: Alignment.center,
// // // // // //               decoration: const BoxDecoration(
// // // // // //                 color: Colors.redAccent,
// // // // // //                 shape: BoxShape.circle,
// // // // // //               ),
// // // // // //               child: Text(
// // // // // //                 '$cartItemCount',
// // // // // //                 style: TextStyle(
// // // // // //                   color: Colors.white,
// // // // // //                   fontSize: iconSize * 0.28,
// // // // // //                   fontWeight: FontWeight.bold,
// // // // // //                 ),
// // // // // //               ),
// // // // // //             ),
// // // // // //           ),
// // // // // //       ],
// // // // // //     );
// // // // // //   }
// // // // // // }

// // // // // import 'dart:ui';
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:flutter_svg/flutter_svg.dart';
// // // // // import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// // // // // class _NavItemData {
// // // // //   final String icon;
// // // // //   final String label;

// // // // //   const _NavItemData({required this.icon, required this.label});
// // // // // }

// // // // // class CustomBottomNavBar extends StatelessWidget {
// // // // //   final int currentIndex;
// // // // //   final ValueChanged<int> onTap;
// // // // //   final int cartItemCount;

// // // // //   const CustomBottomNavBar({
// // // // //     Key? key,
// // // // //     required this.currentIndex,
// // // // //     required this.onTap,
// // // // //     this.cartItemCount = 0,
// // // // //   }) : super(key: key);

// // // // //   static const List<_NavItemData> _items = [
// // // // //     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
// // // // //     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
// // // // //     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
// // // // //     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
// // // // //     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
// // // // //   ];

// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return SafeArea(
// // // // //       top: false,
// // // // //       child: LayoutBuilder(
// // // // //         builder: (context, constraints) {
// // // // //           final double fullWidth = constraints.maxWidth;
// // // // //           final double horizontalMargin = fullWidth * 0.05;
// // // // //           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
// // // // //           final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
// // // // //           final double bottomMargin = navBarHeight * 0.24;

// // // // //           final double iconSize = navBarHeight * 0.38;
// // // // //           final double fontSize = navBarHeight * 0.15;
// // // // //           final double labelSpacing = navBarHeight * 0.01;
// // // // //           final double pillHeight = navBarHeight * 1.007;

// // // // //           final double itemWidth = navBarWidth / _items.length;
// // // // //           final double pillWidth = itemWidth * 1.59;

// // // // //           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
// // // // //           final double pillLeft = segmentCenter - pillWidth / 2;
// // // // //           final double pillTop = navBarHeight - pillHeight;

// // // // //           return Padding(
// // // // //             padding: EdgeInsets.only(
// // // // //               left: horizontalMargin,
// // // // //               right: horizontalMargin,
// // // // //               bottom: bottomMargin,
// // // // //             ),
// // // // //             child: Container(
// // // // //               decoration: BoxDecoration(
// // // // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // // // //                 boxShadow: [
// // // // //                   BoxShadow(
// // // // //                     color: Colors.black.withOpacity(0.12),
// // // // //                     blurRadius: 16,
// // // // //                     spreadRadius: 2,
// // // // //                     offset: const Offset(0, 8),
// // // // //                   ),
// // // // //                 ],
// // // // //               ),
// // // // //               child: ClipRRect(
// // // // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // // // //                 child: BackdropFilter(
// // // // //                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // // //                   child: Container(
// // // // //                     width: navBarWidth,
// // // // //                     height: navBarHeight,
// // // // //                     decoration: BoxDecoration(
// // // // //                       color: Colors.white.withOpacity(0.22),
// // // // //                       borderRadius: BorderRadius.circular(navBarHeight),
// // // // //                       border: Border.all(
// // // // //                         color: Colors.white.withOpacity(0.75),
// // // // //                         width: 1.0,
// // // // //                       ),
// // // // //                       boxShadow: [
// // // // //                         BoxShadow(
// // // // //                           color: Colors.black.withOpacity(0.1),
// // // // //                           blurRadius: 20,
// // // // //                           offset: const Offset(0, 6),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                     child: Stack(
// // // // //                       clipBehavior: Clip.none,
// // // // //                       children: [
// // // // //                         // ==== تعديل: كليب مستطيل صريح بدل الكليب الدائري ====
// // // // //                         // قبل كده كانت الـ pill ملفوفة في ClipRRect بنفس
// // // // //                         // انحناء الناف بار (borderRadius: navBarHeight)،
// // // // //                         // فلو العنصر المختار في الطرف (أول أو آخر أيقونة)
// // // // //                         // والـ pill بتاعته أعرض من مساحته وبتخرج بره حدود
// // // // //                         // الناف بار، الكليب كان بيقصّها على المنحنى فبتبان
// // // // //                         // مقطوعة بشكل غير متساوي.
// // // // //                         //
// // // // //                         // دلوقتي بنحدد SizedBox بمقاس الناف بار بالظبط
// // // // //                         // (navBarWidth × navBarHeight) ونستخدم ClipRect
// // // // //                         // عادي (مستطيل مسطّح، مش دائري) — فأي جزء من الـ
// // // // //                         // pill يخرج بره الحدود (من الجنب عند الأطراف، أو
// // // // //                         // من فوق بسبب pillHeight الأكبر شوية) بيتقطع بخط
// // // // //                         // مستقيم نضيف عند حدود الناف بار بالظبط، بنفس
// // // // //                         // الشكل سواء العنصر في النص أو في الطرف.
// // // // //                         SizedBox(
// // // // //                           width: navBarWidth,
// // // // //                           height: navBarHeight,
// // // // //                           child: ClipRect(
// // // // //                             child: Stack(
// // // // //                               clipBehavior: Clip.hardEdge,
// // // // //                               children: [
// // // // //                                 AnimatedPositioned(
// // // // //                                   duration: const Duration(milliseconds: 320),
// // // // //                                   curve: Curves.easeInOutCubic,
// // // // //                                   left: pillLeft,
// // // // //                                   top: pillTop,
// // // // //                                   child: AnimatedContainer(
// // // // //                                     duration: const Duration(milliseconds: 320),
// // // // //                                     curve: Curves.easeInOutCubic,
// // // // //                                     width: pillWidth,
// // // // //                                     height: pillHeight,
// // // // //                                     alignment: Alignment.bottomCenter,
// // // // //                                     child: SvgPicture.asset(
// // // // //                                       'icons/Subtract.svg',
// // // // //                                       width: pillWidth,
// // // // //                                       height: pillHeight,
// // // // //                                       fit: BoxFit.fill,
// // // // //                                       colorFilter: const ColorFilter.mode(
// // // // //                                         AppColors.tealGray,
// // // // //                                         BlendMode.srcIn,
// // // // //                                       ),
// // // // //                                     ),
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ],
// // // // //                             ),
// // // // //                           ),
// // // // //                         ),

// // // // //                         // عناصر القائمة
// // // // //                         Row(
// // // // //                           children: List.generate(_items.length, (index) {
// // // // //                             final bool isSelected = index == currentIndex;
// // // // //                             final _NavItemData item = _items[index];

// // // // //                             return SizedBox(
// // // // //                               width: itemWidth,
// // // // //                               height: navBarHeight,
// // // // //                               child: GestureDetector(
// // // // //                                 behavior: HitTestBehavior.opaque,
// // // // //                                 onTap: () => onTap(index),
// // // // //                                 child: Center(
// // // // //                                   child: Column(
// // // // //                                     mainAxisSize: MainAxisSize.min,
// // // // //                                     mainAxisAlignment: MainAxisAlignment.center,
// // // // //                                     children: [
// // // // //                                       _buildIcon(item, isSelected, iconSize),
// // // // //                                       AnimatedSize(
// // // // //                                         duration: const Duration(milliseconds: 320),
// // // // //                                         curve: Curves.easeInOutCubic,
// // // // //                                         child: isSelected
// // // // //                                             ? Padding(
// // // // //                                                 padding: EdgeInsets.only(top: labelSpacing),
// // // // //                                                 child: FittedBox(
// // // // //                                                   fit: BoxFit.scaleDown,
// // // // //                                                   child: Text(
// // // // //                                                     item.label,
// // // // //                                                     maxLines: 1,
// // // // //                                                     style: TextStyle(
// // // // //                                                       color: Colors.white,
// // // // //                                                       fontSize: fontSize,
// // // // //                                                       fontWeight: FontWeight.w600,
// // // // //                                                     ),
// // // // //                                                   ),
// // // // //                                                 ),
// // // // //                                               )
// // // // //                                             : const SizedBox(width: 0, height: 0),
// // // // //                                       ),
// // // // //                                     ],
// // // // //                                   ),
// // // // //                                 ),
// // // // //                               ),
// // // // //                             );
// // // // //                           }),
// // // // //                         ),
// // // // //                       ],
// // // // //                     ),
// // // // //                   ),
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           );
// // // // //         },
// // // // //       ),
// // // // //     );
// // // // //   }

// // // // //   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
// // // // //     final bool isBag = item.icon == 'icons/Bag.svg';

// // // // //     final Widget icon = SvgPicture.asset(
// // // // //       item.icon,
// // // // //       width: iconSize,
// // // // //       height: iconSize,
// // // // //       colorFilter: ColorFilter.mode(
// // // // //         isSelected ? Colors.white : Colors.black,
// // // // //         BlendMode.srcIn,
// // // // //       ),
// // // // //     );

// // // // //     if (!isBag) return icon;

// // // // //     return Stack(
// // // // //       clipBehavior: Clip.none,
// // // // //       children: [
// // // // //         icon,
// // // // //         if (cartItemCount > 0)
// // // // //           Positioned(
// // // // //             right: -2,
// // // // //             top: -2,
// // // // //             child: Container(
// // // // //               padding: const EdgeInsets.all(2),
// // // // //               constraints: BoxConstraints(
// // // // //                 minWidth: iconSize * 0.45,
// // // // //                 minHeight: iconSize * 0.45,
// // // // //               ),
// // // // //               alignment: Alignment.center,
// // // // //               decoration: const BoxDecoration(
// // // // //                 color: Colors.redAccent,
// // // // //                 shape: BoxShape.circle,
// // // // //               ),
// // // // //               child: Text(
// // // // //                 '$cartItemCount',
// // // // //                 style: TextStyle(
// // // // //                   color: Colors.white,
// // // // //                   fontSize: iconSize * 0.28,
// // // // //                   fontWeight: FontWeight.bold,
// // // // //                 ),
// // // // //               ),
// // // // //             ),
// // // // //           ),
// // // // //       ],
// // // // //     );
// // // // //   }
// // // // // }

// // // // import 'dart:ui';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_svg/flutter_svg.dart';
// // // // import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// // // // class _NavItemData {
// // // //   final String icon;
// // // //   final String label;

// // // //   const _NavItemData({required this.icon, required this.label});
// // // // }

// // // // class CustomBottomNavBar extends StatelessWidget {
// // // //   final int currentIndex;
// // // //   final ValueChanged<int> onTap;
// // // //   final int cartItemCount;

// // // //   const CustomBottomNavBar({
// // // //     Key? key,
// // // //     required this.currentIndex,
// // // //     required this.onTap,
// // // //     this.cartItemCount = 0,
// // // //   }) : super(key: key);

// // // //   static const List<_NavItemData> _items = [
// // // //     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
// // // //     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
// // // //     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
// // // //     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
// // // //     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
// // // //   ];

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return SafeArea(
// // // //       top: false,
// // // //       child: LayoutBuilder(
// // // //         builder: (context, constraints) {
// // // //           final double fullWidth = constraints.maxWidth;
// // // //           final double horizontalMargin = fullWidth * 0.05;
// // // //           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
// // // //           final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
// // // //           final double bottomMargin = navBarHeight * 0.24;

// // // //           final double iconSize = navBarHeight * 0.38;
// // // //           final double fontSize = navBarHeight * 0.15;
// // // //           final double labelSpacing = navBarHeight * 0.01;

// // // //           // ==== تعديل: تقصير الـ pill + هامش بسيط من تحت ====
// // // //           // 1) قللنا نسبة الارتفاع من 1.007 (طول الناف بار بالظبط تقريبًا)
// // // //           //    لـ 0.82 عشان الشكل يبقى أقصر شوية زي ما طلبت.
// // // //           // 2) bottomGap دي مسافة بسيطة (5% من ارتفاع الناف بار) بتتحط
// // // //           //    بين أسفل الـ pill وآخر الناف بار، عشان محدش يحس إنها
// // // //           //    "لازقة" في الحتة التحتانية بدون أي هامش.
// // // //           //
// // // //           // لو عايز تتحكم أكتر: كبّر/صغّر 0.82 عشان تتحكم في طول البمب
// // // //           // نفسه، وكبّر/صغّر 0.05 عشان تتحكم في المسافة من تحت.
// // // //           final double pillHeight = navBarHeight * 0.82;
// // // //           final double bottomGap = navBarHeight * 0.05;

// // // //           final double itemWidth = navBarWidth / _items.length;
// // // //           final double pillWidth = itemWidth * 1.59;

// // // //           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
// // // //           final double pillLeft = segmentCenter - pillWidth / 2;
// // // //           final double pillTop = (navBarHeight - bottomGap) - pillHeight;

// // // //           return Padding(
// // // //             padding: EdgeInsets.only(
// // // //               left: horizontalMargin,
// // // //               right: horizontalMargin,
// // // //               bottom: bottomMargin,
// // // //             ),
// // // //             child: Container(
// // // //               decoration: BoxDecoration(
// // // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // // //                 boxShadow: [
// // // //                   BoxShadow(
// // // //                     color: Colors.black.withOpacity(0.12),
// // // //                     blurRadius: 16,
// // // //                     spreadRadius: 2,
// // // //                     offset: const Offset(0, 8),
// // // //                   ),
// // // //                 ],
// // // //               ),
// // // //               child: ClipRRect(
// // // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // // //                 child: BackdropFilter(
// // // //                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // // //                   child: Container(
// // // //                     width: navBarWidth,
// // // //                     height: navBarHeight,
// // // //                     decoration: BoxDecoration(
// // // //                       color: Colors.white.withOpacity(0.22),
// // // //                       borderRadius: BorderRadius.circular(navBarHeight),
// // // //                       border: Border.all(
// // // //                         color: Colors.white.withOpacity(0.75),
// // // //                         width: 1.0,
// // // //                       ),
// // // //                       boxShadow: [
// // // //                         BoxShadow(
// // // //                           color: Colors.black.withOpacity(0.1),
// // // //                           blurRadius: 20,
// // // //                           offset: const Offset(0, 6),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                     child: Stack(
// // // //                       clipBehavior: Clip.none,
// // // //                       children: [
// // // //                         // ==== تعديل: كليب مستطيل صريح بدل الكليب الدائري ====
// // // //                         // قبل كده كانت الـ pill ملفوفة في ClipRRect بنفس
// // // //                         // انحناء الناف بار (borderRadius: navBarHeight)،
// // // //                         // فلو العنصر المختار في الطرف (أول أو آخر أيقونة)
// // // //                         // والـ pill بتاعته أعرض من مساحته وبتخرج بره حدود
// // // //                         // الناف بار، الكليب كان بيقصّها على المنحنى فبتبان
// // // //                         // مقطوعة بشكل غير متساوي.
// // // //                         //
// // // //                         // دلوقتي بنحدد SizedBox بمقاس الناف بار بالظبط
// // // //                         // (navBarWidth × navBarHeight) ونستخدم ClipRect
// // // //                         // عادي (مستطيل مسطّح، مش دائري) — فأي جزء من الـ
// // // //                         // pill يخرج بره الحدود (من الجنب عند الأطراف، أو
// // // //                         // من فوق بسبب pillHeight الأكبر شوية) بيتقطع بخط
// // // //                         // مستقيم نضيف عند حدود الناف بار بالظبط، بنفس
// // // //                         // الشكل سواء العنصر في النص أو في الطرف.
// // // //                         SizedBox(
// // // //                           width: navBarWidth,
// // // //                           height: navBarHeight,
// // // //                           child: ClipRect(
// // // //                             child: Stack(
// // // //                               clipBehavior: Clip.hardEdge,
// // // //                               children: [
// // // //                                 AnimatedPositioned(
// // // //                                   duration: const Duration(milliseconds: 320),
// // // //                                   curve: Curves.easeInOutCubic,
// // // //                                   left: pillLeft,
// // // //                                   top: pillTop,
// // // //                                   child: AnimatedContainer(
// // // //                                     duration: const Duration(milliseconds: 320),
// // // //                                     curve: Curves.easeInOutCubic,
// // // //                                     width: pillWidth,
// // // //                                     height: pillHeight,
// // // //                                     alignment: Alignment.bottomCenter,
// // // //                                     child: SvgPicture.asset(
// // // //                                       'icons/Subtract.svg',
// // // //                                       width: pillWidth,
// // // //                                       height: pillHeight,
// // // //                                       fit: BoxFit.fill,
// // // //                                       colorFilter: const ColorFilter.mode(
// // // //                                         AppColors.tealGray,
// // // //                                         BlendMode.srcIn,
// // // //                                       ),
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         ),

// // // //                         // عناصر القائمة
// // // //                         Row(
// // // //                           children: List.generate(_items.length, (index) {
// // // //                             final bool isSelected = index == currentIndex;
// // // //                             final _NavItemData item = _items[index];

// // // //                             return SizedBox(
// // // //                               width: itemWidth,
// // // //                               height: navBarHeight,
// // // //                               child: GestureDetector(
// // // //                                 behavior: HitTestBehavior.opaque,
// // // //                                 onTap: () => onTap(index),
// // // //                                 child: Center(
// // // //                                   child: Column(
// // // //                                     mainAxisSize: MainAxisSize.min,
// // // //                                     mainAxisAlignment: MainAxisAlignment.center,
// // // //                                     children: [
// // // //                                       _buildIcon(item, isSelected, iconSize),
// // // //                                       AnimatedSize(
// // // //                                         duration: const Duration(milliseconds: 320),
// // // //                                         curve: Curves.easeInOutCubic,
// // // //                                         child: isSelected
// // // //                                             ? Padding(
// // // //                                                 padding: EdgeInsets.only(top: labelSpacing),
// // // //                                                 child: FittedBox(
// // // //                                                   fit: BoxFit.scaleDown,
// // // //                                                   child: Text(
// // // //                                                     item.label,
// // // //                                                     maxLines: 1,
// // // //                                                     style: TextStyle(
// // // //                                                       color: Colors.white,
// // // //                                                       fontSize: fontSize,
// // // //                                                       fontWeight: FontWeight.w600,
// // // //                                                     ),
// // // //                                                   ),
// // // //                                                 ),
// // // //                                               )
// // // //                                             : const SizedBox(width: 0, height: 0),
// // // //                                       ),
// // // //                                     ],
// // // //                                   ),
// // // //                                 ),
// // // //                               ),
// // // //                             );
// // // //                           }),
// // // //                         ),
// // // //                       ],
// // // //                     ),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           );
// // // //         },
// // // //       ),
// // // //     );
// // // //   }

// // // //   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
// // // //     final bool isBag = item.icon == 'icons/Bag.svg';

// // // //     final Widget icon = SvgPicture.asset(
// // // //       item.icon,
// // // //       width: iconSize,
// // // //       height: iconSize,
// // // //       colorFilter: ColorFilter.mode(
// // // //         isSelected ? Colors.white : Colors.black,
// // // //         BlendMode.srcIn,
// // // //       ),
// // // //     );

// // // //     if (!isBag) return icon;

// // // //     return Stack(
// // // //       clipBehavior: Clip.none,
// // // //       children: [
// // // //         icon,
// // // //         if (cartItemCount > 0)
// // // //           Positioned(
// // // //             right: -2,
// // // //             top: -2,
// // // //             child: Container(
// // // //               padding: const EdgeInsets.all(2),
// // // //               constraints: BoxConstraints(
// // // //                 minWidth: iconSize * 0.45,
// // // //                 minHeight: iconSize * 0.45,
// // // //               ),
// // // //               alignment: Alignment.center,
// // // //               decoration: const BoxDecoration(
// // // //                 color: Colors.redAccent,
// // // //                 shape: BoxShape.circle,
// // // //               ),
// // // //               child: Text(
// // // //                 '$cartItemCount',
// // // //                 style: TextStyle(
// // // //                   color: Colors.white,
// // // //                   fontSize: iconSize * 0.28,
// // // //                   fontWeight: FontWeight.bold,
// // // //                 ),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }

// // // import 'dart:ui';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_svg/flutter_svg.dart';
// // // import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// // // class _NavItemData {
// // //   final String icon;
// // //   final String label;

// // //   const _NavItemData({required this.icon, required this.label});
// // // }

// // // class CustomBottomNavBar extends StatelessWidget {
// // //   final int currentIndex;
// // //   final ValueChanged<int> onTap;
// // //   final int cartItemCount;

// // //   const CustomBottomNavBar({
// // //     Key? key,
// // //     required this.currentIndex,
// // //     required this.onTap,
// // //     this.cartItemCount = 0,
// // //   }) : super(key: key);

// // //   static const List<_NavItemData> _items = [
// // //     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
// // //     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
// // //     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
// // //     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
// // //     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
// // //   ];

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return SafeArea(
// // //       top: false,
// // //       child: LayoutBuilder(
// // //         builder: (context, constraints) {
// // //           final double fullWidth = constraints.maxWidth;
// // //           final double horizontalMargin = fullWidth * 0.05;
// // //           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
// // //           final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
// // //           final double bottomMargin = navBarHeight * 0.24;

// // //           final double iconSize = navBarHeight * 0.38;
// // //           final double fontSize = navBarHeight * 0.15;
// // //           final double labelSpacing = navBarHeight * 0.0005;

// // //           // ==== تعديل: السقف يفضل لازق في حرف الناف بار زي الأصل ====
// // //           // topOffset ثابتة ومستقلة عن الطول، بتخلي بداية الـ pill من
// // //           // فوق زي ما كانت بالظبط (لازقة في حرف الناف بار، من غير أي
// // //           // فراغ فوقها). التقصير دلوقتي بيتحقق من خلال تصغير pillHeight
// // //           // بس، وده بيسيب الفراغ يبان تحت الشكل مش فوقه.
// // //           final double topOffset = navBarHeight * -0.007;
// // //           final double pillHeight = navBarHeight * 0.82;

// // //           final double itemWidth = navBarWidth / _items.length;
// // //           final double pillWidth = itemWidth * 1.59;

// // //           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
// // //           final double pillLeft = segmentCenter - pillWidth / 2;
// // //           final double pillTop = topOffset;

// // //           return Padding(
// // //             padding: EdgeInsets.only(
// // //               left: horizontalMargin,
// // //               right: horizontalMargin,
// // //               bottom: bottomMargin,
// // //             ),
// // //             child: Container(
// // //               decoration: BoxDecoration(
// // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // //                 boxShadow: [
// // //                   BoxShadow(
// // //                     color: Colors.black.withOpacity(0.12),
// // //                     blurRadius: 16,
// // //                     spreadRadius: 2,
// // //                     offset: const Offset(0, 8),
// // //                   ),
// // //                 ],
// // //               ),
// // //               child: ClipRRect(
// // //                 borderRadius: BorderRadius.circular(navBarHeight),
// // //                 child: BackdropFilter(
// // //                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// // //                   child: Container(
// // //                     width: navBarWidth,
// // //                     height: navBarHeight,
// // //                     decoration: BoxDecoration(
// // //                       color: Colors.white.withOpacity(0.22),
// // //                       borderRadius: BorderRadius.circular(navBarHeight),
// // //                       border: Border.all(
// // //                         color: Colors.white.withOpacity(0.75),
// // //                         width: 1.0,
// // //                       ),
// // //                       boxShadow: [
// // //                         BoxShadow(
// // //                           color: Colors.black.withOpacity(0.1),
// // //                           blurRadius: 20,
// // //                           offset: const Offset(0, 6),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                     child: Stack(
// // //                       clipBehavior: Clip.none,
// // //                       children: [
// // //                         // ==== تعديل: كليب مستطيل صريح بدل الكليب الدائري ====
// // //                         // قبل كده كانت الـ pill ملفوفة في ClipRRect بنفس
// // //                         // انحناء الناف بار (borderRadius: navBarHeight)،
// // //                         // فلو العنصر المختار في الطرف (أول أو آخر أيقونة)
// // //                         // والـ pill بتاعته أعرض من مساحته وبتخرج بره حدود
// // //                         // الناف بار، الكليب كان بيقصّها على المنحنى فبتبان
// // //                         // مقطوعة بشكل غير متساوي.
// // //                         //
// // //                         // دلوقتي بنحدد SizedBox بمقاس الناف بار بالظبط
// // //                         // (navBarWidth × navBarHeight) ونستخدم ClipRect
// // //                         // عادي (مستطيل مسطّح، مش دائري) — فأي جزء من الـ
// // //                         // pill يخرج بره الحدود (من الجنب عند الأطراف، أو
// // //                         // من فوق بسبب pillHeight الأكبر شوية) بيتقطع بخط
// // //                         // مستقيم نضيف عند حدود الناف بار بالظبط، بنفس
// // //                         // الشكل سواء العنصر في النص أو في الطرف.
// // //                         SizedBox(
// // //                           width: navBarWidth,
// // //                           height: navBarHeight,
// // //                           child: ClipRect(
// // //                             child: Stack(
// // //                               clipBehavior: Clip.hardEdge,
// // //                               children: [
// // //                                 AnimatedPositioned(
// // //                                   duration: const Duration(milliseconds: 320),
// // //                                   curve: Curves.easeInOutCubic,
// // //                                   left: pillLeft,
// // //                                   top: pillTop,
// // //                                   child: AnimatedContainer(
// // //                                     duration: const Duration(milliseconds: 320),
// // //                                     curve: Curves.easeInOutCubic,
// // //                                     width: pillWidth,
// // //                                     height: pillHeight,
// // //                                     alignment: Alignment.bottomCenter,
// // //                                     child: SvgPicture.asset(
// // //                                       'icons/Subtract.svg',
// // //                                       width: pillWidth,
// // //                                       height: pillHeight,
// // //                                       fit: BoxFit.fill,
// // //                                       colorFilter: const ColorFilter.mode(
// // //                                         AppColors.tealGray,
// // //                                         BlendMode.srcIn,
// // //                                       ),
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         ),

// // //                         // عناصر القائمة
// // //                         Row(
// // //                           children: List.generate(_items.length, (index) {
// // //                             final bool isSelected = index == currentIndex;
// // //                             final _NavItemData item = _items[index];

// // //                             return SizedBox(
// // //                               width: itemWidth,
// // //                               height: navBarHeight,
// // //                               child: GestureDetector(
// // //                                 behavior: HitTestBehavior.opaque,
// // //                                 onTap: () => onTap(index),
// // //                                 child: Center(
// // //                                   child: Column(
// // //                                     mainAxisSize: MainAxisSize.min,
// // //                                     mainAxisAlignment: MainAxisAlignment.center,
// // //                                     children: [
// // //                                       _buildIcon(item, isSelected, iconSize),
// // //                                       AnimatedSize(
// // //                                         duration: const Duration(milliseconds: 320),
// // //                                         curve: Curves.easeInOutCubic,
// // //                                         child: isSelected
// // //                                             ? Padding(
// // //                                                 padding: EdgeInsets.only(top: labelSpacing),
// // //                                                 child: FittedBox(
// // //                                                   fit: BoxFit.scaleDown,
// // //                                                   child: Text(
// // //                                                     item.label,
// // //                                                     maxLines: 1,
// // //                                                     style: TextStyle(
// // //                                                       color: Colors.white,
// // //                                                       fontSize: fontSize,
// // //                                                       fontWeight: FontWeight.w600,
// // //                                                     ),
// // //                                                   ),
// // //                                                 ),
// // //                                               )
// // //                                             : const SizedBox(width: 0, height: 0),
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                               ),
// // //                             );
// // //                           }),
// // //                         ),
// // //                       ],
// // //                     ),
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
// // //     final bool isBag = item.icon == 'icons/Bag.svg';

// // //     final Widget icon = SvgPicture.asset(
// // //       item.icon,
// // //       width: iconSize,
// // //       height: iconSize,
// // //       colorFilter: ColorFilter.mode(
// // //         isSelected ? Colors.white : Colors.black,
// // //         BlendMode.srcIn,
// // //       ),
// // //     );

// // //     if (!isBag) return icon;

// // //     return Stack(
// // //       clipBehavior: Clip.none,
// // //       children: [
// // //         icon,
// // //         if (cartItemCount > 0)
// // //           Positioned(
// // //             right: -2,
// // //             top: -2,
// // //             child: Container(
// // //               padding: const EdgeInsets.all(2),
// // //               constraints: BoxConstraints(
// // //                 minWidth: iconSize * 0.45,
// // //                 minHeight: iconSize * 0.45,
// // //               ),
// // //               alignment: Alignment.center,
// // //               decoration: const BoxDecoration(
// // //                 color: Colors.redAccent,
// // //                 shape: BoxShape.circle,
// // //               ),
// // //               child: Text(
// // //                 '$cartItemCount',
// // //                 style: TextStyle(
// // //                   color: Colors.white,
// // //                   fontSize: iconSize * 0.28,
// // //                   fontWeight: FontWeight.bold,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //       ],
// // //     );
// // //   }
// // // }


// // import 'dart:ui';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// // import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// // class _NavItemData {
// //   final String icon;
// //   final String label;

// //   const _NavItemData({required this.icon, required this.label});
// // }

// // class CustomBottomNavBar extends StatelessWidget {
// //   final int currentIndex;
// //   final ValueChanged<int> onTap;
// //   final int cartItemCount;

// //   const CustomBottomNavBar({
// //     Key? key,
// //     required this.currentIndex,
// //     required this.onTap,
// //     this.cartItemCount = 0,
// //   }) : super(key: key);

// //   static const List<_NavItemData> _items = [
// //     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
// //     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
// //     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
// //     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
// //     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return SafeArea(
// //       top: false,
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           final double fullWidth = constraints.maxWidth;
// //           final double horizontalMargin = fullWidth * 0.05;
// //           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
// //           final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
// //           final double bottomMargin = navBarHeight * 0.24;

// //           final double iconSize = navBarHeight * 0.38;
// //           final double fontSize = navBarHeight * 0.15;
// //           final double labelSpacing = navBarHeight * 0.01;

// //           // ==== تعديل: السقف يفضل لازق في حرف الناف بار زي الأصل ====
// //           // topOffset ثابتة ومستقلة عن الطول، بتخلي بداية الـ pill من
// //           // فوق زي ما كانت بالظبط (لازقة في حرف الناف بار، من غير أي
// //           // فراغ فوقها). التقصير دلوقتي بيتحقق من خلال تصغير pillHeight
// //           // بس، وده بيسيب الفراغ يبان تحت الشكل مش فوقه.
// //           final double topOffset = navBarHeight * -0.007;
// //           final double pillHeight = navBarHeight * 0.82;

// //           final double itemWidth = navBarWidth / _items.length;
// //           final double pillWidth = itemWidth * 1.59;

// //           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
// //           final double pillLeft = segmentCenter - pillWidth / 2;
// //           final double pillTop = topOffset;

// //           return Padding(
// //             padding: EdgeInsets.only(
// //               left: horizontalMargin,
// //               right: horizontalMargin,
// //               bottom: bottomMargin,
// //             ),
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 borderRadius: BorderRadius.circular(navBarHeight),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.black.withOpacity(0.12),
// //                     blurRadius: 16,
// //                     spreadRadius: 2,
// //                     offset: const Offset(0, 8),
// //                   ),
// //                 ],
// //               ),
// //               child: ClipRRect(
// //                 borderRadius: BorderRadius.circular(navBarHeight),
// //                 child: BackdropFilter(
// //                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
// //                   child: Container(
// //                     width: navBarWidth,
// //                     height: navBarHeight,
// //                     decoration: BoxDecoration(
// //                       color: Colors.white.withOpacity(0.22),
// //                       borderRadius: BorderRadius.circular(navBarHeight),
// //                       border: Border.all(
// //                         color: Colors.white.withOpacity(0.75),
// //                         width: 1.0,
// //                       ),
// //                       boxShadow: [
// //                         BoxShadow(
// //                           color: Colors.black.withOpacity(0.1),
// //                           blurRadius: 20,
// //                           offset: const Offset(0, 6),
// //                         ),
// //                       ],
// //                     ),
// //                     child: Stack(
// //                       clipBehavior: Clip.none,
// //                       children: [
// //                         // ==== تعديل: كليب مستطيل صريح بدل الكليب الدائري ====
// //                         // قبل كده كانت الـ pill ملفوفة في ClipRRect بنفس
// //                         // انحناء الناف بار (borderRadius: navBarHeight)،
// //                         // فلو العنصر المختار في الطرف (أول أو آخر أيقونة)
// //                         // والـ pill بتاعته أعرض من مساحته وبتخرج بره حدود
// //                         // الناف بار، الكليب كان بيقصّها على المنحنى فبتبان
// //                         // مقطوعة بشكل غير متساوي.
// //                         //
// //                         // دلوقتي بنحدد SizedBox بمقاس الناف بار بالظبط
// //                         // (navBarWidth × navBarHeight) ونستخدم ClipRect
// //                         // عادي (مستطيل مسطّح، مش دائري) — فأي جزء من الـ
// //                         // pill يخرج بره الحدود (من الجنب عند الأطراف، أو
// //                         // من فوق بسبب pillHeight الأكبر شوية) بيتقطع بخط
// //                         // مستقيم نضيف عند حدود الناف بار بالظبط، بنفس
// //                         // الشكل سواء العنصر في النص أو في الطرف.
// //                         SizedBox(
// //                           width: navBarWidth,
// //                           height: navBarHeight,
// //                           child: ClipRect(
// //                             child: Stack(
// //                               clipBehavior: Clip.hardEdge,
// //                               children: [
// //                                 AnimatedPositioned(
// //                                   duration: const Duration(milliseconds: 320),
// //                                   curve: Curves.easeInOutCubic,
// //                                   left: pillLeft,
// //                                   top: pillTop,
// //                                   child: AnimatedContainer(
// //                                     duration: const Duration(milliseconds: 320),
// //                                     curve: Curves.easeInOutCubic,
// //                                     width: pillWidth,
// //                                     height: pillHeight,
// //                                     alignment: Alignment.bottomCenter,
// //                                     child: SvgPicture.asset(
// //                                       'icons/Subtract.svg',
// //                                       width: pillWidth,
// //                                       height: pillHeight,
// //                                       fit: BoxFit.fill,
// //                                       colorFilter: const ColorFilter.mode(
// //                                         AppColors.tealGray,
// //                                         BlendMode.srcIn,
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ],
// //                             ),
// //                           ),
// //                         ),

// //                         // عناصر القائمة
// //                         Row(
// //                           children: List.generate(_items.length, (index) {
// //                             final bool isSelected = index == currentIndex;
// //                             final _NavItemData item = _items[index];

// //                             return SizedBox(
// //                               width: itemWidth,
// //                               height: navBarHeight,
// //                               child: GestureDetector(
// //                                 behavior: HitTestBehavior.opaque,
// //                                 onTap: () => onTap(index),
// //                                 child: Center(
// //                                   child: Column(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     mainAxisAlignment: MainAxisAlignment.center,
// //                                     children: [
// //                                       _buildIcon(item, isSelected, iconSize),
// //                                       AnimatedSize(
// //                                         duration: const Duration(milliseconds: 320),
// //                                         curve: Curves.easeInOutCubic,
// //                                         child: isSelected
// //                                             ? Padding(
// //                                                 padding: EdgeInsets.only(top: labelSpacing),
// //                                                 child: FittedBox(
// //                                                   fit: BoxFit.scaleDown,
// //                                                   child: Text(
// //                                                     item.label,
// //                                                     maxLines: 1,
// //                                                     style: TextStyle(
// //                                                       color: Colors.white,
// //                                                       fontSize: fontSize,
// //                                                       fontWeight: FontWeight.w600,
// //                                                     ),
// //                                                   ),
// //                                                 ),
// //                                               )
// //                                             : const SizedBox(width: 0, height: 0),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             );
// //                           }),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
// //     final bool isBag = item.icon == 'icons/Bag.svg';

// //     final Widget icon = SvgPicture.asset(
// //       item.icon,
// //       width: iconSize,
// //       height: iconSize,
// //       colorFilter: ColorFilter.mode(
// //         isSelected ? Colors.white : Colors.black,
// //         BlendMode.srcIn,
// //       ),
// //     );

// //     if (!isBag) return icon;

// //     return Stack(
// //       clipBehavior: Clip.none,
// //       children: [
// //         icon,
// //         if (cartItemCount > 0)
// //           Positioned(
// //             right: -2,
// //             top: -2,
// //             child: Container(
// //               padding: const EdgeInsets.all(2),
// //               constraints: BoxConstraints(
// //                 minWidth: iconSize * 0.45,
// //                 minHeight: iconSize * 0.45,
// //               ),
// //               alignment: Alignment.center,
// //               decoration: const BoxDecoration(
// //                 color: Colors.redAccent,
// //                 shape: BoxShape.circle,
// //               ),
// //               child: Text(
// //                 '$cartItemCount',
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: iconSize * 0.28,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }

// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

// class _NavItemData {
//   final String icon;
//   final String label;

//   const _NavItemData({required this.icon, required this.label});
// }

// class CustomBottomNavBar extends StatelessWidget {
//   final int currentIndex;
//   final ValueChanged<int> onTap;
//   final int cartItemCount;

//   const CustomBottomNavBar({
//     Key? key,
//     required this.currentIndex,
//     required this.onTap,
//     this.cartItemCount = 0,
//   }) : super(key: key);

//   static const List<_NavItemData> _items = [
//     _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
//     _NavItemData(icon: 'icons/search.svg', label: 'Search'),
//     _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
//     _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
//     _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final double fullWidth = constraints.maxWidth;
//           final double horizontalMargin = fullWidth * 0.05;
//           final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
//           final double navBarHeight = (fullWidth * 0.25).clamp(64.0, 84.0);
//           final double bottomMargin = navBarHeight * 0.24;

//           final double iconSize = navBarHeight * 0.38;
//           final double fontSize = navBarHeight * 0.15;
//           final double labelSpacing = navBarHeight * 0.01;

//           // ==== تعديل: السقف يفضل لازق في حرف الناف بار زي الأصل ====
//           // topOffset ثابتة ومستقلة عن الطول، بتخلي بداية الـ pill من
//           // فوق زي ما كانت بالظبط (لازقة في حرف الناف بار، من غير أي
//           // فراغ فوقها). التقصير دلوقتي بيتحقق من خلال تصغير pillHeight
//           // بس، وده بيسيب الفراغ يبان تحت الشكل مش فوقه.
//           final double topOffset = navBarHeight * -0.007;
//           final double pillHeight = navBarHeight * 0.82;

//           final double itemWidth = navBarWidth / _items.length;
//           final double pillWidth = itemWidth * 1.59;

//           final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
//           final double pillLeft = segmentCenter - pillWidth / 2;
//           final double pillTop = topOffset;

//           return Padding(
//             padding: EdgeInsets.only(
//               left: horizontalMargin,
//               right: horizontalMargin,
//               bottom: bottomMargin,
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(navBarHeight),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.12),
//                     blurRadius: 16,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(navBarHeight),
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                   child: Container(
//                     width: navBarWidth,
//                     height: navBarHeight,
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.22),
//                       borderRadius: BorderRadius.circular(navBarHeight),
//                       border: Border.all(
//                         color: Colors.white.withOpacity(0.75),
//                         width: 1.0,
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.black.withOpacity(0.1),
//                           blurRadius: 20,
//                           offset: const Offset(0, 6),
//                         ),
//                       ],
//                     ),
//                     child: Stack(
//                       clipBehavior: Clip.none,
//                       children: [
//                         // ==== تعديل: كليب مستطيل صريح بدل الكليب الدائري ====
//                         // قبل كده كانت الـ pill ملفوفة في ClipRRect بنفس
//                         // انحناء الناف بار (borderRadius: navBarHeight)،
//                         // فلو العنصر المختار في الطرف (أول أو آخر أيقونة)
//                         // والـ pill بتاعته أعرض من مساحته وبتخرج بره حدود
//                         // الناف بار، الكليب كان بيقصّها على المنحنى فبتبان
//                         // مقطوعة بشكل غير متساوي.
//                         //
//                         // دلوقتي بنحدد SizedBox بمقاس الناف بار بالظبط
//                         // (navBarWidth × navBarHeight) ونستخدم ClipRect
//                         // عادي (مستطيل مسطّح، مش دائري) — فأي جزء من الـ
//                         // pill يخرج بره الحدود (من الجنب عند الأطراف، أو
//                         // من فوق بسبب pillHeight الأكبر شوية) بيتقطع بخط
//                         // مستقيم نضيف عند حدود الناف بار بالظبط، بنفس
//                         // الشكل سواء العنصر في النص أو في الطرف.
//                         SizedBox(
//                           width: navBarWidth,
//                           height: navBarHeight,
//                           child: ClipRect(
//                             child: Stack(
//                               clipBehavior: Clip.hardEdge,
//                               children: [
//                                 AnimatedPositioned(
//                                   duration: const Duration(milliseconds: 320),
//                                   curve: Curves.easeInOutCubic,
//                                   left: pillLeft,
//                                   top: pillTop,
//                                   child: AnimatedContainer(
//                                     duration: const Duration(milliseconds: 320),
//                                     curve: Curves.easeInOutCubic,
//                                     width: pillWidth,
//                                     height: pillHeight,
//                                     alignment: Alignment.bottomCenter,
//                                     child: SvgPicture.asset(
//                                       'icons/Subtract.svg',
//                                       width: pillWidth,
//                                       height: pillHeight,
//                                       fit: BoxFit.fill,
//                                       colorFilter: const ColorFilter.mode(
//                                         AppColors.tealGray,
//                                         BlendMode.srcIn,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),

//                         // عناصر القائمة
//                         Row(
//                           children: List.generate(_items.length, (index) {
//                             final bool isSelected = index == currentIndex;
//                             final _NavItemData item = _items[index];

//                             return SizedBox(
//                               width: itemWidth,
//                               height: navBarHeight,
//                               child: GestureDetector(
//                                 behavior: HitTestBehavior.opaque,
//                                 onTap: () => onTap(index),
//                                 child: Align(
//                                   // ==== تعديل: رفع الأيقونة + الكلمة شوية لفوق ====
//                                   // كانت Center بتوسّط الكتلة (أيقونة+كلمة) بالظبط
//                                   // في نص ارتفاع الناف بار، فالمسافة اللي تحت
//                                   // الكلمة كانت بتبقى صغيرة عن اللي في فيجما.
//                                   // Alignment(0, -0.15) بترفع الكتلة كلها لفوق
//                                   // شوية (بدل ما تكون في المنتصف تمامًا)، وده
//                                   // بيسيب مساحة أكبر تلقائيًا تحت الكلمة.
//                                   //
//                                   // كبّر الرقم السالب (زي -0.25) لو عايزها ترتفع
//                                   // أكتر، أو قرّبه من 0 لو عايزها ترجع لمنتصفها
//                                   // القديم.
//                                   alignment: const Alignment(0, -0.15),
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       _buildIcon(item, isSelected, iconSize),
//                                       AnimatedSize(
//                                         duration: const Duration(milliseconds: 320),
//                                         curve: Curves.easeInOutCubic,
//                                         child: isSelected
//                                             ? Padding(
//                                                 padding: EdgeInsets.only(top: labelSpacing),
//                                                 child: FittedBox(
//                                                   fit: BoxFit.scaleDown,
//                                                   child: Text(
//                                                     item.label,
//                                                     maxLines: 1,
//                                                     style: TextStyle(
//                                                       color: Colors.white,
//                                                       fontSize: fontSize,
//                                                       fontWeight: FontWeight.w600,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               )
//                                             : const SizedBox(width: 0, height: 0),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
//     final bool isBag = item.icon == 'icons/Bag.svg';

//     final Widget icon = SvgPicture.asset(
//       item.icon,
//       width: iconSize,
//       height: iconSize,
//       colorFilter: ColorFilter.mode(
//         isSelected ? Colors.white : Colors.black,
//         BlendMode.srcIn,
//       ),
//     );

//     if (!isBag) return icon;

//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         icon,
//         if (cartItemCount > 0)
//           Positioned(
//             right: -2,
//             top: -2,
//             child: Container(
//               padding: const EdgeInsets.all(2),
//               constraints: BoxConstraints(
//                 minWidth: iconSize * 0.45,
//                 minHeight: iconSize * 0.45,
//               ),
//               alignment: Alignment.center,
//               decoration: const BoxDecoration(
//                 color: Colors.redAccent,
//                 shape: BoxShape.circle,
//               ),
//               child: Text(
//                 '$cartItemCount',
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: iconSize * 0.28,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }


import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart'; // تأكد من مسار الألوان الخاص بك

class _NavItemData {
  final String icon;
  final String label;

  const _NavItemData({required this.icon, required this.label});
}

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final int cartItemCount;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    this.cartItemCount = 0,
  }) : super(key: key);

  static const List<_NavItemData> _items = [
    _NavItemData(icon: 'icons/solar_heart-outline.svg', label: 'Favorites'),
    _NavItemData(icon: 'icons/nav_search.svg', label: 'Search'),
    _NavItemData(icon: 'icons/hugeicons_home-05.svg', label: 'Home'),
    _NavItemData(icon: 'icons/fluent_person-28-regular.svg', label: 'Profile'),
    _NavItemData(icon: 'icons/Bag.svg', label: 'Cart'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double fullWidth = constraints.maxWidth;
          final double horizontalMargin = fullWidth * 0.05;
          final double navBarWidth = fullWidth - (horizontalMargin * 2.1);
          final double navBarHeight = (fullWidth * 0.19).clamp(64.0, 84.0);
          final double bottomMargin = navBarHeight * 0.24;

          final double iconSize = navBarHeight * 0.38;
          final double fontSize = navBarHeight * 0.15;
          final double labelSpacing = navBarHeight * 0.01;

          // ==== تعديل: السقف يفضل لازق في حرف الناف بار زي الأصل ====
          // topOffset ثابتة ومستقلة عن الطول، بتخلي بداية الـ pill من
          // فوق زي ما كانت بالظبط (لازقة في حرف الناف بار، من غير أي
          // فراغ فوقها). التقصير دلوقتي بيتحقق من خلال تصغير pillHeight
          // بس، وده بيسيب الفراغ يبان تحت الشكل مش فوقه.
          final double topOffset = navBarHeight * -0.007;
          final double pillHeight = navBarHeight * 0.82;

          final double itemWidth = navBarWidth / _items.length;
          final double pillWidth = itemWidth * 1.59;

          final double segmentCenter = currentIndex * itemWidth + itemWidth / 2;
          final double pillLeft = segmentCenter - pillWidth / 2;
          final double pillTop = topOffset;

          return Padding(
            padding: EdgeInsets.only(
              left: horizontalMargin,
              right: horizontalMargin,
              bottom: bottomMargin,
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(navBarHeight),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(navBarHeight),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: navBarWidth,
                    height: navBarHeight,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.22),
                      borderRadius: BorderRadius.circular(navBarHeight),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.75),
                        width: 1.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // ==== تعديل: كليب مستطيل صريح بدل الكليب الدائري ====
                        // قبل كده كانت الـ pill ملفوفة في ClipRRect بنفس
                        // انحناء الناف بار (borderRadius: navBarHeight)،
                        // فلو العنصر المختار في الطرف (أول أو آخر أيقونة)
                        // والـ pill بتاعته أعرض من مساحته وبتخرج بره حدود
                        // الناف بار، الكليب كان بيقصّها على المنحنى فبتبان
                        // مقطوعة بشكل غير متساوي.
                        //
                        // دلوقتي بنحدد SizedBox بمقاس الناف بار بالظبط
                        // (navBarWidth × navBarHeight) ونستخدم ClipRect
                        // عادي (مستطيل مسطّح، مش دائري) — فأي جزء من الـ
                        // pill يخرج بره الحدود (من الجنب عند الأطراف، أو
                        // من فوق بسبب pillHeight الأكبر شوية) بيتقطع بخط
                        // مستقيم نضيف عند حدود الناف بار بالظبط، بنفس
                        // الشكل سواء العنصر في النص أو في الطرف.
                        SizedBox(
                          width: navBarWidth,
                          height: navBarHeight,
                          child: ClipRect(
                            child: Stack(
                              clipBehavior: Clip.hardEdge,
                              children: [
                                AnimatedPositioned(
                                  duration: const Duration(milliseconds: 320),
                                  curve: Curves.easeInOutCubic,
                                  left: pillLeft,
                                  top: pillTop,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 320),
                                    curve: Curves.easeInOutCubic,
                                    width: pillWidth,
                                    height: pillHeight,
                                    alignment: Alignment.bottomCenter,
                                    child: SvgPicture.asset(
                                      'icons/Subtract.svg',
                                      width: pillWidth,
                                      height: pillHeight,
                                      fit: BoxFit.fill,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.tealGray,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // عناصر القائمة
                        Row(
                          children: List.generate(_items.length, (index) {
                            final bool isSelected = index == currentIndex;
                            final _NavItemData item = _items[index];

                            return SizedBox(
                              width: itemWidth,
                              height: navBarHeight,
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => onTap(index),
                                child: Center(
                                  child: Padding(
                                    // ==== تعديل: مسافة ثابتة بالبكسل بدل نسبة محايدة ====
                                    // الـ Alignment(0,-0.15) اللي جربناها قبل كده
                                    // ماكانتش بتفرق لأن الكتلة (أيقونة+كلمة) كانت
                                    // بتاخد أغلب ارتفاع الصندوق أصلاً، فمكنش فيه
                                    // مساحة فاضلة تتحرك فيها الكتلة جوّاها.
                                    //
                                    // هنا بدل الاعتماد على مساحة فاضلة، بنضيف
                                    // Padding ثابت تحت الكتلة نفسها (navBarHeight
                                    // * 0.15). الـ Center برّه بيوسّط الصندوق
                                    // الأكبر (بعد الـ padding)، فده بيرفع الكتلة
                                    // المرئية (أيقونة+كلمة) لفوق فعليًا بمقدار
                                    // نص الـ padding، وبيسيب فراغ واضح تحتها.
                                    //
                                    // كبّر 0.15 لو عايزها ترتفع أكتر، صغّرها لو
                                    // عايزها ترجع لمكانها الأصلي.
                                    padding: EdgeInsets.only(bottom: navBarHeight * 0.15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        _buildIcon(item, isSelected, iconSize),
                                        AnimatedSize(
                                          duration: const Duration(milliseconds: 320),
                                          curve: Curves.easeInOutCubic,
                                          child: isSelected
                                              ? Padding(
                                                  padding: EdgeInsets.only(top: labelSpacing),
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                      item.label,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: fontSize,
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(width: 0, height: 0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildIcon(_NavItemData item, bool isSelected, double iconSize) {
    final bool isBag = item.icon == 'icons/Bag.svg';

    final Widget icon = SvgPicture.asset(
      item.icon,
      width: iconSize,
      height: iconSize,
      colorFilter: ColorFilter.mode(
        isSelected ? Colors.white : Colors.black,
        BlendMode.srcIn,
      ),
    );

    if (!isBag) return icon;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        icon,
        if (cartItemCount > 0)
          Positioned(
            right: -2,
            top: -2,
            child: Container(
              padding: const EdgeInsets.all(2),
              constraints: BoxConstraints(
                minWidth: iconSize * 0.45,
                minHeight: iconSize * 0.45,
              ),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$cartItemCount',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: iconSize * 0.28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }
}