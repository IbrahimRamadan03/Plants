import 'package:flutter/material.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;
  final String imageUrl; 
  CartItemWidget({this.id,this.title,this.price,this.quantity,this.imageUrl});
  Widget _buttonBuilder(IconData sign,BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: GestureDetector(
          onTap: (){
            if(sign==Icons.add_circle_outlined){
    
              Provider.of<Cart>(context,listen:false ).addItem(id, price, title, imageUrl);
            }
            if(sign==Icons.remove_circle_outlined)
            {
              Provider.of<Cart>(context,listen:false ).removeSingelItem(id);
            }
          },
          child: Icon(
            sign,
            color: Colors.black,
            size: 30,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction){
    Provider.of<Cart>(context,listen:false).deletedItem(id);
      },
      child: Container(
        width:MediaQuery.of(context).size.width*0.9 ,
        padding:EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        imageUrl))),
            ),
            Container(
              margin: EdgeInsets.only(left: 15),
              child: Column(
             
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                      SizedBox(height:70,),
                      Text(price.toString()),
                           Row(
                             
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      if(Provider.of<Cart>(context,listen:false).items[id].quantity>1)
                      _buttonBuilder(Icons.remove_circle_outlined,context),
                      Text(
                        quantity.toString(),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      _buttonBuilder(Icons.add_circle_outlined,context),
                    ],
                  )
    
                ],
              ),
            ),
            Spacer(),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                
                  SizedBox(
                    height: 18,
                  ),
             
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
