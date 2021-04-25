import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {

  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab, this.tabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedbtn = 0;
@override


  @override
  Widget build(BuildContext context) {
  _selectedbtn = widget.selectedTab?? 0;
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
            selected: _selectedbtn == 0 ? true:false,
            onPressed: (){
              widget.tabPressed(0);
            },
          ),
          BottomTabButton(
            iconSeting: "assets/images/searchicon.png",
            selected:  _selectedbtn == 1  ? true:false,
            onPressed: (){
              widget.tabPressed(1);
            },
          ),
          BottomTabButton(
            iconSeting: "assets/images/cartIcon.png",
            selected: _selectedbtn ==2  ? true:false,
            onPressed: (){
              widget.tabPressed(2);
            },
          ),
          BottomTabButton(
            iconSeting: "assets/images/logoutIcon.png",
            selected: _selectedbtn ==3  ? true:false,
            onPressed: (){

            },
          ),

        ],
      ),
    );
  }
}
class BottomTabButton extends StatelessWidget {
  final String iconSeting;
  final bool selected;
  final Function onPressed;
  BottomTabButton({this.iconSeting,this.selected, this.onPressed});
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(

        padding: EdgeInsets.symmetric(
          vertical: 28,
          horizontal: 24,
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: _selected ? Theme.of(context).accentColor: Colors.transparent,
              width: 2,

            )
          )
        ),
        child: Image(
          image: AssetImage(
            iconSeting ?? "assets/images/homeIcon.png"
          ),
          width: 25,
          height: 25,
          color: _selected? Theme.of(context).accentColor: Colors.black
          ,
        )
      ),
    );
  }
}



/* BottomTabButton
Image(
        image: AssetImage(
          "assets/images/homeIcon.png"
        ),
 */