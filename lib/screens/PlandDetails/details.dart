import 'package:flutter/material.dart';
class DetailsWidget extends StatelessWidget {
 final String title;
 DetailsWidget(this.title);

  @override
  Widget build(BuildContext context) {
   return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              title,style:TextStyle(fontWeight:FontWeight.bold,fontSize:25 ) ,
              ),
             
            ],
          ),
          SizedBox(height: 10),
         
          SizedBox(height: 20),
          Row(
            children: [
              Icon(Icons.horizontal_rule, color:Colors.black.withOpacity(0.7),),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color:Colors.black),               
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('1',),
              ),
              Icon(Icons.add,),
              Spacer(),
           
            ],
          ),
        ],
      ),
    );
  }
}