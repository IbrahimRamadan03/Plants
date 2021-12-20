import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/constants.dart';
import 'package:provider/provider.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

// this widget is missing the loading spinner before fetching thr data
class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
var _isinit=true;
var _isloading=false;
@override
void didChangeDependencies() {
   if(_isinit)
   {
    setState(() {
      _isloading=true;
    });
  
    Provider.of<Plants>(context).fetchPlantsData().then((_) {
      setState(() {
        _isloading=false;
      });
    });

    _isinit=false;


   }
    super.didChangeDependencies();
  }

  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return _isloading?Center(child:CircularProgressIndicator() ,): 
    Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            HeaderWithSearchBox(size: size),
            TitleWithMoreBtn(
              title: "Recomended",
            ),
            RecomendsPlants(),
         
            TitleWithMoreBtn(
              title: "Featured Plants",
            ),
            FeaturedPlants(),
            SizedBox(height: kDefaultPadding),
          ],
        ),
      ),
    );
  }
}

// Future <void> getPlants(BuildContext context) async{
//   await Provider.of<Plants>(context,listen:false ).fetchPlantsData();
