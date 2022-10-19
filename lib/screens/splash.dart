import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';
import 'navigator/bottom_bar.dart';
class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>  with TickerProviderStateMixin{
  AnimationController? animationController;
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    )
      ..forward()
      ..repeat(reverse: true);
    _loadWidget();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }
  final splashDelay = 5;


  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }


 void navigationPage() async{
   Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomBar()));

 }
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    return Scaffold(
        body: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset("assets/images/upper.png",height: 150,),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset("assets/images/lower.png",height: 50,width: 80,),
            ),
          ],
        )
    );
  }
}

