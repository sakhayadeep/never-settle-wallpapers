import 'package:flutter/material.dart';

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
              child: OrientationBuilder(
                builder: (context, orientation) {
                  print(orientation == Orientation.portrait);
                  return Container(
                    child: GridView.count(
                      crossAxisCount:
                          orientation == Orientation.portrait ? 3 : 4,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      childAspectRatio: .5,
                      children: wallpapers
                          .map((element) => Card(
                                child: Container(
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: new Image.network(
                                      element,
                                      fit: BoxFit.cover,
                                    )),
                              ))
                          .toList(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
