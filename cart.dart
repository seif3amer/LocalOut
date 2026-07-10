import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/custom_bottom_nav.dart';
import 'cart_item.dart';
import 'package:project/top_dashed_painter.dart';
class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            //color: Colors.black,
            
          ),
        ),
        title: const Text(
          "Cart",
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [

            /// المنتجات — white rounded cards, spaced apart
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                itemCount: 2,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const CartItem(
                      image: "images/Tshirt.png",
                      name: "Men's Tie-Dye T-Shirt",
                      brand: "Nike Sportswear",
                      price: 450,
                      size: "L",
                      sizeIsBadge: false,
                      trashColor: Colors.grey,
                    );
                  }
                  return const CartItem(
                    image: "images/Tshirt.png",
                    name: "Men's Tie-Dye T-Shirt",
                    brand: "Nike Sportswear",
                    price: 250,
                    size: "XL",
                    sizeIsBadge: true,
                    trashColor: Colors.red,
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            

            const SizedBox(height: 16),

            /// Order Info
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text(
                            'Order Info',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

          const SizedBox(height: 10),

          buildRow("Subtotal", "L.E 700"),

          const SizedBox(height: 15),

          buildRow("Shipping cost", "L.E 100"),

          const SizedBox(height: 20),

          

          const SizedBox(height: 20),

          buildRow(
            "Total Cost",
            "L.E 800",
            isBold: true,
          ),
        ],
      ),
    ),

    Positioned.fill(
      child: IgnorePointer(
        child: CustomPaint(
          painter: TopDashedPainter(
            color: AppColors.gray,
            radius: 25,
            strokeWidth: 1.5,
          ),
        ),
      ),
    ),
  ],
),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 60,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.tealGray,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                ),

                onPressed: () {},

                child: const Text(
                  "Check-Out",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
    currentIndex: 0,
    onTap: (index) {
      if (index == 0) {
        Navigator.pushNamed(context, '/favorites');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/search');
      } else if (index == 2) {
        Navigator.pushNamed(context, '/home');
      } else if (index == 3) {
        Navigator.pushNamed(context, '/profile');
      } else if (index == 4) {
        Navigator.pushNamed(context, '/cart');
      }
    },
  ),
    );
  }

  Widget buildRow(
    String title,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      children: [

        Text(
          title,
          style: TextStyle(
            fontSize: isBold ? 22 : 18,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? Colors.black : Colors.grey,
          ),
        ),

        const Spacer(),

        Text(
          value,
          style: TextStyle(
            fontSize: isBold ? 22 : 18,
            fontWeight:
                isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
      
    );
  }
}

