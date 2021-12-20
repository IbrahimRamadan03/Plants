import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/components/Recomended_Plant_card.dart';
import 'package:provider/provider.dart';

class MorePlantScreen extends StatelessWidget {
  static const routeName = '/More-Screen';

 

  @override
  //design needs to change
  Widget build(BuildContext context) {
    final plant = Provider.of<Plants>(context,listen:false );
  // print( plant.items[1].imageUrl);
    return Scaffold(
        appBar: plant.buildAppBar(context),
        body: GridView.builder(
            padding: EdgeInsets.all(30),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2/ 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20),
              itemBuilder: (ctx, index) =>
                  ChangeNotifierProvider(create:(ctx)=>Plant() 
                 , child:RecomendPlantCard(
                    id:plant.items[index].id,
                    title:plant.items[index].title ,
                    image: plant.items[index].imageUrl,
                    price:plant.items[index].price,
                  ) ,
                  ),itemCount:plant.items.length ,),
        );
  }
}
