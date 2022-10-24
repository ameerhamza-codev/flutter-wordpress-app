import 'dart:async';
import 'package:dixie_direct/apis/api_calls.dart';
import 'package:dixie_direct/apis/sqlite_helper.dart';
import 'package:dixie_direct/apis/sqlite_pref.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../provider/theme_provider.dart';
import 'navigator/bottom_bar.dart';
class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    _loadWidget();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final splashDelay = 2;


  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }


 void navigationPage() async{
    bool firstTime=await SqlitePref.isFirstTime();
    if(firstTime){
      await SqliteHelper.setUpDb();
      await SqlitePref.setFirstTime(false);

      //populating local database
      await ApiCall.getCategories();
      await ApiCall.getAllBusinesses();
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomBar()));

 }




  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Scaffold(
        body: Center(
          child: Image.asset("assets/images/logo.png"),
        )
    );
  }
}

