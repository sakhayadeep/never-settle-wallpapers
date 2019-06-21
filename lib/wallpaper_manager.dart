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

  HashMap _wallpapers = new HashMap<String, List<String>>();
  List thumbUrls = new List();

  Future getApiKey() async{
    await DotEnv().load('.env');
    setState(() {
      apiKey = DotEnv().env['API_KEY'];
    });
    _getWallpaper();
  }
  
  @override
  void initState() {
    super.initState();
    getApiKey();
  }

  Future<void> _getWallpaper() async{
    String url = "https://wall.alphacoders.com/api2.0/get.php?auth=$apiKey&method=random";
    try{
      final http.Response response = await http.get(Uri.encodeFull(url));

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if(data["success"]){
          var wallpaperList = data["wallpapers"] as List;

          for(int i=0; i<wallpaperList.length; i++){
            _wallpapers[wallpaperList[i]["url_thumb"].toString()] = [wallpaperList[i]["id"].toString(), wallpaperList[i]["url_image"].toString()];
          }
          setState(() {
              _wallpapers.forEach((thumbUrl,imageIdUrls){
                if(thumbUrls.contains(thumbUrl) == false){
                  thumbUrls.add(thumbUrl);
                }
              });
            });
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

  void loadMoreWallpapers()async{
    await _getWallpaper();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              loadMoreWallpapers();
          }
        },
        child: Center(
          child: _wallpapers.length>0?ListView(
            children: <Widget>[Wallpapers(_wallpapers, thumbUrls)],
          ):CircularProgressIndicator(),
        ));
  }
}
