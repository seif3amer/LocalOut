import 'package:flutter/material.dart';
import 'package:project/colors.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:  Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Center(child: Text('Help Center', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600))),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(height: 62),
                
                const Text(
                  "Hello, Alex!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                
                const SizedBox(height: 3),
                
                const Text(
                  "What can i help you for today ?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    
                  ),
                  maxLines: 1,
                ),
                
                const SizedBox(height: 22),
                
                /// Search
                TextField(
                  cursorColor: AppColors.tealGray,
                  cursorWidth: 1.5,
                  decoration: InputDecoration(
                    
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 16,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade400,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      
                      borderSide: const BorderSide(
                        color: Colors.teal,
                        
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 19),
                
                const Text(
                  "You can search some keywords from your problem for\nfaster solution you might have.",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 0, 0),
                    height: 1.4,
                  ),
                ),
                
                const SizedBox(height: 22),
                
                const Text(
                  "Frequently Asked",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                
                const SizedBox(height: 12),
                
                faqCard(
                  title: "How to Share with Others Location of court?",
                  body:
                      "You can select the Court that you wish to share and in the court images you will see on right side the share button.",
                ),
                
                const SizedBox(height: 14),
                
                faqCard(
                  title: "How to go to shop ?",
                  body:
                      "From pressing on the profile icon on the Nav bar “The person icon” on home page then select shop or you can search what ever you want from the search bar ;)",
                ),
                
                
                SizedBox(height: 67),
                Center(
                  child: SizedBox(
                    width: 295,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff16A8B5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "Call us",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget faqCard({
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            body,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}