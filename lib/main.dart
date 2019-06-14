import 'package:flutter/material.dart';

import './wallpaper_manager.dart';
import './drawer_manager.dart';

const String _appTitle = "Never Settle";

main(){
  return runApp(MyApp());
} 

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    super.initState();
  }

  void _changeThemeStatus() {
    setState(() {
      _darkThemeEnabled = _darkThemeEnabled ? false : true;
    });
  }

  @override
  Widget build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: _darkThemeEnabled ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(_appTitle),
          ),
          drawer: DrawerManager(_changeThemeStatus, _darkThemeEnabled),
          body: WallpaperManager()),
    );
  }
}
