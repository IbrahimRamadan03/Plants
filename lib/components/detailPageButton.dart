
import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';

class DetailPageButton extends StatelessWidget {
  final Size size;
  DetailPageButton(this.size);
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: size.width / 2,
      height: 84,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
          ),
        ),
        color: kPrimaryColor,
        onPressed: () {},
        child: Text(
          "OverView",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
