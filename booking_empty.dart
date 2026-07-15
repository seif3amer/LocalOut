import 'package:flutter/material.dart';
import 'package:project/colors.dart';


class BookingEmpty extends StatelessWidget {
  const BookingEmpty({super.key});
  

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
            child: Text('Booking', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22, letterSpacing: 0),),
          ),
        ),
      ),
      body: Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 195,),
                Image.asset('images/booking_empty.png', width: 107.33, height: 105.75,),
                SizedBox(height: 32),
                Text('No Booking Yet?!', style : TextStyle(color: Color(0xFF9E9C9C), fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0),),
                SizedBox(height: 8,),
                Text("Your past and upcoming orders will appear here.", style : TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 0),maxLines: 1,),
                SizedBox(height: 24,),
                TextButton(
                    onPressed: () {
                      // Handle button press
                    },
                    child: Text(
                      'Start Shopping',
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
    );
  }
}