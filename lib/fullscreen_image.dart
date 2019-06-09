import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class FullScreenImagePage extends StatefulWidget {
  final String imgPath;
  FullScreenImagePage(this.imgPath);

  @override
  State<StatefulWidget> createState() {
    return _FullScreenImagePageState();
  }
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String result = "Waiting to set wallpaper";
  String imgPath;
  @override
  void initState() {
    imgPath = widget.imgPath;
    super.initState();
  }

  final LinearGradient backGroundGradient = new LinearGradient(
      colors: [new Color(0x30000000), new Color(0x80000000)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      body: new SizedBox.expand(
        child: new Container(
          decoration: new BoxDecoration(gradient: backGroundGradient),
          child: new Stack(
            children: <Widget>[
              new Align(
                child: new Hero(
                  tag: imgPath,
                  child: Column(children: [
                    new Image.network(
                      imgPath,
                      height: MediaQuery.of(context).size.height - 50,
                      width: MediaQuery.of(context).size.width - 50,
                    ),
                    RaisedButton(
                      onPressed: () async {
                        String res;
                        res = await Wallpaper.homeScreen(imgPath);
                        if (!mounted) return;
                        setState(() {
                          result = res.toString();
						              _showSnackBar(result);
                        });
                      },
                      child: Text("Set as wallpaper"),
                    ),
                  ]),
                ),
              ),
              new Align(
                alignment: Alignment.topCenter,
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new AppBar(
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      leading: new IconButton(
                        icon: new Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
   _showSnackBar(String text,
      {Duration duration = const Duration(seconds: 1, milliseconds: 500)}) {
    return scaffoldKey.currentState.showSnackBar(
        new SnackBar(content: new Text(text), duration: duration));
  }
}
