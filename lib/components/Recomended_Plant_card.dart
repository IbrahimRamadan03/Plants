import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/PlandDetails/Plant_Details_Screen.dart';

import 'package:provider/provider.dart';

class RecomendPlantCard extends StatelessWidget {
  RecomendPlantCard({this.id, this.title, this.image, this.price});

  final String image, title, id;
  final double price;

  @override
  Widget build(BuildContext context) {
    //final data= Provider.of<Plants>(context,listen:false );
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(PlantDetailScreen.routeName,arguments:id ),
      child: Container(
       
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
         Container(height:230,
         decoration:BoxDecoration(
           image:DecorationImage(image:NetworkImage(image),fit:BoxFit.fill  ) 
         ) ,
         ),
            Container(
              width:250 ,
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Text(
                title,
               
              ),
            ),
          ],
        ),
      ),
    );
  }
}
