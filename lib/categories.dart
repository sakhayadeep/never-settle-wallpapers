import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import './search_page_manager.dart';

class Categories extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _CategoriesState();
  }
}

class _CategoriesState extends State<Categories>{
String apiKey;

List<String> categoriesList = new List<String>();

  Future getApiKey() async{
    await DotEnv().load('.env');
    setState(() {
      apiKey = DotEnv().env['API_KEY'];
    });
    _getCategories();
  }
  

@override
  void initState() {
    getApiKey();
    super.initState();
  }

void _getCategories() async {

    String url = "https://wall.alphacoders.com/api2.0/get.php?auth=$apiKey&method=category_list";
    try{
      final http.Response response = await http.get(Uri.encodeFull(url));

      var data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        if(data["success"]){
          var categories = data["categories"] as List;
          setState(() { 
            for(int i = 0; i<categories.length;i++){
              categoriesList.add(categories[i]['name'].toString());
            }
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

void _onCategoryTapped(String category) async{

      await Navigator.push(context,
      new MaterialPageRoute(
        builder: (context){
          return SearchPageManager(searchKeyWords: category, method: 'search',);
        }
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories"),
      ),
      body: Center(
        child: categoriesList.length>0?ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index){
            return ListTile(
              title: Center(
                child: Text(categoriesList[index],style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
                ),
              onTap: ()=>_onCategoryTapped(categoriesList[index]),
            );
          },
        ):CircularProgressIndicator(),
      ),
    );
  }
}