import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/LoginPage.dart';
import 'package:flutter_app/widget/buttonInit.dart';
import 'package:flutter_app/widget/inputField.dart';

import 'constans.dart';
class registrationPage extends StatefulWidget {
  @override
  _registrationPageState createState() => _registrationPageState();
}

class _registrationPageState extends State<registrationPage> {


  Future<String> _createAccount()async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _registerEmail, password: _registerPass);
      return null;
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;

    }catch(e){
      return e.toString();
    }
  }


  void _submitForm() async{
    setState(() {
      _registerLoadin = true;
    });

    String _createAccFeedBack= await _createAccount();
    if(_createAccFeedBack !=null){
      _alertDialogBuilder(_createAccFeedBack);
      setState(() {
        _registerLoadin = true;
      });
    }else{
      Navigator.pop(context);
    }

  }


  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context)
    {
      return AlertDialog(
        title: Text("Error"),
        content: Container(
          child: Text(error),
        ),
        actions: [
          FlatButton(
            child: Text("Close"),
            onPressed: (){
              Navigator.pop(context);
            },
          )
        ],
        
      );
    }
    );
  }
  bool _registerLoadin = false;
  String _registerEmail= "";
  String _registerPass="";

  FocusNode _passwordFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    _passwordFocusNode= FocusNode();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 26.0
                ),
                child: Text("Test Work init inc. \n Create your account",
                  textAlign: TextAlign.center,
                  style: Constans.boldHeading,),
              ),
              Column(
                children: [
                  InputField(
                    hintText: "Email ",
                    onChanged: (value){
                      _registerEmail = value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  InputField(
                    hintText: "Password",
                    onChanged: (value){
                      _registerPass=value;
                    },
                    focusNode: _passwordFocusNode,
                    passwordField: true,
                     onSubmitted: (value){
                      _submitForm();
                     },
                  ),
                  ButtonCus(
                      text: "Create Account",
                      outlineBtn: false,
                      onPressed:(){
                        _submitForm();
                      },
                      loadingProgress: _registerLoadin,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 16.0
                ),
                child: ButtonCus(
                    outlineBtn: true,
                    text: "Already have an account?",
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage())
                      );
                    }

                ),
              )
            ],

          ),

        ),
      ),
    );
  }
}
