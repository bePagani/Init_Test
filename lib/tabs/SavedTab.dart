import 'package:flutter/material.dart';
import 'package:flutter_app/widget/customActionBar.dart';

class SavedTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Stack(
        children: [
          Center(
            child: Text("Saved"),
          ),
          CustomActionBar(
            title: "Saved",
            Arrows: false,

          ),
        ],
      ),
    );
  }
}
