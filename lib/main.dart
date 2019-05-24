import 'package:flutter/material.dart';

import './wallpaper_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                DrawerHeader(
                  child: ListTile(
                    title: Text("Sakhayadeep Nath"),
                    subtitle: Text("sakhayadeepnath@gmaill.com"),
                    trailing: Icon(Icons.account_circle),
                  ),
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text("Never Settle"),
          ),
          body: WallpaperManager("Coolfie")),
    );
  }
}
