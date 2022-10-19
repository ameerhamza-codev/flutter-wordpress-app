import 'package:shared_preferences/shared_preferences.dart';

class FavouritePref{
  static const FAVOURITEPREF="FAVOURITEPREF";

  static Future setFavourites(List ids)async{
    List<String> fids=[];
    final prefs = await SharedPreferences.getInstance();
    ids.forEach((element) {
      fids.add(element.toString());
    });
    await prefs.setStringList(FAVOURITEPREF, fids);
  }

  static Future<List<int>> getFavourites()async{
    List<int> fids=[];
    final prefs = await SharedPreferences.getInstance();
    List<String> items = await prefs.getStringList(FAVOURITEPREF)??[];
    items.forEach((element) {
      fids.add(int.parse(element));
    });
    return fids;
  }
}
