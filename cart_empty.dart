import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/custom_bottom_nav.dart';


class CartEmpty extends StatelessWidget {
  const CartEmpty({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.gradientTop,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            
          },
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.only(right: 30),
            child: Text('Cart', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22, letterSpacing: 0),),
          ),
        ),
      ),
      body:  Center(
        child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: AppColors.backgroundGradient
              ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 178,),
                  Image.asset('images/cart_empty.png', width: 107.33, height: 105.75,),
                  SizedBox(height: 16),
                  Text('Your cart is empty', style : TextStyle(color: Color(0xFF9E9C9C), fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0),),
                  SizedBox(height: 8,),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text("Looks like you haven’t added anything yet.", style : TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 0,),maxLines: 1,),
                  ),
                  SizedBox(height: 24,),
                  TextButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text(
                      'Explore Products',
                      style: TextStyle(
                        color: Color(0xFF0BA3AC),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
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
}