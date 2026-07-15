// import 'package:flutter/material.dart';
// import 'package:project/colors.dart';


// class MethodButton extends StatelessWidget {
//   final String title;
//   final bool isSelected;
//   final VoidCallback onTap;

//   const MethodButton({
//     super.key,
//     required this.title,
//     required this.isSelected,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(14),
//         child: Container(
//           height: 55,
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(14),
//             border: Border.all(
//               color: isSelected
//                   ? AppColors.tealGray
//                   : Colors.grey.shade300,
//             ),
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 isSelected
//                     ? Icons.radio_button_checked
//                     : Icons.radio_button_off,
//                 color: isSelected
//                     ?  AppColors.tealGray
//                     : Colors.black54,
//               ),
//               const SizedBox(width: 10),
//               Text(title),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class MethodButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MethodButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: 55,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            // نفس لون الـ TextField وهو Focus
            color: isSelected
                ? const Color.fromARGB(128, 234, 248, 249)
                : Colors.white,

            borderRadius: BorderRadius.circular(14),

            border: Border.all(
              color: isSelected
                  ? AppColors.tealGray
                  : Colors.grey.shade300,
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                isSelected
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: isSelected
                    ? AppColors.tealGray
                    : Colors.black54,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w400,
                    color: Colors.black,
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