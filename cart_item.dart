// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/colors.dart';

// class CartItem extends StatefulWidget {
//   final String image;
//   final String name;
//   final String brand;
//   final double price;
//   final String size;

//   const CartItem({
//     super.key,
//     required this.image,
//     required this.name,
//     required this.brand,
//     required this.price,
//     required this.size,
//   });

//   @override
//   State<CartItem> createState() => _CartItemState();
// }

// class _CartItemState extends State<CartItem> {
//   int quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [

//           // Product Image
//           Container(
//             width: 90,
//             height: 90,
//             decoration: BoxDecoration(
//               color: Colors.grey.shade100,
//               borderRadius: BorderRadius.circular(15),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(15),
//               child: Image.asset(
//                 widget.image,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),

//           const SizedBox(width: 15),

//           // Product Info
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [

//                 Text(
//                   widget.name,
//                   style: const TextStyle(
//                     fontSize: 17,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),

//                 const SizedBox(height: 3),

//                 Text(
//                   widget.brand,
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: AppColors.gray,
//                   ),
//                 ),

//                 const SizedBox(height: 8),

//                 Text(
//                   "L.E ${widget.price.toStringAsFixed(0)}",
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 20,
//                   ),
//                 ),

//                 const SizedBox(height: 12),

//                 Row(
//                   children: [

//                     InkWell(
//                       onTap: () {
//                         if (quantity > 1) {
//                           setState(() {
//                             quantity--;
//                           });
//                         }
//                       },
//                       child: Container(
//                         width: 28,
//                         height: 28,
//                         decoration: BoxDecoration(
//                           color: AppColors.gray,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(Icons.remove, size: 18),
//                       ),
//                     ),

//                     Padding(
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 14),
//                       child: Text(
//                         quantity.toString(),
//                         style: const TextStyle(fontSize: 18),
//                       ),
//                     ),

//                     InkWell(
//                       onTap: () {
//                         setState(() {
//                           quantity++;
//                         });
//                       },
//                       child: Container(
//                         width: 28,
//                         height: 28,
//                         decoration: const BoxDecoration(
//                           color: AppColors.tealGray,
//                           shape: BoxShape.circle,
//                         ),
//                         child: const Icon(
//                           Icons.keyboard_arrow_up,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),

//           const SizedBox(width: 8),

//           // Right Side
//           Column(
//             children: [

//               Container(
//                 width: 34,
//                 height: 34,
//                 decoration: const BoxDecoration(
//                   color: AppColors.tealGray,
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text(
//                     widget.size,
//                     style: const TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 35),

//               IconButton(
//                 onPressed: () {},
//                 icon: SvgPicture.asset('icons/delete.svg', color: Colors.red,),
//                 iconSize: 28,
//                 ),
        
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class CartItem extends StatefulWidget {
  final String image;
  final String name;
  final String brand;
  final double price;
  final String size;

  /// true  -> teal rounded-square badge with white text (e.g. "XL")
  /// false -> plain bold text, no background (e.g. "L")
  final bool sizeIsBadge;

  /// Color of the trash/delete icon for this specific card.
  /// First item in the mock uses gray, second uses red.
  final Color trashColor;

  final VoidCallback? onDelete;

  const CartItem({
    super.key,
    required this.image,
    required this.name,
    required this.brand,
    required this.price,
    required this.size,
    this.sizeIsBadge = false,
    this.trashColor = Colors.grey,
    this.onDelete,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                widget.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.image_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          // Product Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  widget.brand,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.gray,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "L.E ${widget.price.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppColors.gray,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: const BoxDecoration(
                          color: AppColors.tealGray,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.keyboard_arrow_up,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right Side: size indicator (top) + trash icon (bottom)
          Column(
            children: [
              widget.sizeIsBadge
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.tealGray,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        widget.size,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    )
                  : Text(
                      widget.size,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),

              const SizedBox(height: 35),

              IconButton(
                onPressed: widget.onDelete ?? () {},
                icon: Icon(
                  Icons.delete_outline,
                  color: widget.trashColor,
                ),
                iconSize: 28,
              ),
            ],
          )
        ],
      ),
    );
  }
}