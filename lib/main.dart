import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  List<String> _wallpapers = ["Selfie"];

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("Never Settle"),
          ),
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                child: RaisedButton(
                  onPressed: () {
                    setState(() {
                      _wallpapers.add("Selfie 1 again");
                    });
                  },
                  child: Text("Press this"),
                ),
              ),
              Column(
                children: _wallpapers
                    .map((element) => Card(
                          child: Column(
                            children: <Widget>[
                              Image.asset("assets/selfie.jpg"),
                              Text(element)
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ],
          )),
    );
  }
}
