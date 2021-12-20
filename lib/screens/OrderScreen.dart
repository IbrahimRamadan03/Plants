import 'package:flutter/material.dart';
import 'package:plant_app/Models/Order.dart';
import 'package:plant_app/components/Order_item.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  static const routeName='order-screen';
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {

  Future _ordersFuture;
  Future _obtainedOrders() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _ordersFuture = _obtainedOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar:AppBar(title:Text('Orders') ,) ,
      body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (snapShot.error != null) {
                print(snapShot.error);
                return Center(
                  child: Text('An error occucred'),
                  
                );
              } else {
                return ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (ctx, index) {
                      return OrderItemWidget(orderData.orders[index]);
                    });
              }
            }
          }),
    );
  }
}
