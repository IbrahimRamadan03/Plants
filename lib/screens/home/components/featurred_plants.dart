import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/components/Featured_plant_card.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class FeaturedPlants extends StatelessWidget {
  const FeaturedPlants({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final plant = Provider.of<Plants>(context);
    return Container(
      width: MediaQuery.of(context).size.width * 1,
      height: 230,
      child: ListView.builder(
        scrollDirection:Axis.horizontal,
        itemCount:4 ,
          itemBuilder: (ctx, index) => FeaturePlantCard(
              plant.items[index].id, plant.items[index].imageUrl)),
    );
  }
}
