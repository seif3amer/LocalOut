import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      Column(
        children: [
          SizedBox(height: 81,),
          Center(
            child: Image.asset("images/change_password.png", width: 343, height: 229,),
          ),
          SizedBox(height: 32,),
          Text("Successfully Changed",style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),),
          SizedBox(height: 8,),
          Text("Try log-in to your account again", style: TextStyle(fontSize: 16, color: Color(0xFFCCCCCC), fontWeight: FontWeight.w500),),
          SizedBox(height: 32,),
          Center(child: ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0BA3AC), minimumSize: Size(343, 44),),
            child: Text("Return to log in", style: TextStyle(color: Colors.white),))),
         
        ],
      ),
      
    );
  }
}
