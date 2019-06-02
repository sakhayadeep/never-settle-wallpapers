import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './wallpapers.dart';

class WallpaperManager extends StatefulWidget {
  final String apiKey;
  
  WallpaperManager(this.apiKey);

  @override
  State<StatefulWidget> createState() {
    return _WallpaperManagerState();
  }
}

class _WallpaperManagerState extends State<WallpaperManager> {
  String apiKey;
  List<String> _wallpapers = [];
  final int imgRequestPerPage = 12;
  String query;

  @override
  void initState() {
    apiKey = widget.apiKey;
    super.initState();
    _getWallpaper();
  }

  _getWallpaper() async {
    var page = new Random();
    int wallpaperPage = page.nextInt(999) + 1;
    String url;
    if (query == null) {
      url =
          "https://api.pexels.com/v1/curated?per_page=$imgRequestPerPage&page=$wallpaperPage";
    } else {
      url =
          "https://api.pexels.com/v1/search?query=$query&per_page=$imgRequestPerPage&page=$wallpaperPage";
    }
    String key = apiKey;

    final http.Response response =
        await http.get(Uri.encodeFull(url), headers: {"Authorization": key});

    var data = json.decode(response.body);

    var photo = data["photos"] as List;

    if (response.statusCode == 200) {
      for (int i = 0; i < photo.length; i++) {
        _wallpapers.add(photo[i]["src"]["small"]);
      }
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
            setState(() {
              _getWallpaper();
            });
          }
        },
        child: ListView(
          children: <Widget>[Wallpapers(_wallpapers)],
        ));
  }
}
