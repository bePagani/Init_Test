import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/tabs/SavedTab.dart';
import 'package:flutter_app/tabs/homeTab.dart';
import 'package:flutter_app/tabs/searchTab.dart';
import 'package:flutter_app/widget/bottomTabs.dart';

class HomePage extends StatefulWidget {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _selectedTab =0;

  @override
  void initState() {
    // TODO: implement initState
    _pageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
         Container(
           child: Expanded(
             child: PageView(
               controller: _pageController,
               onPageChanged: (num){
                 setState(() {
                   _selectedTab=num;
                 });
               },
               children: [
                 HomeTab(),
                 SearchTab(),
                 SavedTab(),


                 Container(
                   child: Center(
                     child: Text("Search"),
                   ),
                 ),
                 Container(
                   child: Center(
                     child: Text("Cart"),
                   ),
                 ),
               ],
             ),
           ),

         ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num){
              setState(() {
                _pageController.animateToPage(num, duration: Duration(milliseconds: 200), curve: Curves.easeOutCubic);
              });
            },
          ),
        ],
      )
      );
  }
}
