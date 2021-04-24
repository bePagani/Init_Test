import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/RegistrationPage.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/widget/buttonInit.dart';
import 'package:flutter_app/widget/inputField.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}
bool _loginLoading = false;
class _LoginPageState extends State<LoginPage> {
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

  Future<String> _LogintoAcc()async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginEmail, password: _loginPass);
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
      _loginLoadin  = true;
    });

    String _signInFeedBack= await _LogintoAcc();
    if(_signInFeedBack !=null){
      _alertDialogBuilder(_signInFeedBack);
      setState(() {
        _loginLoadin = true;
      });
    }

  }
  bool _loginLoadin = false;
  String _loginEmail= "";
  String _loginPass="";

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
            child: Text("Test Work init inc. \n Login your account",
            textAlign: TextAlign.center,
            style: Constans.boldHeading,),
          ),
                Column(
                  children: [
                    InputField(
                      hintText: "Email ",
                      onChanged: (value){
                        _loginEmail = value;
                      },
                      onSubmitted: (value){
                        _passwordFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    InputField(
                      hintText: "Password",
                      onChanged: (value){
                        _loginPass=value;
                      },
                      focusNode: _passwordFocusNode,
                      passwordField: true,
                      onSubmitted: (value){
                        _submitForm();
                      },
                    ),
                    ButtonCus(
                      text: "Login",
                      outlineBtn: false,
                      onPressed:(){
                        _submitForm();
                      },
                      loadingProgress: _loginLoading,
                    ),
                  ],

                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0
                  ),
                  child: ButtonCus(
                    outlineBtn: true,
                    text: "Create Account",
                    onPressed: (){
                      Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context) => registrationPage()
                      ),
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
