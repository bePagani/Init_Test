import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/widget/customActionBar.dart';
import 'package:flutter_app/widget/swipeImage.dart';
class ProductPage extends StatefulWidget {
  final String productId;
  ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _products = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
       FutureBuilder(future: _products.doc(widget.productId).get(),
         builder: (context, snapshot){
           if(snapshot.hasError){
             return Scaffold(
               body: Center(
                 child: Text("Ошибка ${snapshot.error}"),
               ),
             );
           }
           if(snapshot.connectionState == ConnectionState.done){
             Map<String, dynamic> docData = snapshot.data.data();
             List imageList = docData['images'];
             return ListView(
               padding: EdgeInsets.all(0),
               children: [
                SwipeImage(
                  imageList: imageList,
                ),
                 Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 4,
                     horizontal: 24

                   ),
                   child: Text('${docData['name']}',
                     style: Constans.boldHeading,
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 4,
                     horizontal: 24
                   ),
                   child: Text(
                     '\т${docData['price']}',
                   style: TextStyle(
                     fontSize: 18,
                     color: Theme.of(context).accentColor,
                     fontWeight: FontWeight.w600
                   ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 8,
                     horizontal: 24
                   ),
                   child: Text('${docData['description']}',
                     style:TextStyle(
                       fontSize: 18,
                     ),
                   ),
                 ),
                 Padding(
                   padding: const EdgeInsets.symmetric(
                     vertical: 30,
                     horizontal: 24
                   ),
                   child: Text('${docData['size']}',
                     style: Constans.regularDartText,
                   ),
                 ),
               ],
             );

           }
           return Scaffold(
             body: Center(
               child: CircularProgressIndicator(),
             ),
           );
         },

       ),        CustomActionBar(
          Arrows: true,
            wastitle: false,
            wasBackg: false,
        ),
        ],

      ),
    );
  }
}
