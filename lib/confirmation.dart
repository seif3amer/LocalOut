import 'package:flutter/material.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    return Scaffold(
      backgroundColor: Colors.white, 
      body: SafeArea(
        child: SingleChildScrollView( 
          child: Container(
            constraints: BoxConstraints(
              minHeight: screenHeight - MediaQuery.of(context).padding.top, 
            ),
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                
                Image.asset(
                  'images/confirmation.png', 
                  width: screenWidth * 0.85,  
                  height: screenHeight * 0.30,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: screenHeight * 0.03), 

                
                Text(
                  "Reservation Confirmed!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.075, 
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: screenHeight * 0.015),

               
                Text(
                  "Your order has been confirmed, we will send you confirmation email shortly.",
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: screenWidth * 0.038, 
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF8F959E),
                    height: 1.4,
                  ),
                ),

                SizedBox(height: screenHeight * 0.06),

                SizedBox(
                  width: screenWidth * 0.80, 
                  height: 54, 
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0BA3AC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      
                    },
                    child: Text(
                      "Go to Home",
                      style: TextStyle(
                        fontSize: screenWidth * 0.042, 
                        fontWeight: FontWeight.w600,
                        fontFamily: "Inter",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}