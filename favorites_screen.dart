import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientTop,
        elevation: 0,
        leading: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.black,
        ),
        // تعديل محاذاة العنوان ليكون في المنتصف تماماً بدون تشفير البادينج
        centerTitle: true, 
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 22, 
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16), // مسافة بسيطة تحت الـ AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  height: 140,

                  // جعل البادينج الداخلي متساوي من كل الجهات لتوسط العناصر عمودياً
                  padding: const EdgeInsets.all(14), 
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // 🔥 لتوسيط الصورة والبيانات والقلب عمودياً في النص
                    children: [
                      // صورة المنتج
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "images/Tshirt.png",
                          width: 85, // تكبير بسيط لتتناسب مع الصورة المرفقة
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      const SizedBox(width: 14),
                      
                      // البيانات (العنوان، البراند، التقييم)
                      Expanded( // 🔥 استخدام Expanded هنا بيضمن إن العمود ياخد مساحته ويسمح للـ Spacer يشتغل صح
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // 🔥 لتوسيط النصوص عمودياً
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "T-shirt blah",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Brand Name",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: const [
                                Text(
                                  "4.0",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // الجزء الأيمن (القلب فوق واللوجو تحت)
                      SizedBox(
                        height: double.infinity, // نخليه ياخد الارتفاع كامل عشان الـ Spacer يشتغل
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 🔥 يرمي القلب فوق واللوجو تحت بالظبط
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // زر القلب الخلفية الوردية
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 2, 2, 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Color.fromRGBO(206, 20, 20, 1),
                                size: 22,
                              ),
                            ),
                            SizedBox(height: 32,),
                            
                            // لوجو البراند (FILA)
                            Image.asset(
                              "images/fila-9 1.png",
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16,),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: double.infinity,
                  height: 140,

                  // جعل البادينج الداخلي متساوي من كل الجهات لتوسط العناصر عمودياً
                  padding: const EdgeInsets.all(14), 
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center, // 🔥 لتوسيط الصورة والبيانات والقلب عمودياً في النص
                    children: [
                      // صورة المنتج
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          "images/Tshirt.png",
                          width: 85, // تكبير بسيط لتتناسب مع الصورة المرفقة
                          height: 85,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      const SizedBox(width: 14),
                      
                      // البيانات (العنوان، البراند، التقييم)
                      Expanded( // 🔥 استخدام Expanded هنا بيضمن إن العمود ياخد مساحته ويسمح للـ Spacer يشتغل صح
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center, // 🔥 لتوسيط النصوص عمودياً
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "T-shirt blah",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              "Brand Name",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: const [
                                Text(
                                  "4.0",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // الجزء الأيمن (القلب فوق واللوجو تحت)
                      SizedBox(
                        height: double.infinity, // نخليه ياخد الارتفاع كامل عشان الـ Spacer يشتغل
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 🔥 يرمي القلب فوق واللوجو تحت بالظبط
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            // زر القلب الخلفية الوردية
                            Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: Color.fromRGBO(255, 2, 2, 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.favorite,
                                color: Color.fromRGBO(206, 20, 20, 1),
                                size: 22,
                              ),
                            ),
                            SizedBox(height: 32,),
                            
                            // لوجو البراند (FILA)
                            Image.asset(
                              "images/fila-9 1.png",
                              width: 40,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                    ],
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