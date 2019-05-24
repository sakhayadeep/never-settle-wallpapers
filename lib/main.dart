import 'package:flutter/material.dart';

import './wallpaper_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final String _appTitle = "Never Settle";
  bool darkThemeEnabled = false;

  @override
  Widget build(context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: darkThemeEnabled ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.deepOrange,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(_appTitle),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.all(0),
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.orange),
                  child: ListTile(
                    title: Text("Sakhayadeep Nath"),
                    subtitle: Text("sakhayadeepnath@gmaill.com"),
                    trailing: Icon(Icons.account_circle),
                    onTap: () {},
                  ),
                ),
                ListTile(
                  title: Text("Dark Theme"),
                  trailing: Switch(
                    value: darkThemeEnabled,
                    onChanged: (changedTheme) {
                      darkThemeEnabled = changedTheme;
                      setState(() {});
                    },
                  ),
                )
              ],
            ),
          ),
          body: WallpaperManager("Coolfie")),
    );
  }
}
