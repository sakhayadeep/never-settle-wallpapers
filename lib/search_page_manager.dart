import 'dart:convert';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './wallpapers.dart';

class SearchPageManager extends StatelessWidget{

  final String searchKeyWords;                  
  final String method;

  SearchPageManager({@required this.searchKeyWords, @required this.method});       //getting search string

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(searchKeyWords),
        ),
        body: SearchPage(searchKeyWords, method),
    );
  }

}

class SearchPage extends StatefulWidget{

  final String searchKeyWords;
  final String method;

  SearchPage(this.searchKeyWords, this.method);                          //getting search string from the SearchPageManager

  @override
  State<StatefulWidget> createState() {
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage>{

  String apiKey;
  static int page = 1;
  String searchKeyWords;
  String method;

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
    searchKeyWords = widget.searchKeyWords;               //getting the search string to the State of SearchPage Widget
    searchKeyWords = Uri.encodeQueryComponent(searchKeyWords);
    method = widget.method;
    super.initState();
    getApiKey();
  }

  void _getWallpaper() async{
    String url = "https://wall.alphacoders.com/api2.0/get.php?auth=$apiKey&method=$method&term=$searchKeyWords&page=$page";
    try{
      final http.Response response = await http.get(Uri.encodeFull(url));

      var data = json.decode(response.body);

      if (response.statusCode == 200) {
        if(data["success"]){
          var wallpaperList = data["wallpapers"] as List;
        
          if(page<100){
            page++;
          }
          else{
            page = 1;
          }

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

  @override
  Widget build(BuildContext context) {
    print(searchKeyWords);
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
              _getWallpaper();
          }
        },
        child: Center(
          child: _wallpapers.length>0?ListView(
            children: <Widget>[Wallpapers(_wallpapers, thumbUrls)],
          ):CircularProgressIndicator(),
        ));
  }
}