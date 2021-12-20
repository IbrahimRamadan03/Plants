import 'package:flutter/material.dart';
import 'package:plant_app/screens/PlandDetails/Clipper.dart';
class Header extends StatelessWidget {
final String imageUrl;
Header(this.imageUrl);

  @override
  Widget build(BuildContext context) {
   return AspectRatio(
      aspectRatio: 1.1,
      child: ClipPath(
      
      clipper:CurveClipper() ,
        child: Container(
          padding:
              const EdgeInsets.only(left: 10, right: 15, top: 20, bottom: 20),
          decoration: BoxDecoration(
           image:DecorationImage(
             fit:BoxFit.cover ,
             image:
           
           NetworkImage(imageUrl) ) 
          ),
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child: Icon(Icons.arrow_back_rounded,
                            color:Colors.black, size: 30),
                      ),
                     
                    ],
                  ),
                  // Hero(
                  //   tag: item.hashCode,
                  //   child: Image.asset(
                  //     item.url,
                  //     width: constraints.maxWidth * 0.6,
                  //     height: constraints.maxHeight * 0.6,
                  //     fit: BoxFit.contain,
                  //   ),
                  // ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}