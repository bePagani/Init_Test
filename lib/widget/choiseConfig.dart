import 'package:flutter/material.dart';

class ChoiseConfig extends StatefulWidget {

final List configs;
final int prices;
final Function(String) onSelected;

ChoiseConfig({this.configs, this.onSelected,this.prices});
  @override
  _ChoiseConfigState createState() => _ChoiseConfigState();
}

class _ChoiseConfigState extends State<ChoiseConfig> {
int _selected = 0;
int _prices = 0;
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(
        left: 15
      ),
      child: Row(

        children: [
          for(int i =0;i<widget.configs.length;++i)
            GestureDetector(
              onTap: (){
                widget.onSelected("${widget.configs[i]}");
                setState(() {
                  _selected =i;
                });
              },
              child: Container(

                width:100,
                height: 50,
                decoration: BoxDecoration(
                  color: _selected == i ? Theme.of(context).accentColor: Colors.grey,
                  borderRadius: BorderRadius.circular(12)
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(
                  horizontal: 4
                ),
                child: Text('${widget.configs[i]}',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: _selected == i ? Colors.white:Colors.black,
                  fontSize: 13
                ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
