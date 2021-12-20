import 'package:flutter/material.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:provider/provider.dart';

class Badge extends StatelessWidget {
  final Widget child;
   final int value;
  // final Color color;
Badge({this.child,this.value,});
  @override
  Widget build(BuildContext context) {
    print('ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss');
  //  final cartData= Provider.of<Cart>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
       if(value>=1)
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color:Colors.red
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
             value.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        )
      ],
    );
  }
}
