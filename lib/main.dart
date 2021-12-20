import 'package:flutter/material.dart';
import 'package:plant_app/Models/Auth.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/Models/Order.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/AuthScreen.dart';
import 'package:plant_app/screens/LoadingScreen.dart';
import 'package:plant_app/screens/More_Plants_Screen.dart';
import 'package:plant_app/screens/OrderScreen.dart';
import 'package:plant_app/screens/PlandDetails/Plant_Description_Screen.dart';
import 'package:plant_app/screens/PlandDetails/Plant_Details_Screen.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(
          create: (ctx) => Plants(),
        ),
        ChangeNotifierProvider(create: (ctx) => Plant()),
        ChangeNotifierProvider(create: (ctx) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders('','',[]),
            update: (ctx, authOfOrder, previousOrders) => Orders(
                authOfOrder.token, authOfOrder.userId, previousOrders == null ? [] : previousOrders.orders))
      ],
      child: Consumer<Auth>(
        builder: (ctx, authdata, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Plant App',
          theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            primaryColor: kPrimaryColor,
            textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: authdata.isAuth
              ? HomeScreen()
              : FutureBuilder(
                  future: authdata.tryLogin(),
                  builder: (ctx, snapShot) {
                    if (snapShot.connectionState == ConnectionState.waiting) {
                      return LoadingScreen();
                    } else {
                      return LoginScreen();
                    }
                  }),
          routes: {
            PlantDetailScreen.routeName: (ctx) => PlantDetailScreen(),
            MorePlantScreen.routeName: (ctx) => MorePlantScreen(),
            PlantDescriptionScreen.RouteName: (ctx) => PlantDescriptionScreen(),
            OrderScreen.routeName:(ctx)=>OrderScreen()
          },
        ),
      ),
    );
  }
}
