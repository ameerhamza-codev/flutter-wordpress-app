import 'package:dio/dio.dart';
import 'package:dixie_direct/utils/db_tables.dart';
import 'package:sqflite/sqflite.dart';

import '../model/business_model.dart';
import '../model/category_model.dart';
import '../utils/constant.dart';
import 'bussiness_api.dart';

class ApiCall{
  static Future<void> getCategories()async{

    List<CategoryModel> categories=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/industry',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      categories = List<CategoryModel>.from(l.map((model)=> CategoryModel.fromJson(model)));
      //print("user model ${homes}");

      var databasesPath = await getDatabasesPath();
      String path="$databasesPath/users.db";
      Database database = await openDatabase(path);
      for(int i=0;i<categories.length;i++){
        String imageUrl=await BusinessApi.getCategoryImage(categories[i].acf!.icon!);
        await database.transaction((txn) async {
          int id1 = await txn.rawInsert('INSERT INTO $categoryTable(name, categoryId, imageUrl) VALUES(\'${categories[i].name}\' , \'${categories[i].id}\', \'$imageUrl\')');
          print('inserted1: $id1');
        });
      }

    }

  }

  static Future<void> getAllBusinesses()async{
    List<BusinessModel> items=[];
    var dio = Dio();
    var response = await  dio.get('$apiUrl/business',);
    print("res ${response.statusCode} ${response.data}");
    if(response.statusCode==200){

      Iterable l = response.data;
      items = List<BusinessModel>.from(l.map((model)=> BusinessModel.fromJson(model)));

      var databasesPath = await getDatabasesPath();
      String path="$databasesPath/users.db";
      Database database = await openDatabase(path);
      for(int i=0;i<items.length;i++){
        await database.transaction((txn) async {

          /*'businessId INTEGER PRIMARY KEY, '
          'name TEXT, '
          'address TEXT, '
          'imageUrl TEXT, '
          'contact TEXT, '
          'website TEXT, '
          'categoryId INTEGER)'*/
          int id1 = await txn.rawInsert('INSERT INTO $businessTable(businessId, name, imageUrl, address, contact, website, categoryId) '
              'VALUES(${items[i].id} , \'${items[i].title!.rendered}\', \'${items[i].uagbFeaturedImageSrc!.full!.first}\', '
              '\'${items[i].acf!.locations!.first.address!}, ${items[i].acf!.locations!.first.address2!}, ${items[i].acf!.locations!.first.city}, ${items[i].acf!.locations!.first.state}  ${items[i].acf!.locations!.first.zip}\''
              ' , \'${items[i].acf!.locations!.first.phone}\', '
              '\'${items[i].acf!.locations!.first.website}\',${items[i].industry!.first})');
          print('bussinessInsert: $id1');
        });
      }
    }

  }
}