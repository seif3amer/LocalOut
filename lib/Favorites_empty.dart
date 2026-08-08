import 'package:flutter/material.dart';
import 'package:project/colors.dart';



class FavoritesEmpty extends StatelessWidget {
  const FavoritesEmpty({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:AppColors.background ,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            
          },
        ),
        title: Center(
          child: Padding(
            padding: EdgeInsetsGeometry.only(right: 30),
            child: Text('Favorites', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22, letterSpacing: 0),),
          ),
        ),
      ),
      body:  Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          
          color: AppColors.background,
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:  269,),
                    Image.asset('images/favourite_empty.png', width: 107.33, height: 105.75,),
                    SizedBox(height: 26),
                    Text('No favorite yet?!', style : TextStyle(color: Color(0xFF9E9C9C), fontWeight: FontWeight.w500, fontSize: 16, letterSpacing: 0),),
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("Save items you love to find them faster later.", style : TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 0,),maxLines: 1,),
                    ),
                    SizedBox(height: 24,),
                    TextButton(
                      onPressed: () {
                        // Handle button press
                      },
                      child: Text(
                        'Browse Products',
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
      ),
      
      
    );
  }
}