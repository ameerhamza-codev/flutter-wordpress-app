import 'package:dixie_direct/provider/theme_provider.dart';
import 'package:dixie_direct/screens/favourites.dart';
import 'package:dixie_direct/screens/map_screen.dart';
import 'package:dixie_direct/screens/search.dart';
import 'package:dixie_direct/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/favourite_provider.dart';
import '../../utils/constant.dart';
import '../../utils/theme_data.dart';
import '../home_page.dart';

class BottomBar extends StatefulWidget {

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomBar>{



  int _currentIndex = 0;

  List<Widget> _children=[];



  @override
  void initState() {
    super.initState();
    _children = [
      const HomePage(),
      const SearchScreen(),
      MapScreen(),
      const Favourites(),
      const Settings()


    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });


  }




  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context, listen: false);
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    provider.init();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor:Colors.grey,
        selectedItemColor: Styles.themeData(themeData.darkTheme, context).primaryColor,
        onTap: onTabTapped, // ne
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
              label: "Search"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
              label: "Map"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: "Favourite"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "Settings"
          ),


        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
