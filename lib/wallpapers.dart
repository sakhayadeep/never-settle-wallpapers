import 'package:flutter/material.dart';

class Wallpapers extends StatelessWidget {
  final List<String> wallpapers;

  Wallpapers(this.wallpapers);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: wallpapers
          .map((element) => Card(
                child: Container(
                    decoration: BoxDecoration(color: Colors.black26),
                    child: new Image.network(
                      element,
                      width: 500,
                      height: 270,
                    )),
              ))
          .toList(),
    );
  }
}
