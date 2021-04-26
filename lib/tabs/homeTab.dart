import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/ProductPage.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/widget/customActionBar.dart';
import 'package:flutter_app/widget/product_card.dart';

class HomeTab extends StatelessWidget {

  final CollectionReference _products = FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(

      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _products.get(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Scaffold(
                  body: Center(
                    child: Text("Ошибка ${snapshot.error}"),
                  ),
                );
              }
              if(snapshot.connectionState == ConnectionState.done){
                return ListView(

                  padding: EdgeInsets.only(top: 66,
                  bottom:32
                  ),
                  children: snapshot.data.docs.map((document){
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "\Т${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          CustomActionBar(
            title: "Home",
            Arrows: false,

          ),
        ],
      ),
    );
  }
}
