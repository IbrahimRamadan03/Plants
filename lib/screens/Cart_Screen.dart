import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/Models/Order.dart';
import 'package:plant_app/components/Cart_Item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    final orderData = Provider.of<Orders>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: cartData.items.isEmpty
          ? Container(
              height: MediaQuery.of(context).size.height * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://previews.123rf.com/images/pshonka/pshonka1802/pshonka180200291/95077629-shopping-cart-with-cross-sign-cancel-or-delete-purchase-simple-icon-e-commerce-graph-symbol-for-your.jpg'))),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.all(12),
                    child: Container(
                        height: 560,
                        width: MediaQuery.of(context).size.width * 1,
                        child: ListView.builder(
                          itemCount: cartData.items.length,
                          itemBuilder: (ctx, index) => Card(
                            child: CartItemWidget(
                              id: cartData.items.keys.toList()[index],
                              title:
                                  cartData.items.values.toList()[index].title,
                              price:
                                  cartData.items.values.toList()[index].price,
                              quantity: cartData.items.values
                                  .toList()[index]
                                  .quantity,
                              imageUrl: cartData.items.values
                                  .toList()[index]
                                  .ImageUrl,
                            ),
                          ),
                        ))),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Price :',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(cartData.TotalAmount.toString())
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 50,
                          child: RaisedButton(
                            child: Text(
                              "CHECKOUT",
                              style:
                                  Theme.of(context).textTheme.button.copyWith(
                                        color: Colors.white,
                                      ),
                            ),
                            onPressed: () {
                              orderData.addOrder(cartData.items.values.toList(),
                                  cartData.TotalAmount);
                              cartData.clear();
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('your items have been ordered!!'),
                                duration: Duration(seconds: 2),
                              ));
                            },
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
