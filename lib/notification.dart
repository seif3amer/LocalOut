import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class Notification_screen extends StatelessWidget {
  const Notification_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: Icon(Icons.arrow_back_ios_new, fontWeight: FontWeight.bold,),
        title: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Center(child: Text("Notification", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),)),
        ),
      ),
      body:Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 32,),
               Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Today",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF757575),
                        ),
                      ),
          
                      const SizedBox(height: 14),
          
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: "You got an ", style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(
                              text: "OFFER 15%",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextSpan(text: " from Fila", style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
          
                      const SizedBox(height: 7),
          
                      Text(
                        "9:01am",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                const Divider(
                  thickness: 1,
                  height: 1,
                  color: Color(0xFFE0E0E0),
                ),

                SizedBox(height: 24,),
          
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Yesterday",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF757575),
                        ),
                      ),
          
                      const SizedBox(height: 14),
          
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(text: "New Collections Add in Nike ", style: TextStyle(fontWeight: FontWeight.bold)),
                            
                          ],
                        ),
                      ),
          
                      const SizedBox(height: 7),
          
                      Text(
                        "9:01am",
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      )
    );
  }
}