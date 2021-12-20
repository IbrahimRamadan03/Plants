import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/components/Featured_plant_card.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<Plants>(context).favouritePlant;
    print(fav);
    return Scaffold(
      body: Container(
        color:Colors.green[50] ,
        child: Center(
            child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: fav.length,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height:270 ,
                          child: FeaturePlantCard(fav[index].id,fav[index].imageUrl)),
                      );
                    }))
          ],
        )),
      ),
    );
  }
}
