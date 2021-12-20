import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/PlandDetails/Plant_Details_Screen.dart';
import 'package:provider/provider.dart';
class FeaturePlantCard extends StatelessWidget {
  final String image;
  final String id;
FeaturePlantCard(this.id,this.image);

  @override
  Widget build(BuildContext context) {
   // final plantImage=Provider.of<Plants>(context);
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap:()=>Navigator.of(context).pushNamed(PlantDetailScreen.routeName,arguments:id ),
      child: Container(
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding / 2,
        ),
        width: size.width * 0.8,
        height: 185,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(image),
          ),
        ),
      ),
    );
  }
}
