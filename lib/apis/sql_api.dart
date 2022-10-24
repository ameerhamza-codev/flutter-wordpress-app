import 'package:dixie_direct/sql_model/business_sql_model.dart';
import 'package:dixie_direct/sql_model/category_sql_model.dart';
import 'package:dixie_direct/utils/db_tables.dart';
import 'package:sqflite/sqflite.dart';


class SqlApi{
  static Future<List<CategorySqlModel>> getCategories()async{
    var databasesPath = await getDatabasesPath();
    String path="$databasesPath/users.db";
    Database database = await openDatabase(path);

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
    List<CategorySqlModel> homes=[];
    List<Map<String,dynamic>> record=[];
    record = await database.rawQuery('SELECT * FROM $categoryTable');
    homes = List<CategorySqlModel>.from(record.map((model)=> CategorySqlModel.fromJson(model)));

    List<CategorySqlModel> sortedCategories=[];
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

  static Future<List<BusinessSqlModel>> getBusinessInCategory(int categoryId)async{
    var databasesPath = await getDatabasesPath();
    String path="$databasesPath/users.db";
    Database database = await openDatabase(path);


    List<BusinessSqlModel> items=[];
    List<Map<String,dynamic>> record=[];
    record = await database.rawQuery('SELECT * FROM $businessTable where categoryId=$categoryId');
    items = List<BusinessSqlModel>.from(record.map((model)=> BusinessSqlModel.fromJson(model)));
    return items;

  }

  static Future<List<BusinessSqlModel>> getAllBusiness()async{
    var databasesPath = await getDatabasesPath();
    String path="$databasesPath/users.db";
    Database database = await openDatabase(path);


    List<BusinessSqlModel> items=[];
    List<Map<String,dynamic>> record=[];
    record = await database.rawQuery('SELECT * FROM $businessTable');
    items = List<BusinessSqlModel>.from(record.map((model)=> BusinessSqlModel.fromJson(model)));
    return items;

  }

  static Future<List<BusinessSqlModel>> getSearchResult(String query)async{


    var databasesPath = await getDatabasesPath();
    String path="$databasesPath/users.db";
    Database database = await openDatabase(path);


    List<BusinessSqlModel> items=[];
    List<Map<String,dynamic>> record=[];
    record = await database.rawQuery('SELECT * FROM $businessTable');
    List<BusinessSqlModel> temp = List<BusinessSqlModel>.from(record.map((model)=> BusinessSqlModel.fromJson(model)));
    items= temp.where((element) => element.name!.toLowerCase().trim().contains(query.toLowerCase().trim())).toList();

    return items;

  }

  static Future<List<BusinessSqlModel>> getFavouriteBusinesses(List<int> ids)async{
    List<BusinessSqlModel> favourites=[];
    var databasesPath = await getDatabasesPath();
    String path="$databasesPath/users.db";
    Database database = await openDatabase(path);
    List<Map<String,dynamic>> record=[];
    record = await database.rawQuery('SELECT * FROM $businessTable');

    List<BusinessSqlModel> items = List<BusinessSqlModel>.from(record.map((model)=> BusinessSqlModel.fromJson(model)));
    for(int i=0;i<items.length;i++){
      if(ids.contains(items[i].businessId)){
        favourites.add(items[i]);
      }
    }
    return favourites;

  }
}