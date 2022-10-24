import 'package:dio/dio.dart';
import 'package:dixie_direct/model/category_model.dart';
import 'package:dixie_direct/model/media_model.dart';
import 'package:dixie_direct/model/offer_model.dart';
import 'package:dixie_direct/model/picture_model.dart';

import '../model/business_model.dart';
import '../utils/constant.dart';

class BusinessApi{

  static Future<String> getCategoryImage(int iconId)async{
    String url='';
    var dio = Dio();
    var response = await  dio.get('$apiUrl/media/$iconId',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){
      url=PictureModel.fromJson(response.data).guid!.rendered!;
      print("cat url $url");

    }
    else print("error ${response.statusCode} : ${response.data}");
    return url;

  }

  static Future<List<CategoryModel>> getCategories()async{
    List<String> categories=[
      'Dining',
      'Entertainment',
      'Golf',
      'Automotive',
      'Shopping',
      'Health &amp; Beauty',
      'Maintenance',
      'Services',
      'Travel &amp; Lodging',
    ];
    List<CategoryModel> homes=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/industry',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      homes = List<CategoryModel>.from(l.map((model)=> CategoryModel.fromJson(model)));
      //print("user model ${homes}");

    }
    else print("error ${response.statusCode} : ${response.data}");
    List<CategoryModel> sortedCategories=[];
    for(int i=0;i<categories.length;i++){
      homes.forEach((element) {
        if(categories[i]==element.name){
          sortedCategories.add(element);
          //homes.remove(categories);
        }
      });
    }


    return sortedCategories;

  }

  static Future<List<BusinessModel>> getBusinessInCategory(int categoryId)async{
    List<BusinessModel> items=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/business',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      items = List<BusinessModel>.from(l.map((model)=> BusinessModel.fromJson(model)));
      print("current category Id $categoryId");
      items.forEach((element) {
        print("business: ${element.id} ${element.title!.rendered!}");
        element.industry!.forEach((category) {
          print("category id $category");
        });
      });
      items.removeWhere((element) => !element.industry!.contains(categoryId));

    }
    return items;

  }

  static Future<List<BusinessModel>> getAllBusinesses()async{
    List<BusinessModel> items=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/business',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      items = List<BusinessModel>.from(l.map((model)=> BusinessModel.fromJson(model)));


    }
    return items;

  }

  static Future<List<BusinessModel>> getSearchResult(String query)async{
    List<BusinessModel> items=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/business',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      List<BusinessModel> temp = List<BusinessModel>.from(l.map((model)=> BusinessModel.fromJson(model)));
      items= temp.where((element) => element.title!.rendered!.toLowerCase().trim().contains(query.toLowerCase().trim())).toList();


    }
    return items;

  }


  static Future<List<OfferModel>> getOffers(int id)async{
    print("bid $id");
    List<OfferModel> offers=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/offer',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      offers = List<OfferModel>.from(l.map((model)=> OfferModel.fromJson(model)));
      offers.removeWhere((element) => element.id!=id);

    }
    return offers;

  }


  static Future<List<BusinessModel>> getFavouriteBusinesses(List<int> ids)async{
    List<BusinessModel> favourites=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/business',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      List<BusinessModel> items = List<BusinessModel>.from(l.map((model)=> BusinessModel.fromJson(model)));
      for(int i=0;i<items.length;i++){
        if(ids.contains(items[i].id)){
          favourites.add(items[i]);
        }
      }
    }
    return favourites;

  }


}