import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './wallpapers.dart';

class WallpaperManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WallpaperManagerState();
  }
}

class _WallpaperManagerState extends State<WallpaperManager> {
  List<String> _wallpapers = [];

  void getWallpaper() async {
    var page = new Random();
    int wallpaperPage = page.nextInt(999) + 1;
    var url =
        "https://api.pexels.com/v1/curated?per_page=1&page=$wallpaperPage";
    String key = "";

    http.Response response =
        await http.get(Uri.encodeFull(url), headers: {"Authorization": key});

    var data = json.decode(response.body);
    var photo = data["photos"] as List;
    _wallpapers.insert(0, photo[0]["src"]["medium"]);
  }

  @override
  void initState() {
    getWallpaper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: RaisedButton(
            color: Colors.teal,
            textColor: Colors.white,
            onPressed: () {
              setState(() {
                getWallpaper();
              });
            },
            child: Text("add more(${_wallpapers.length})"),
          ),
        ),
        Wallpapers(_wallpapers)
      ],
    );
  }
}
