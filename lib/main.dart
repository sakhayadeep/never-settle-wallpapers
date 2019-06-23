import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _getSavedThemeStatus() async{
    final prefs = await SharedPreferences.getInstance();
    bool darkThemeEnabled = prefs.getBool('darkThemeEnabled');
    if(darkThemeEnabled == null){
      setState(() {
       _darkThemeEnabled = false; 
      });
    }else{
      setState(() {
        _darkThemeEnabled = darkThemeEnabled; 
      });
    }
  }

  Future<void> _setSavedThemeStatus() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkThemeEnabled', _darkThemeEnabled);
  }

  @override
  void initState() {
    _getSavedThemeStatus();
    super.initState();
  }

  void _changeThemeStatus(bool changedTheme) {
    setState(() {
      _darkThemeEnabled = changedTheme;
    });
    _setSavedThemeStatus();
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
