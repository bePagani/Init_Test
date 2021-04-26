
import 'package:flutter/material.dart';
import 'package:flutter_app/Pages/ProductPage.dart';
import 'package:flutter_app/Pages/constans.dart';

class ProductCard extends StatelessWidget {
  final String productId;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
ProductCard({this.onPressed,this.title,this.imageUrl,this.price,this.productId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (contect)=> ProductPage(productId: productId,)
        )
        );
      },
      child: Container(
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
                    builder: (context) => ProductPage(productId: productId,)));
              },
              child: Container(

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network("$imageUrl",
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
                    Text(title,
                        style: Constans.regularHeading
                    ),
                    Text(price,
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
      ),
    );;
  }
}
