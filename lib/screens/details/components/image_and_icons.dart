import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import 'icon_card.dart';

class ImageAndIcons extends StatefulWidget {
  const ImageAndIcons({
    Key key,
    @required this.size,
    @required this.imageUrl,
    @required this.id,
    @required this.title,
  }) : super(key: key);

  final Size size;
  final String imageUrl, id, title;

  @override
  _ImageAndIconsState createState() => _ImageAndIconsState();
}

class _ImageAndIconsState extends State<ImageAndIcons> {
  @override
  Widget build(BuildContext context) {
    final PlantData =
        Provider.of<Plants>(context, listen: false).findById(widget.id);

    final cart = Provider.of<Cart>(context, listen: false);
    var isAdded = cart.items.containsKey(PlantData.id);
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding * 3),
      child: SizedBox(
        height: widget.size.height * 0.8,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: kDefaultPadding * 3),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: kDefaultPadding),
                        icon: SvgPicture.asset("assets/icons/back_arrow.svg"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Spacer(),
                    IconCard(icon: "assets/icons/sun.svg"),
                    IconCard(icon: "assets/icons/icon_2.svg"),
                    Consumer<Plant>(
                        builder: (ctx, plantt, child) => InkWell(
                            onTap: () {
                              if (isAdded) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    'Item is already in your cart!!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  duration: Duration(seconds: 2),
                                ));
                              } else {
                                cart.addItem(
                                    PlantData.id.toString(),
                                    PlantData.price,
                                    PlantData.title,
                                    PlantData.imageUrl);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Added Item to Cart',
                                      textAlign: TextAlign.center,
                                    ),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                                setState(() {
                                  isAdded = true;
                                });
                              }
                            },
                            child: IconCard(
                                icon: isAdded
                                    ? "assets/icons/Added.svg"
                                    : "assets/icons/AddCart.svg"))),
                    FittedBox(
                      child: Consumer<Plant>(
                        builder: (ctx, PlantStatues, child) => InkWell(
                            onTap: () {
                              PlantStatues.toggleFavourite(widget.id);
                              if (PlantStatues.isFavourite == true) {
                                PlantData.isFavourite = true;
                              } else {
                                PlantData.isFavourite = false;
                              }
                            },
                            child: IconCard(
                                icon: PlantStatues.isFavourite
                                    ? "assets/icons/icon_4.svg"
                                    : 'assets/icons/heart-icon.svg')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: widget.size.height * 0.8,
              width: widget.size.width * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(63),
                  bottomLeft: Radius.circular(63),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 60,
                    color: kPrimaryColor.withOpacity(0.29),
                  ),
                ],
                image: DecorationImage(
                  //change the design here
                  fit: BoxFit.fill,
                  image: NetworkImage(widget.imageUrl),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
