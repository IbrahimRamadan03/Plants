import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/components/Recomended_Plant_card.dart';

import 'package:provider/provider.dart';

import '../../../constants.dart';

class RecomendsPlants extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PlantData = Provider.of<Plants>(context,listen:false );
    return  Container(
      height:330 ,
        child: ListView.builder(
          scrollDirection:Axis.horizontal 
          
          ,itemBuilder: (ctx, index) => 
        RecomendPlantCard(
            id:PlantData.items[index].id ,
            title:PlantData.items[index].title ,
            image: PlantData.items[index].imageUrl,
            price:PlantData.items[index].price ,
    
          ),
        itemCount:PlantData.items.length ));
      
    
  }
}
