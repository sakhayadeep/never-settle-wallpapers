import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './wallpaper_manager.dart';
import './drawer_manager.dart';

const String _appTitle = "Never Settle";

Future main() async{
  await DotEnv().load('.env');
  return runApp(MyApp(DotEnv().env['API_KEY']));
} 

class MyApp extends StatefulWidget {
  final String apiKey;

  MyApp(this.apiKey);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  String apiKey;
  bool _darkThemeEnabled = false;

  @override
  void initState() {
    apiKey = widget.apiKey; 
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
          body: WallpaperManager(apiKey)),
    );
  }
}
