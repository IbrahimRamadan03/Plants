import 'package:flutter/material.dart';
import 'package:plant_app/Models/Order.dart';

class OrderItemWidget extends StatelessWidget {
  final OrderItem order;
  OrderItemWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 400,
        height: 300,
        child: ListView(
            children: order.plantsToBeShipped
                .map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.title,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(e.quantity.toString() +
                            'x' +
                            ' \$' +
                            e.price.toString())
                      ],
                    ))
                .toList()));
  }
}
