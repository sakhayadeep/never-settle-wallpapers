import 'dart:convert';
import 'dart:collection';

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
  HashMap _wallpapers = new HashMap<String, String>();
  List thumbUrls = new List<String>();
  
  static int page = 1;
  void _updateList(){
    print("Updating list");
    _wallpapers.forEach((urlThumb,urlImage){
      if(thumbUrls.contains(urlThumb) == false){
        thumbUrls.add(urlThumb);
      }
    });

    if(thumbUrls.length !=0 && thumbUrls.length % 30 == 0){
      page++;
    }
    if(page>300){
      page = 1;
    }

  }
  
  @override
  void initState() {
    super.initState();
    apiKey = widget.apiKey;
    _getWallpaper();
  }

  _getWallpaper() async{
    String key = apiKey;
    String method = "featured";
    String url = "https://wall.alphacoders.com/api2.0/get.php?auth=$key&method=$method&page=$page";
    try{
      final http.Response response = await http.get(Uri.encodeFull(url));

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if(data["success"]){
          var wallpaperList = data["wallpapers"] as List;
          
          for(int i=0; i<wallpaperList.length; i++){
            _wallpapers[wallpaperList[i]["url_thumb"]] = wallpaperList[i]["url_image"];
          }
        }
      
    } else {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("error : ${data["success"]}"),
      ));
    }

    }
    catch(e){
      print("error is $e");
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
          children: <Widget>[Wallpapers(_wallpapers, thumbUrls, _updateList)],
        ));
  }
}
