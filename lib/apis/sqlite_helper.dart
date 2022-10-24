import 'package:dixie_direct/utils/db_tables.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper{

  static Future<void> setUpDb()async{
    var databasesPath = await getDatabasesPath();
    String path="$databasesPath/users.db";
    await openDatabase(path, version: 1,onCreate: (Database db, int version) async {

      await db.execute(
          'CREATE TABLE $businessTable ('
          'businessId INTEGER PRIMARY KEY, '
          'name TEXT, '
          'address TEXT, '
          'imageUrl TEXT, '
          'contact TEXT, '
          'website TEXT, '
          'categoryId INTEGER)'
      );

      await db.execute(
          'CREATE TABLE $categoryTable ('
              'categoryId INTEGER PRIMARY KEY, '
              'name TEXT, '
              'imageUrl TEXT)'
      );


    });

  }


}

