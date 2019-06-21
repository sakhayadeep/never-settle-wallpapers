import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:http/http.dart' as http;

class FullScreenImagePage extends StatefulWidget {
  final List<String> wallpapers;
  FullScreenImagePage(this.wallpapers);

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImagePageState();
  }
}


class _FullScreenImagePageState extends State<FullScreenImagePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String imgPath;
  String id;
  bool downloading=false;

  @override
  void initState() {
    id = widget.wallpapers[0];
    imgPath = widget.wallpapers[1];
    super.initState();
  }

 void _onDownloadPressed() async{
  try{
    _showSnackBar("Downloading, please wait...");
    var response = await http.get(imgPath);
    var filePath = await ImagePickerSaver.saveFile(fileData: response.bodyBytes);
    _showSnackBar("Done! Saved at $filePath");
  }catch(e){
    print(e);
  }
}

void _onHomePressed() {
  try{
    _showSnackBar("Setting Home Screen, please wait...");
     Future<String> result = Wallpaper.homeScreen(imgPath);
     result.then((homescreenResult){
       _showSnackBar("Home Screen is set successfully");
     });
  }catch(e){
    print(e);
  }
}

  final LinearGradient backGroundGradient = new LinearGradient(
      colors: [new Color(0x30000000), new Color(0x80000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
            title: Text("Set Wallpaper"),
          ),
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backGroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                child: new Hero(
                  tag: imgPath,
                  child: Column(children: [
                    Stack(
                        alignment: Alignment.center,
                        children: [
                          Center( child: CircularProgressIndicator()),
                          Center(
                            child: FadeInImage.memoryNetwork(
                              height: MediaQuery.of(context).size.height - 130,
                              placeholder: kTransparentImage,
                              image: imgPath,
                            ),
                          ),
                        ],
                      ),
                    Row(
                      children: <Widget>[
                        Expanded(child:FlatButton(
                          color: Colors.teal,
                          onPressed: (){
                            _onHomePressed();
                          },
                          child: Text("Set as Wallpaper", style: TextStyle(color: Colors.white),),
                        )),
                        Expanded(child:FlatButton(
                          color: Colors.teal,
                          onPressed: (){
                            _onDownloadPressed();
                          },
                          child: Text("Download", style: TextStyle(color: Colors.white)),
                        ))    
                      ],
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   _showSnackBar(String text,
      {Duration duration = const Duration(seconds: 3)}) {
    return scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(text), duration: duration));
  }
}
