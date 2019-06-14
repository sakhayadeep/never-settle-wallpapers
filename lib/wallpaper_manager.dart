import 'dart:convert';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './wallpapers.dart';

class WallpaperManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WallpaperManagerState();
  }
}

class _WallpaperManagerState extends State<WallpaperManager> {
  String apiKey;
  String method = "featured";
  static int page = 1;

  HashMap _wallpapers = new HashMap<String, List<String>>();
  List thumbUrls = new List();

  Future getApiKey() async{
    await DotEnv().load('.env');
    apiKey = DotEnv().env['API_KEY'];
  }
  
  @override
  void initState() {
    getApiKey();
    _getWallpaper();
    super.initState();
  }

  _getWallpaper() async{
    String url = "https://wall.alphacoders.com/api2.0/get.php?auth=$apiKey&method=$method&page=$page";
    try{
      final http.Response response = await http.get(Uri.encodeFull(url));

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if(data["success"]){
          var wallpaperList = data["wallpapers"] as List;
        
          if(page<1000){
            page++;
          }
          else{
            page = 1;
          }

          for(int i=0; i<wallpaperList.length; i++){
            _wallpapers[wallpaperList[i]["url_thumb"].toString()] = [wallpaperList[i]["id"].toString(), wallpaperList[i]["url_image"].toString()];

            setState(() {
              _wallpapers.forEach((thumbUrl,imageIdUrls){
                if(thumbUrls.contains(thumbUrl) == false){
                  thumbUrls.add(thumbUrl);
                }
              });
            });
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
              _getWallpaper();
          }
        },
        child: ListView(
          children: <Widget>[Wallpapers(_wallpapers, thumbUrls)],
        ));
  }
}
