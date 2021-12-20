

import 'package:flutter/material.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:provider/provider.dart';

class SearchPlants extends SearchDelegate<String> {
  String name;
  SearchPlants(this.name);
  @override
  set query(String value) {
    value=name;
    super.query = value;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
           query = '';
          },
          icon: Icon(Icons.clear))
    ];
    throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context,query);
    }, icon: Icon(Icons.arrow_back));
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Plant> allPlants = Provider.of<Plants>(context)
        .items
        .where((element) => element.title.contains(query))
        .toList();
  return ListView.builder(
    itemCount:allPlants.length ,
    itemBuilder:(context,index)=>Text(allPlants[index].title));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
      final List<Plant> allSuggestedPlants = Provider.of<Plants>(context)
        .items
        .where((element) => element.title.contains(query))
        .toList();
  return ListView.builder(
    itemCount:allSuggestedPlants.length ,
    itemBuilder:(context,index)=>Text(allSuggestedPlants[index].title));
 
  }
}
