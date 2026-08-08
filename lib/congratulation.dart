// // import 'package:flutter/material.dart';
// // import 'package:flutter_svg/flutter_svg.dart';

// // class Congratulation extends StatelessWidget {
// //   const Congratulation({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: SafeArea(
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
                
// //                 SizedBox(height: 209,),
// //                 // ===== CHECK ICON IN CIRCLE =====
// //                 SvgPicture.asset("icons/success-IXzuHjaasy.svg"),
            
// //                 const SizedBox(height: 36),
            
// //                 // ===== CONGRATULATION TITLE =====
// //                 const Text(
// //                   "Congratulations!",
// //                   style: TextStyle(
// //                     fontSize: 26,
// //                     fontFamily: "Kreon",
// //                     fontWeight: FontWeight.w700,
// //                     color: Colors.black,
// //                   ),
// //                 ),
            
// //                 const SizedBox(height: 14),
            
// //                 // ===== SUBTITLE =====
// //                 const Text(
// //                   "Your email has been\nverified successfully.",
// //                   textAlign: TextAlign.center,
// //                   style: TextStyle(
// //                     fontSize: 16,
// //                     fontFamily: "Inter",
// //                     fontWeight: FontWeight.w400,
// //                     color: Colors.grey,
// //                     height: 1.6,
// //                   ),
// //                 ),
            
// //                 const Spacer(),
            
// //                 // ===== CREATE YOUR ACCOUNT BUTTON =====
// //                 SizedBox(
// //                   width: 320,
// //                   height: 52,
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: const Color(0xFF0BA3AC),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(30),
// //                       ),
// //                       elevation: 0,
// //                     ),
// //                     onPressed: () {
// //                       // TODO: Navigator للـ SignUp screen
// //                       // Navigator.push(
// //                       //   context,
// //                       //   MaterialPageRoute(builder: (context) => const SignUp()),
// //                       // );
// //                     },
// //                     child: const Text(
// //                       "Create your account",
// //                       style: TextStyle(
// //                         fontSize: 16,
// //                         fontWeight: FontWeight.w600,
// //                         fontFamily: "Inter",
// //                         color: Colors.white,
// //                       ),
// //                     ),
// //                   ),
// //                 ),
            
// //                 const SizedBox(height: 48),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class Congratulation extends StatelessWidget {
//   const Congratulation({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(height: 40),

//               // ===== CHECK ICON IN CIRCLE =====
//               SvgPicture.asset("icons/success-IXzuHjaasy.svg"),

//               const SizedBox(height: 36),

//               // ===== CONGRATULATION TITLE =====
//               const Text(
//                 "Congratulations!",
//                 style: TextStyle(
//                   fontSize: 26,
//                   fontFamily: "Kreon",
//                   fontWeight: FontWeight.w700,
//                   color: Colors.black,
//                 ),
//               ),

//               const SizedBox(height: 14),

//               // ===== SUBTITLE =====
//               const Text(
//                 "Your email has been\nverified successfully.",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontFamily: "Inter",
//                   fontWeight: FontWeight.w400,
//                   color: Colors.grey,
//                   height: 1.6,
//                 ),
//               ),

//               const SizedBox(height: 60),

//               // ===== CREATE YOUR ACCOUNT BUTTON =====
//               SizedBox(
//                 width: 320,
//                 height: 52,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF0BA3AC),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                     elevation: 0,
//                   ),
//                   onPressed: () {
//                     // TODO: Navigator to SignUp screen
//                   },
//                   child: const Text(
//                     "Create your account",
//                     style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: "Inter",
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 48),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:project/colors.dart';

// class Congratulation extends StatefulWidget {
//   const Congratulation({super.key});

//   @override
//   State<Congratulation> createState() => _CongratulationState();
// }

// class _CongratulationState extends State<Congratulation> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: 209,),
//           SvgPicture.asset("icons/success-IXzuHjaasy.svg"),
//           SizedBox(height: 16,),
//           Text("Congratulation!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
//           Text("Your email has been verified successfully.", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
//           SizedBox(height: 63,),
//           SizedBox(
//                         width: 343,
//                         height: 44,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: AppColors.tealGray,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(30),
//                             ),
//                             elevation: 0,
//                           ),
//                           onPressed: () {},
//                           child: const Text(
//                             "Create your account",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                               fontFamily: "Inter",
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project/colors.dart';

class Congratulation extends StatefulWidget {
  const Congratulation({super.key});

  @override
  State<Congratulation> createState() => _CongratulationState();
}

class _CongratulationState extends State<Congratulation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Success Icon
                SvgPicture.asset("icons/success-IXzuHjaasy.svg"),
                const SizedBox(height: 32),
                
                // Title
                const Text(
                  "Congratulation!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Subtitle / Description
                const Text(
                  "Your email has been verified successfully.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38, // Muted gray color to match design
                  ),
                ),
                const SizedBox(height: 48),
                
                // Action Button
                SizedBox(
                  width: double.infinity, // Automatically fills up to padding constraints (similar to 343 width)
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.tealGray,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Create your account",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}