import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/constans.dart';
import 'package:flutter_app/widget/choiseConfig.dart';
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
  final CollectionReference _users= FirebaseFirestore.instance.collection("Users");

  User _user = FirebaseAuth.instance.currentUser;
  String _selectedConfig = "0";
  String _price = "o";


  final SnackBar _snackBar = SnackBar(content: Text("Добавлено в корзину"));
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
             List configs = docData['size'];
             int price = docData['price'];
             _selectedConfig = configs[0];

             Future _setCart(){
                _users.doc(_user.uid).
               collection("Cart").
               doc(widget.productId).
               set({
                 "Config" : _selectedConfig,
                 'price':docData['price'],
               }
               );
             }

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
                     fontWeight: FontWeight.w600,
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
                   child: Text('Выберите конфиг',
                     style: Constans.regularDartText,
                   ),
                 ),
                ChoiseConfig(
                  configs:
                    configs,
                  onSelected: (size){
                    _selectedConfig = size;
                  },


                ),
                 Padding(
                   padding: const EdgeInsets.symmetric(vertical: 12,
                   horizontal: 12),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Container(
                         width: 65,
                         height: 65,
                         decoration: BoxDecoration(
                           color: Colors.grey,
                           borderRadius: BorderRadius.circular(12),
                         ),
                         alignment: Alignment.center,
                         child: Image(
                           image: AssetImage(
                             "assets/images/cartIcon.png"
                           ),
                           width: 26,
                         ),
                       ),
                       Expanded(
                         child: GestureDetector(
                           onTap: ()async{
                            await _setCart();
                            Scaffold.of(context).showSnackBar(_snackBar);
                           },
                           child: Container(
                             height: 65,
                             margin: EdgeInsets.only(
                               left: 16
                             ),
                             decoration: BoxDecoration(
                               color: Colors.black,
                               borderRadius: BorderRadius.circular(12)
                             ),
                             alignment: Alignment.center,
                             child: Text("Добавить в корзину",
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 16,
                               fontWeight: FontWeight.w600
                             )
                             ,),
                           ),
                         ),
                       )
                     ],
                   ),
                 )
               ],
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
          Arrows: true,
            wastitle: false,
            wasBackg: false,
        ),
        ],

      ),
    );
  }
}
