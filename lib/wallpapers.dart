import 'package:flutter/material.dart';

import './fullscreen_image.dart';

class Wallpapers extends StatelessWidget {
  final List<String> wallpapers;

  Wallpapers(this.wallpapers);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 10, // Set as you want or you can remove it also.
                maxHeight: double.infinity,
              ),
              child: Container(
                child: GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 3
                          : 4,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: .6,
                  children: wallpapers
                      .map((element) => Card(
                            child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(context,
                                          new MaterialPageRoute(
                                              builder: (context) {
                                        RegExp exp = new RegExp(r".*jpeg");
                                        String match =
                                            exp.stringMatch(element).toString();
                                        return new FullScreenImagePage(match);
                                      })),
                                  child: new Image.network(
                                    element,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
