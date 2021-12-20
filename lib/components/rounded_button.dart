import 'package:flutter/material.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/constants.dart';
import 'package:provider/provider.dart';
class RoundedButton extends StatelessWidget {
 final String title;
 final String plantId;
 final String imageUrl;
 final double price;
 RoundedButton({this.title,this.plantId,this.imageUrl,this.price});
  @override
  Widget build(BuildContext context) {
    
     return InkWell(
      onTap:(){
        Provider.of<Cart>(context,listen:false).addItem(plantId, price, title, imageUrl);
      },
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:kPrimaryColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          'Add To Cart',
          style: kTitleStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}