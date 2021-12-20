
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:http/http.dart' as http;
import 'package:plant_app/components/App_Drawer.dart';
import 'package:plant_app/screens/PlandDetails/Plant_Details_Screen.dart';



class Plants with ChangeNotifier{
List <Plant> _items=[];
List <Plant> get items{
  return [..._items];
}
Plant findById(String id)
{
  return _items.firstWhere((element) => element.id==id);
}
List <Plant> get favouritePlant {
  return _items.where((element) => element.isFavourite==true).toList();
}
Widget buildAppBar(BuildContext ctx) {
  return AppBar(
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      //add drawer here
      onPressed: () {
      Scaffold.of(ctx).openDrawer();
      },
    ),
  );

}
Future <void> fetchPlantsData() async{
    const url ='https://shopappfirebase-50d2e-default-rtdb.firebaseio.com/products.json';
    final response= await http.get(Uri.parse(url));
    final extractedData=json.decode(response.body) as Map<String,dynamic>;
    final List <Plant> loadedPlants=[];
    print(extractedData);
    // final favResponse=await http.get(Uri.parse(url));
    // final favData=json.decode(favResponse.body);
    extractedData.forEach((plantId, plantData) { 
      loadedPlants.add(Plant(
        id:plantId,
        title:plantData['title'] ,
        description:plantData['description'],
        imageUrl:plantData['imageUrl'],
        price:plantData['price']  ,
        isFavourite:plantData['isFavourite'] 
      
        
      ));
    });
    _items=loadedPlants;
    print('///////////////////////////////////////////////');
    
  
    notifyListeners();
}


}
 