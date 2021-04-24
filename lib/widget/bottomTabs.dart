import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 30,

          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomTabButton(
            iconSeting: "assets/images/homeIcon.png",
          ),
          BottomTabButton(
            iconSeting: "assets/images/searchicon.png",
          ),
          BottomTabButton(
            iconSeting: "assets/images/cartIcon.png",
          ),
          BottomTabButton(
            iconSeting: "assets/images/logoutIcon.png",
          ),

        ],
      ),
    );
  }
}
class BottomTabButton extends StatelessWidget {
  final String iconSeting;
  BottomTabButton({this.iconSeting,});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 28,
        horizontal: 16,
      ),
      child: Image(
        image: AssetImage(
          iconSeting ?? "assets/images/homeIcon.png"
        ),
        width: 25,
        height: 25,
      )
    );
  }
}



/* BottomTabButton
Image(
        image: AssetImage(
          "assets/images/homeIcon.png"
        ),
 */