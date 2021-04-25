import 'package:flutter/material.dart';

class SwipeImage extends StatefulWidget {
  final List imageList;
  SwipeImage({this.imageList});
  @override
  _SwipeImageState createState() => _SwipeImageState();
}

class _SwipeImageState extends State<SwipeImage> {
  int _Page = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: Stack(
        children: [
          PageView(
            onPageChanged: (num){
              setState(() {
                _Page = num;
              });
            },
              children: [
          for(int i =0; i< widget.imageList.length; ++i)
          Container(child: Image.network(
    '${widget.imageList[i]}',
    ),
    )
    ],
    ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for(int i =0; i< widget.imageList.length; ++i)
                  AnimatedContainer(
                    duration: Duration(
                      milliseconds: 300
                    ),
                    curve: Curves.easeOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal:6
                    ),
                    width: _Page == i ? 17.6: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withOpacity(0.5)
                    ),
                  )
                ],
            ),
          )
        ],
      )
    );
  }

}

