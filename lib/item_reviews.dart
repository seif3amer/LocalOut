// import 'package:flutter/material.dart';
// import 'package:project/colors.dart';

// class ItemReviews extends StatefulWidget {
//   const ItemReviews({super.key});

//   @override
//   State<ItemReviews> createState() => _ItemReviewsState();
// }

// class _ItemReviewsState extends State<ItemReviews> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: AppColors.background,
//         leading: IconButton(
//           onPressed: () {},
//           icon: const Icon(Icons.arrow_back_ios),
//         ),
//         title: const Center(
//           child: Text(
//             "Reviews",
//             style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: double.infinity,
//           decoration: BoxDecoration(color: AppColors.background),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 32),
//                 Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "500 Reviews",
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           "4.0",
//                           style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                         ),
//                         const SizedBox(width: 3.5),
//                         const Icon(
//                           Icons.star,
//                           color: Colors.yellow,
//                           size: 13,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//                 // استدعاء ميثود الكارد هنا
//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),
//                 const SizedBox(height: 16,),

//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),
//                 const SizedBox(height: 16,),

//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),
//                 const SizedBox(height: 16,),


//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),
//                 const SizedBox(height: 16,),


//                 Padding(
//                   padding: const EdgeInsets.only(left: 16, right: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),

//                 const SizedBox(height: 16,),

//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),
//                 const SizedBox(height: 16,),

//                 Padding(
//                   padding: const EdgeInsets.only(right: 16, left: 16),
//                   child: _buildReviewCard(
//                     image: "images/seif.jpg",
//                     name: "Ronald Richard",
//                     date: "13 Sep, 2020",
//                     rating: "4.0",
//                     reviewText: "Lorem ipsum dolor sit amet, consectetur",
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // ميثود بناء كارد المراجعة بشكل متناسق ومطابق للصورة
//   Widget _buildReviewCard({
//     required String image,
//     required String name,
//     required String date,
//     required String rating,
//     required String reviewText,
//   }) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // 1. الصورة الشخصية
//               CircleAvatar(
//                 radius: 26,
//                 backgroundColor: const Color(0xFFF1F3F4),
//                 backgroundImage: AssetImage(image),
//               ),
//               const SizedBox(width: 14),

//               // 2. العمود الأوسط (الاسم، التاريخ، وتحتهم نص المراجعة)
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       name,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF222222),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.access_time_rounded,
//                           size: 13,
//                           color: Color(0xFF9E9E9E),
//                         ),
//                         const SizedBox(width: 4),
//                         Text(
//                           date,
//                           style: const TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFF9E9E9E),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     // نص المراجعة محاذي تماماً للاسم وتحته
//                     Text(
//                       reviewText,
//                       softWrap: true,
//                       style: const TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xFF8F959E),
//                         height: 1.4,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 12),

//               // 3. الجزء الأيمن (التقييم الرقمي والنجوم)
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   RichText(
//                     text: TextSpan(
//                       text: rating,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xFF222222),
//                       ),
//                       children: const [
//                         TextSpan(
//                           text: " rating",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w400,
//                             color: Color(0xFFA0A0A0),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   // رسم النجوم الأربعة بناءً على التقييم 4.0
//                   Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: List.generate(4, (index) {
//                       return const Padding(
//                         padding: EdgeInsets.only(left: 2),
//                         child: Icon(
//                           Icons.star,
//                           size: 13,
//                           color: Colors.yellow,
//                         ),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
// افترضت أن AppColors معرفة هنا أو قم باستبدالها بالألوان المباشرة
// import 'package:project/colors.dart'; 

class AppColors {
  static const Color background = Color(0xFFFBFBFD); // مثال للون خلفية فاتح
}

class ItemReviews extends StatefulWidget {
  const ItemReviews({super.key});

  @override
  State<ItemReviews> createState() => _ItemReviewsState();
}

class _ItemReviewsState extends State<ItemReviews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0, // إلغاء الظل ليكون شكل الـ AppBar أنظف
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,), // لون السهم أسود
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: AppColors.background),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                // جزء إحصائيات التقييم (تم تحسين تنسيقه أيضاً)
                Column(
                  children: [
                    const Text(
                      "500 Reviews",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1D1E20)),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "4.0",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1D1E20)),
                        ),
                        const SizedBox(width: 6),
                        Row(
                          children: List.generate(5, (index) {
                            return const Icon(
                              Icons.star,
                              color: Color(0xFFFFC107), // لون نجمة ذهبي أفضل
                              size: 16,
                            );
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // استدعاء ميثود الكارد هنا
                
                // تم استخدام ListView.separated بدلاً من تكرار الـ Padding يدوياً ليكون الكود أنظف وأكثر كفاءة
                ListView.separated(
                  shrinkWrap: true, // مهم داخل SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(), // لتدع الـ Scroll للـ SingleChildScrollView
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 7, // عدد المراجعات
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return _buildReviewCard(
                      // image: "images/seif.jpg", // استبدلها بصورة حقيقية عندك
                      name: "Ronald Richard",
                      date: "13 Sep, 2020",
                      rating: 4, // نمرر الرقم int
                      reviewText: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque pellentesque tempor nisl.",
                    );
                  },
                ),
                const SizedBox(height: 16,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ميثود بناء كارد المراجعة - تم التعديل لتكون العناصر تحت بعضها
  Widget _buildReviewCard({
    String? image, // جعلناها اختياري لتجربة الكود بدون ملف صورة
    required String name,
    required String date,
    required int rating, // تغيير النوع إلى int لسهولة رسم النجوم
    required String reviewText,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15), // حواف دائرية للكارد
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الجزء العلوي (الصورة، الاسم، التقييم)
          Row(
            children: [
              // الصورة الشخصية
              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xFFF5F6FA),
                // backgroundImage: image != null ? AssetImage(image) : null, 
                child: image == null ? const Icon(Icons.person, color: Colors.grey,) : null,
              ),
              const SizedBox(width: 12),
              
              // العمود الخاص بالاسم والتقييم
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D1E20),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // النجوم تحت الاسم
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          Icons.star,
                          size: 14,
                          color: index < rating ? const Color(0xFFFFC107) : const Color(0xFFE0E0E0),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              
              // التاريخ على اليمين (اختياري، يمكن وضعه تحت التقييم أيضاً)
              Text(
                date,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF8F959E),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // 2. نص المراجعة (تحت الجزء العلوي بالكامل ومحاذي لليسار)
          Padding(
            padding: const EdgeInsets.only(left: 0), // محاذاة من بداية الكارد
            child: Text(
              reviewText,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8F959E),
                height: 1.5, // مسافة بين الأسطر لراحة العين
              ),
            ),
          ),
        ],
      ),
    );
  }
}