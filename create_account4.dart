import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/create_account6.dart';

class CreateAccount4 extends StatefulWidget {
  const CreateAccount4({super.key});
 

  @override
  State<CreateAccount4> createState() => _CreateAccount4State();
}

class _CreateAccount4State extends State<CreateAccount4> {
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.gradientTop,
        title:  Center(
          child: Text('What’s your gender?', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: AppColors.backgroundGradient
        ),
        child: SingleChildScrollView(
          child: Column(
          children: [
            SizedBox(height: 32,),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                color: Color(0xFF635CA8),
                width: double.infinity,
                height: 79,
                child: Center(
                  child: Text("This helps us personalize your fashion\n \t \t \t \t \t \t \t \t recommendations", style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),),
                ),
              ),
            ),
            SizedBox(height: 32,),
            IconButton(onPressed: (){
              setState((){
                selectedGender = 'male';
              }); 
            }, 
            icon: Container(
              width: 160,
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              color:
                selectedGender == 'male'
                ? const Color(0xFF635CA8)
                : const Color.fromARGB(255, 202, 200, 200), 
              shape: BoxShape.circle,
            ), child: Icon(Icons.male, size: 60, color: const Color.fromARGB(255, 255, 254, 254),))),
            SizedBox(height: 8,),
            Text("Male", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
        
            SizedBox(height: 16,),
        
            IconButton(onPressed: (){
              setState((){
                selectedGender = 'female';
              }); 
            }, 
            icon: Container(
              width: 160,
              height: 160,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              color:
                selectedGender == 'female'
                ? const Color(0xFF635CA8)
                : const Color.fromARGB(255, 202, 200, 200), 
              shape: BoxShape.circle,
            ), child: Icon(Icons.female, size: 60, color: const Color.fromARGB(255, 255, 254, 254),))),
            SizedBox(height: 8,),
            Text("Female", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w700),),
        
            SizedBox(height: 32,),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    border: Border.all(
                      color: Color(0xFF0BA3AC),
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
        
                SizedBox(width: 5,),
        
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 5,),
        
        
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
        
                SizedBox(width: 5,),
        
        
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
        
                SizedBox(width: 5,),
        
        
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
        
              ]
            ),
        
            SizedBox(height: 32,),
        
        
            SizedBox(
                      width: 320,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0BA3AC),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        onPressed:selectedGender == null
                          ? null
                          :(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => CreateAccount6()),
                            );
        
                           },
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Inter",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
          ],
        ),
        ),
      )
    );
  }
}