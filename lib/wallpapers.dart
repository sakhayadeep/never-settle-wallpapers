import 'package:flutter/material.dart';

class Wallpapers extends StatelessWidget {
  final List<String> wallpapers;

  Wallpapers(this.wallpapers);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: wallpapers
          .map((element) => Card(
                child: Column(
                  children: <Widget>[new Image.network(element)],
                ),
              ))
          .toList(),
    );
  }
}
