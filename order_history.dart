import 'package:flutter/material.dart';
import 'package:project/colors.dart';

/// =====================================================
/// ORDER STATUS ENUM & HELPERS
/// =====================================================
enum OrderStatus { done, active, canceled }

Color getStatusColor(OrderStatus status) {
  switch (status) {
    case OrderStatus.done:
      return Colors.black;
    case OrderStatus.active:
      return Colors.green;
    case OrderStatus.canceled:
      return Colors.red;
  }
}

String getStatusLabel(OrderStatus status) {
  switch (status) {
    case OrderStatus.done:
      return 'Done';
    case OrderStatus.active:
      return 'Active';
    case OrderStatus.canceled:
      return 'Canceled';
  }
}

/// =====================================================
/// ORDER MODEL
/// =====================================================
class OrderModel {
  final String productName;
  final String brandName;
  final double rating;
  final String orderId;
  final String date;
  final OrderStatus status;

  const OrderModel({
    required this.productName,
    required this.brandName,
    required this.rating,
    required this.orderId,
    required this.date,
    required this.status,
  });
}

/// =====================================================
/// DUMMY DATA
/// =====================================================
final List<OrderModel> dummyOrders = [
  const OrderModel(
    productName: 'T-shirt blah',
    brandName: 'Brand Name',
    rating: 4.0,
    orderId: '#AFca312455',
    date: '3/7/2025',
    status: OrderStatus.done,
  ),
  const OrderModel(
    productName: 'T-shirt blah',
    brandName: 'Brand Name',
    rating: 4.0,
    orderId: '#AFca312455',
    date: '3/7/2025',
    status: OrderStatus.active,
  ),
];

/// =====================================================
/// ORDER HISTORY SCREEN (SCAFFOLD)
/// =====================================================
class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // خلفية رمادية فاتحة جداً تبرز بياض الكارد
      appBar: AppBar(
        backgroundColor: AppColors.gradientTop,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 22),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Order history',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: AppColors.backgroundGradient
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final maxContentWidth = constraints.maxWidth > 700 ? 700.0 : constraints.maxWidth;
          
              return Center(
                child: SizedBox(
                  width: maxContentWidth,
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    itemCount: dummyOrders.length,
                    itemBuilder: (context, index) {
                      return OrderHistoryCard(order: dummyOrders[index]);
                    },
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

/// =====================================================
/// ORDER HISTORY CARD (CONTAINER)
/// =====================================================
class OrderHistoryCard extends StatelessWidget {
  final OrderModel order;

  const OrderHistoryCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24), // حواف دائرية واضحة كالموجودة في الصورة
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // مكان الصورة الشخصية أو المنتج (مقاس ثابت متناسق)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              width: 90,
              height: 90,
              color: const Color(0xFFE5E5E5), // خلفية رمادية مؤقتة للصورة
              child: Image.asset(
                'images/Tshirt.png', // ضع مسار صورتك هنا
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, color: Colors.grey, size: 30);
                },
              ),
            ),
          ),
          const SizedBox(width: 14),
          
          // تفاصيل الطلب داخل الـ Container
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  order.brandName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      order.rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 14,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  order.orderId,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 6),
                
                // السطر السفلي الخاص بالتاريخ وحالة الحجز
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.date,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    Flexible(
                      child: RichText(
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                          ),
                          children: [
                            const TextSpan(text: 'status of Booking: '),
                            TextSpan(
                              text: getStatusLabel(order.status),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: getStatusColor(order.status),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}