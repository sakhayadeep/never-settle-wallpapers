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
          appBar: AppBar(
            title: Text("Never Settle"),
          ),
          body: WallpaperManager("Coolfie")),
    );
  }
}
