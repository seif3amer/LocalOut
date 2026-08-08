import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  int selected_item = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
       backgroundColor: Colors.black,

        onTap: (val){
          setState(() {
            selected_item = val ;
          });
        },
        iconSize: 30,
        currentIndex: selected_item,
        selectedLabelStyle: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
      
        items: [
        BottomNavigationBarItem(icon: SvgPicture.asset('icons/solar_heart-outline.svg'),label: 'home'),
        BottomNavigationBarItem(icon: SvgPicture.asset('icons/search.svg'),label: 'home'),
        BottomNavigationBarItem(icon: SvgPicture.asset('icons/hugeicons_home-05.svg'),label: 'home'),
        BottomNavigationBarItem(icon: SvgPicture.asset('icons/fluent_person-28-regular.svg'), label: 'home'),
        BottomNavigationBarItem(icon: SvgPicture.asset('icons/Bag.svg'),label: 'home'),
      ]),
      body: Column(
        children: [
          SizedBox(height: 90,),
          Text("this is test page"),
          
          

        ],
      ),
    );
  }
}