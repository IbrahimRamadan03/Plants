import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

class Expandable extends StatelessWidget {
  final String description;
  Expandable({this.description});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.stretch ,
        children: [
              Text('Plant Details : ',style:TextStyle(fontSize:18,fontWeight:FontWeight.w800  ) ,),
              SizedBox(height:15 ,),
             Text(description),
            ],
          ),
          
      
  
    );
  }
}
