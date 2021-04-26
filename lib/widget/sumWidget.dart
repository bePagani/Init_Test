import 'package:flutter/material.dart';

class SumWidget extends StatefulWidget {
  @override
  _SumWidgetState createState() => _SumWidgetState();
}

class _SumWidgetState extends State<SumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topRight: Radius.circular(12),
        topLeft: Radius.circular(12)

        ),

      ),
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          RaisedButton(color: Colors.black,
              onPressed: (){


          })
        ],
      ),
    );
  }
}
