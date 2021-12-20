import 'package:flutter/material.dart';
import 'package:plant_app/Models/Auth.dart';
import 'package:plant_app/screens/OrderScreen.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final log = Provider.of<Auth>(context);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('test'),
            Divider(),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title:Text('Orders',style:TextStyle(fontSize: 25) ,),
              onTap:()=>Navigator.of(context).pushNamed(OrderScreen.routeName),
              
            ),
            Divider(),
            ElevatedButton(
                onPressed: () {
                  Provider.of<Auth>(context, listen: false).Logout();
         
                },
                child: Text('LogOut'))
          ],
        ),
      ),
    );
  }
}
