import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/firebase_services.dart';
import 'package:flutter_app/widget/inputField.dart';

class OrderPage extends StatefulWidget {
  final String info;
  OrderPage({this.info});
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    User _user = FirebaseAuth.instance.currentUser;
    final CollectionReference _users = FirebaseFirestore.instance.collection("Users");
    final CollectionReference orderSet = FirebaseFirestore.instance.collection("Cart");
    Future <void> setCart(){
      return _users.doc(_user.uid).collection('Cart').doc(widget.info).get();
    }
    return Container(
      child: InputField(
        hintText: "Адрес доставки",
      ),
    );
  }
}