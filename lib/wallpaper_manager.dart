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
  final int imgRequestPerPage = 12;

  @override
  void initState() {
    _getWallpaper();
    super.initState();
  }

  _getWallpaper() async {
    var page = new Random();
    int wallpaperPage = page.nextInt(999) + 1;
    var url =
        "https://api.pexels.com/v1/curated?per_page=$imgRequestPerPage&page=$wallpaperPage";
    String key = "563492ad6f917000010000012cdec998428e409b8ddc1e38d8cdcf29";

    final http.Response response =
        await http.get(Uri.encodeFull(url), headers: {"Authorization": key});

    var data = json.decode(response.body);

    var photo = data["photos"] as List;

    if (response.statusCode == 200) {
      setState(() {
        for (int i = 0; i < photo.length; i++) {
          _wallpapers.add(photo[i]["src"]["small"]);
        }
      });
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Server busy, try again later."),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _getWallpaper();
          }
        },
        child: ListView(
          children: <Widget>[Wallpapers(_wallpapers)],
        ));
  }
}
