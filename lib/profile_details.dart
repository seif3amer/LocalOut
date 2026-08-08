// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:project/colors.dart';

// import 'ediit_profile.dart';

// class ProfileDetailsPage extends StatefulWidget {
//   const ProfileDetailsPage({super.key});

//   @override
//   State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
// }

// class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
//   final _firstNameController = TextEditingController(text: 'Ahmed');
//   final _lastNameController = TextEditingController(text: 'Mohamed');
//   final _emailController = TextEditingController(text: 'Ahmed.30J@gmail.com');
//   final _phoneController = TextEditingController(text: '+20 01024836984');
//   final _ageController = TextEditingController(text: '31');
//   final _birthdayController = TextEditingController(text: '1/1/1994');

//   static const Color _fieldBg = Color(0xFFFFFFFF);
//   static const Color _labelColor = Color(0xFFAAAAAA);
//   static const Color _valueColor = Color(0xFF1A1A1A);
//   static const Color _borderColor = Color(0xFFD8D8D8);

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _emailController.dispose();
//     _phoneController.dispose();
//     _ageController.dispose();
//     _birthdayController.dispose();
//     super.dispose();
//   }

//   Widget _buildField({
//     required String label,
//     required TextEditingController controller,
//     TextAlign textAlign = TextAlign.start,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 12,
//             color: _labelColor,
//             fontWeight: FontWeight.w400,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Container(
//           width: double.infinity,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//           alignment:
//               textAlign == TextAlign.center
//                   ? Alignment.center
//                   : Alignment.centerLeft,
//           decoration: BoxDecoration(
//             color: _fieldBg,
//             borderRadius: BorderRadius.circular(30),
//             border: Border.all(color: _borderColor, width: 1),
//           ),
//           child: Text(
//             controller.text,
//             textAlign: textAlign,
//             style: const TextStyle(
//               fontSize: 15,
//               color: _valueColor,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.background,
//         elevation: 0,
//         centerTitle: true,
//         leading: Icon(Icons.arrow_back_ios),
//         title: Padding(
//           padding: const EdgeInsets.only(top: 8),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const Text(
//                 'Profile Details',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 18,
//                 ),
//               ),
//               const SizedBox(height: 2),
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const Text(
//                     'Edit Profile',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color.fromARGB(255, 0, 0, 0),
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => const EdiitProfile(),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: 24,
//                       height: 24,
//                       decoration: const BoxDecoration(
//                         color: AppColors.tealGray,
//                         shape: BoxShape.circle,
//                       ),
//                       child:SvgPicture.asset("icons/Frame 30.svg", height: 10,width: 10,) ,
//                       ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.background
//           ),
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               final maxContentWidth =
//                   constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
          
//               return SingleChildScrollView(
//                 child: Center(
//                   child: SizedBox(
//                     width: maxContentWidth,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 16,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           SizedBox(height: 26,),
//                           // First Name + Last Name
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildField(
//                                   label: 'First Name',
//                                   controller: _firstNameController,
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               Expanded(
//                                 child: _buildField(
//                                   label: 'Last Name',
//                                   controller: _lastNameController,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
          
//                           // Email
//                           _buildField(
//                             label: 'Email',
//                             controller: _emailController,
//                           ),
//                           const SizedBox(height: 16),
          
//                           // Phone Number
//                           _buildField(
//                             label: 'Phone Number',
//                             controller: _phoneController,
//                           ),
//                           const SizedBox(height: 16),
          
//                           // Age + Birthday
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: _buildField(
//                                   label: 'Age',
//                                   controller: _ageController,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: _buildField(
//                                   label: 'Birthday',
//                                   controller: _birthdayController,
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 32),
          
//                           // Quote Section
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(bottom: 8),
//                                 child: Image.asset(
//                                   'images/king.png',
//                                   width: 32,
//                                   height: 33,
//                                 ),
//                               ),
//                               const SizedBox(width: 4),
//                               Padding(
//                                 padding: const EdgeInsets.only(top: 8),
//                                 child: const Text(
//                                   'Once a wise king said:',
//                                   style: TextStyle(
//                                     fontSize: 13,
//                                     color: Colors.black54,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 12),
          
//                           // Quote lines — centered
//                           Center(
//                             child: Column(
//                               children: [
//                                 // Line 1
//                                 Text.rich(
//                                   TextSpan(
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black87,
//                                       fontStyle: FontStyle.italic,
//                                     ),
//                                     children: [
//                                       const TextSpan(text: '"You can\'t buy '),
//                                       TextSpan(
//                                         text: 'happiness',
//                                         style: TextStyle(
//                                           decoration:
//                                               TextDecoration.lineThrough,
//                                           decorationColor: const Color.fromARGB(255, 0, 0, 0),
//                                           decorationThickness: 2.2,
//                                           fontStyle: FontStyle.italic,
//                                           color: const Color.fromARGB(221, 224, 6, 6),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 // Line 2
//                                 const Text(
//                                   'But',
//                                   style: TextStyle(
//                                     fontSize: 14,
//                                     color: Colors.black87,
//                                     fontStyle: FontStyle.italic,
//                                   ),
//                                 ),
//                                 // Line 3
//                                 Text.rich(
//                                   TextSpan(
//                                     style: const TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.black87,
//                                       fontStyle: FontStyle.italic,
//                                     ),
//                                     children: [
//                                       const TextSpan(text: 'You can buy '),
//                                       WidgetSpan(
//                                         alignment:
//                                             PlaceholderAlignment.baseline,
//                                         baseline: TextBaseline.alphabetic,
//                                         child: GestureDetector(
//                                           onTap: () {
//                                             // TODO: handle cloth tap
//                                           },
//                                           child: TextButton(
//                                             onPressed: () {},
//                                             child: const Text(
//                                               "Cloth",
//                                               style: TextStyle(color: AppColors.tealGray),
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       const TextSpan(text: '"'),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project/colors.dart';

import 'ediit_profile.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  final _firstNameController = TextEditingController(text: 'Ahmed');
  final _lastNameController = TextEditingController(text: 'Mohamed');
  final _emailController = TextEditingController(text: 'Ahmed.30J@gmail.com');
  final _phoneController = TextEditingController(text: '+20 01024836984');
  final _ageController = TextEditingController(text: '31');
  final _birthdayController = TextEditingController(text: '1/1/1994');

  static const Color _fieldBg = Color(0xFFFFFFFF);
  static const Color _labelColor = Color(0xFFAAAAAA);
  static const Color _valueColor = Color(0xFF1A1A1A);
  static const Color _borderColor = Color(0xFFD8D8D8);

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: _labelColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          alignment:
              textAlign == TextAlign.center
                  ? Alignment.center
                  : Alignment.centerLeft,
          decoration: BoxDecoration(
            color: _fieldBg,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: _borderColor, width: 1),
          ),
          child: Text(
            controller.text,
            textAlign: textAlign,
            style: const TextStyle(
              fontSize: 15,
              color: _valueColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.arrow_back_ios),
        title: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Profile Details',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EdiitProfile(),
                        ),
                      );
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        color: AppColors.tealGray,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        "icons/Frame 30.svg",
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: AppColors.background),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxContentWidth =
                  constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;

              return SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: maxContentWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 26),
                          // First Name + Last Name
                          Row(
                            children: [
                              Expanded(
                                child: _buildField(
                                  label: 'First Name',
                                  controller: _firstNameController,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _buildField(
                                  label: 'Last Name',
                                  controller: _lastNameController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Email
                          _buildField(
                            label: 'Email',
                            controller: _emailController,
                          ),
                          const SizedBox(height: 16),

                          // Phone Number
                          _buildField(
                            label: 'Phone Number',
                            controller: _phoneController,
                          ),
                          const SizedBox(height: 16),

                          // Age + Birthday
                          Row(
                            children: [
                              Expanded(
                                child: _buildField(
                                  label: 'Age',
                                  controller: _ageController,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _buildField(
                                  label: 'Birthday',
                                  controller: _birthdayController,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 32),

                          // Quote Section
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Image.asset(
                                  'images/king.png',
                                  width: 32,
                                  height: 33,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  'Once a wise king said:',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Quote lines — centered
                          Center(
                            child: Column(
                              children: [
                                // Line 1
                                Text.rich(
                                  TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    children: [
                                      const TextSpan(text: '"You can\'t buy '),
                                      TextSpan(
                                        text: 'happiness',
                                        style: const TextStyle(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Color.fromARGB(
                                            255,
                                            0,
                                            0,
                                            0,
                                          ),
                                          decorationThickness: 2.2,
                                          fontStyle: FontStyle.italic,
                                          color: Color.fromARGB(221, 224, 6, 6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // Line 2
                                const Text(
                                  'But',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                // Line 3
                                Text.rich(
                                  TextSpan(
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.black87,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    children: [
                                      const TextSpan(text: 'You can buy '),
                                      TextSpan(
                                        text: 'cloth',
                                        style: const TextStyle(
                                          color: AppColors.tealGray,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            // TODO: handle cloth tap
                                          },
                                      ),
                                      const TextSpan(text: '"'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}