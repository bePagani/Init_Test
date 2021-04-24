import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/constans.dart';

class InputField extends StatelessWidget {
final String hintText;
final Function(String) onChanged;
final Function(String) onSubmitted;
final FocusNode focusNode;
final TextInputAction textInputAction;
final bool passwordField;
InputField({this.hintText, this.onChanged,this.onSubmitted, this.focusNode, this.textInputAction, this.passwordField});

  @override
  Widget build(BuildContext context) {
    bool _passwordField= passwordField?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0
      ) ,
      decoration: BoxDecoration(
          color: Color(0xFFF2F2F2),
          borderRadius: BorderRadius.circular(12.0)

      ),
      child: TextField(
        obscureText: _passwordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText ?? "Hint Text",
            contentPadding: EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0
            ),
        ),
        style: Constans.regularDartText,
      ),

    );
  }
}
