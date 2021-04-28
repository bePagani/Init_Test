import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/Cart.dart';
import 'package:flutter_app/Pages/constans.dart';

class CustomActionBar extends StatelessWidget {
final String title;
final bool Arrows;
final bool wastitle;
final bool wasBackg;
CustomActionBar({this.title,this.Arrows,this.wastitle,this.wasBackg});
  @override
  Widget build(BuildContext context) {
    bool _arrows= Arrows ?? false;
    bool _wastitle= wastitle ?? true;
    bool _wasBack=wasBackg ?? true;
    final CollectionReference _users= FirebaseFirestore.instance.collection("Users",);
    User _user = FirebaseAuth.instance.currentUser;
    return Container(
      decoration: BoxDecoration(
        gradient: _wasBack?LinearGradient(
          colors:[ Colors.white,
            Colors.white.withOpacity(0),
          ],
          begin: Alignment(0,0),
          end:Alignment(0,45)
        ):null
      ),
      padding: EdgeInsets.only(
          top: 50,
      left: 24,
      right: 24,
      bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_arrows)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                width: 36,
                height: 36,

                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)

                ),
                alignment: Alignment.center,
                child: Image(
                  image:AssetImage("assets/images/arrow.png",
                  ),
                  color: Colors.white,
                  width: 15,
                  height: 15,
                ),
              ),
            ),
          if(_wastitle)
            Text(
            title ?? "Bar",
            style: Constans.boldHeading,
          ),

          GestureDetector(
            onTap:() {
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>Cart(),));
    },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8)

              ),
              alignment: Alignment.center,
              child: StreamBuilder(
                stream: _users.doc(_user.uid).collection("Cart").snapshots(),
                builder: (context,snapshot){
                  int _totalItem = 0;
                  if(snapshot.connectionState == ConnectionState.active){
                    List _docs = snapshot.data.docs;
                    _totalItem = _docs.length;
                  }
                  return Text(
                    "$_totalItem" ?? "0",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  );
                },

              )
            ),
          )
        ],
      ),
    );
  }
}
