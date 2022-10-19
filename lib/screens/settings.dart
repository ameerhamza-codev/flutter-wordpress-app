import 'package:dixie_direct/utils/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final themeData = Provider.of<DarkThemeProvider>(context, listen: false);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(10),
          children: [
            Text('General Settings',style: TextStyle(fontWeight: FontWeight.w500),),
            SizedBox(height: 10,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.dark_mode),
              title: Text('Dark Theme',style: TextStyle(fontWeight: FontWeight.w400),),
              trailing: Switch(
                onChanged: (bool value) {
                  themeChange.darkTheme = value;
                },
                value: themeChange.darkTheme,
                activeColor: Colors.white,
                activeTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
              )
              ,
            ),
            Divider(color: themeData.darkTheme?Colors.white:Colors.grey,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.thumb_up_alt_outlined),
              title: Text('Facebook',style: TextStyle(fontWeight: FontWeight.w400),),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,)
              ,
            ),
            Divider(color: themeData.darkTheme?Colors.white:Colors.grey,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.rocket_launch),
              title: Text('Twitter',style: TextStyle(fontWeight: FontWeight.w400),),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,)
              ,
            ),
            Divider(color: themeData.darkTheme?Colors.white:Colors.grey,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.list_alt),
              title: Text('Terms & Condition',style: TextStyle(fontWeight: FontWeight.w400),),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,)
              ,
            ),
            Divider(color: themeData.darkTheme?Colors.white:Colors.grey,),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.list_alt),
              title: Text('Privacy Policy',style: TextStyle(fontWeight: FontWeight.w400),),
              trailing: Icon(Icons.arrow_forward_ios_rounded,size: 15,)
              ,
            ),

          ],
        ),
      ),
    );
  }
}
