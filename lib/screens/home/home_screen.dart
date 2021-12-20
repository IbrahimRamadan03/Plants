import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:plant_app/Models/Cart.dart';
import 'package:plant_app/Models/Plant.dart';
import 'package:plant_app/Models/Plants.dart';
import 'package:plant_app/components/App_Drawer.dart';
import 'package:plant_app/components/badge.dart';
import 'package:plant_app/components/my_bottom_nav_bar.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/screens/Cart_Screen.dart';
import 'package:plant_app/screens/Favourite_Screen.dart';
import 'package:plant_app/screens/User_Plant_Screen.dart';
import 'package:plant_app/screens/home/components/body.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List<Map<String, Widget>> _pages = [];
  int _selectedPageIndex = 0;
  void _SelectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    _pages = [
      {'Page': Body()},
      {'Page': FavouriteScreen()},
      {'Page': UserPlantScreen()}
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final AppBarr=Provider.of<Plants>(context).buildAppBar(context);
    return Scaffold(
      key: _drawerKey,
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Consumer<Cart>(builder:(_,cartData,child)=>
         
             Badge(
               value:cartData.itemCount ,
              child:IconButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen())),
                icon: Icon(Icons.shopping_cart_outlined)),
                
            ),
          )
        ],
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("assets/icons/menu.svg"),
          //add drawer here
          onPressed: () {
            _drawerKey.currentState.openDrawer();
          },
        ),
      ),
      body: _pages[_selectedPageIndex]['Page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _SelectedPage,
        backgroundColor: Colors.white,
        selectedItemColor: kPrimaryColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.favorite),
              label: 'Favourite'),
          BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person),
              label: 'User')
        ],
      ),
    );
  }

  // AppBar buildAppBar() {
  //   return AppBar(
  //     elevation: 0,
  //     leading: IconButton(
  //       icon: SvgPicture.asset("assets/icons/menu.svg"),
  //       //add drawer here
  //       onPressed: () {},
  //     ),
  //   );
  // }
}
