import 'package:flutter/material.dart';
import 'package:project/colors.dart';


class EmptyNotification extends StatelessWidget {
  const EmptyNotification({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            
          },
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.only(right: 30),
            child: Text('Notification', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22, letterSpacing: 0),),
          ),
        ),
      ),
      body: Center(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.background
            ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 205),
                Image.asset('images/empty_notification.png', width: 107.33, height: 105.75,),
                SizedBox(height: 42),
                Text('No messages yet', style : TextStyle(color: Color(0xFF9E9C9C), fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0),),
                SizedBox(height: 8,),
                Text("You’ll see order updates and offers here.", style : TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}