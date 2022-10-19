import 'package:dixie_direct/apis/favourite_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favourite_provider.dart';
import '../provider/theme_provider.dart';

class FavoriteWidget extends StatefulWidget {
  int id;

  FavoriteWidget(this.id);

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Consumer<FavouriteProvider>(
      builder: (context,fav,_){
        return  InkWell(
          onTap: ()async{
            print("tapped ${fav.favorites.length}");
            if(!fav.favorites.contains(widget.id)){
              print("hhh");
              fav.addFavourite(widget.id);
              FavouritePref.setFavourites(fav.favorites);
            }
            else{
              print("rrrr");
              fav.removeFavourite(widget.id);
              FavouritePref.setFavourites(fav.favorites);
            }


          },
          child:  fav.favorites.contains(widget.id)?Icon(Icons.favorite,color: Colors.red,):Icon(Icons.favorite_border),
        );
      },
    );
  }
}
