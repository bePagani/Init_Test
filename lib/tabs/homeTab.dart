import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/ProductPage.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/widget/customActionBar.dart';

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
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                          ),
                      height: 350,
                      margin: EdgeInsets.symmetric(

                        vertical: 12,
                        horizontal: 24,
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => ProductPage(productId: document.id,)));
                            },
                            child: Container(
                              
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network("${document.data()['images'][0]}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(

                                children: [
                                  Text(document.data()['name']??
                                    " Product Name",
                                    style: Constans.regularHeading
                                  ),
                                  Text("\т${document.data()['price']}"??
                                    "Price",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Theme.of(context).accentColor,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),


                                ],
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              ),
                            ),
                          )
                        ],
                      ),
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
