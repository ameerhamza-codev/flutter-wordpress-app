import 'package:dixie_direct/apis/favourite_pref.dart';
import 'package:flutter/cupertino.dart';

class FavouriteProvider extends ChangeNotifier {
  List<int> favorites=[];


  void addFavourite(int businessId) {
    favorites.add(businessId);
    notifyListeners();
  }
  void removeFavourite(int businessId) {
    favorites.remove(businessId);
    notifyListeners();
  }
  void init()async{
    favorites=await FavouritePref.getFavourites();
    notifyListeners();
  }
}
