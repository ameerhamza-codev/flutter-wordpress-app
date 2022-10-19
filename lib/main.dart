import 'package:dixie_direct/provider/favourite_provider.dart';
import 'package:dixie_direct/provider/theme_provider.dart';
import 'package:dixie_direct/screens/navigator/bottom_bar.dart';
import 'package:dixie_direct/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = new DarkThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
    await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) {
          return themeChangeProvider;
        },
        child: Consumer<DarkThemeProvider>(
          builder: (BuildContext context, value, _) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<FavouriteProvider>(
                  create: (_) => FavouriteProvider(),
                ),


              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: Styles.themeData(themeChangeProvider.darkTheme, context),
                home: BottomBar(),

              ),
            );
          },
        ),);
  }
}

