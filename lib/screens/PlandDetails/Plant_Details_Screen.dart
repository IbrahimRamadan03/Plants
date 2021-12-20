import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/components/detailPageButton.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/PlandDetails/Plant_Description_Screen.dart';
import 'package:provider/provider.dart';

import '../details/components/image_and_icons.dart';
import '../details/components/title_and_price.dart';

class PlantDetailScreen extends StatelessWidget {
  static const routeName = '/Detail-Screen';
  @override
  Widget build(BuildContext context) {
    final PlantId = ModalRoute.of(context).settings.arguments as String;
    final loadedPlants =
        Provider.of<Plants>(context, listen: false).findById(PlantId);
    final favData = Provider.of<Plant>(context, listen: false);
    //print(loadedPlants.id);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: FutureBuilder(
        future: favData.getFavData(PlantId),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ImageAndIcons(
                          size: size,
                          imageUrl: loadedPlants.imageUrl,
                          id: PlantId,
                          title: loadedPlants.title,
                        ),
                        TitleAndPrice(
                            title: loadedPlants.title,
                            country: "Russia",
                            price: loadedPlants.price),
                        SizedBox(height: kDefaultPadding),
                        Row(
                          children: <Widget>[
                            DetailPageButton(size),
                            Expanded(
                              child: FlatButton(
                                onPressed: () => Navigator.of(context)
                                    .pushNamed(PlantDescriptionScreen.RouteName,
                                        arguments: {
                                      'title': loadedPlants.title,
                                      'description': loadedPlants.description,
                                      'imageUrl': loadedPlants.imageUrl,
                                      'id': loadedPlants.id,
                                      'price': loadedPlants.price
                                    }),
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
