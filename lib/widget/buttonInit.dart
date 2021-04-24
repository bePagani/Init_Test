import 'package:flutter/material.dart';

class ButtonCus extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool loadingProgress;
  final bool outlineBtn;
  ButtonCus({this.text, this.onPressed,this.outlineBtn,this.loadingProgress});

  @override
  Widget build(BuildContext context) {

    bool _outlineBtn = outlineBtn ?? false;
    bool _loadingProgress = loadingProgress ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65.0,

        decoration:  BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black ,
          border: Border.all(
            color:  Colors.black,
            width: 2.0,
          ),
              borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 22.0,
          vertical: 8.0,

        ),
        child: Stack(
          children: [
            Visibility(
              visible: _loadingProgress ? false : true,

              child: Center(
                child: Text(
                  text ?? "Text",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: _outlineBtn ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: _loadingProgress,
              child: Center(
                child: SizedBox(
                    height: 30,
                    width: 30,

                    child: CircularProgressIndicator()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
