import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Nameless App"),
        ),
        body: Card(
          child: Column(
            children: <Widget>[
              Image.asset("assets/selfie.jpg"),
              Text("Selfie")
            ],
          ),
        ),
      ),
    );
  }
}
