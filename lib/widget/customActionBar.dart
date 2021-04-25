import 'package:flutter/material.dart';
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
          top: 42,
      left: 24,
      right: 24,
      bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if(_arrows)
            Container(
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
          if(_wastitle)
            Text(
            title ?? "Bar",
            style: Constans.boldHeading,
          ),

          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(8)

            ),
            alignment: Alignment.center,
            child: Text(
              "0",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}