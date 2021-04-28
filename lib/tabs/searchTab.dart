import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/firebase_services.dart';
import 'package:flutter_app/widget/buttonInit.dart';
import 'package:flutter_app/widget/inputField.dart';
import 'package:flutter_app/widget/product_card.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String search = "";

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Stack(
        children: [
          if (search.isEmpty)
            Center(
              child: Container(
                child: Text(
                  "Результат поиска",
                  style: Constans.regularDartText,
                ),
              ),
            )
          else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.orderBy("search").startAt([search]).endAt(["$search\uf8ff"]).get(),
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

                  padding: EdgeInsets.only(top: 100,
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

          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: InputField(
              hintText:  "Поиск",
              onSubmitted: (value){
                if (value.isNotEmpty){
                  setState(() {
                    search = value.toLowerCase();
                  });
                }
              },
            ),
          ),
        ],

      )

    );
  }
}
