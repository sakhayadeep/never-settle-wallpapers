import 'dart:collection';

import 'package:flutter/material.dart';

import './fullscreen_image.dart';

class Wallpapers extends StatefulWidget {
  final HashMap<String, String> wallpapers;
  final List thumbUrls;
  final Function updateList;

  Wallpapers(this.wallpapers, this.thumbUrls, this.updateList);

  @override
  State<StatefulWidget> createState() {
    return _WallpapersState();
  }
}

class _WallpapersState extends State<Wallpapers>{
  List thumbUrls = new List<String>();
  HashMap<String, String> wallpapers;
  Function updateList;

  @override
  void initState() {
    wallpapers = widget.wallpapers;
    thumbUrls = widget.thumbUrls;
    updateList = widget.updateList;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateList();
    print("list length = ${thumbUrls.length}");
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
                  children: thumbUrls
                      .map((urlThumb) => Card(
                            child: Container(
                                decoration: BoxDecoration(color: Colors.white),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(context,
                                          new MaterialPageRoute(
                                              builder: (context) {
                                        return new FullScreenImagePage(wallpapers[urlThumb]);//Map wallpaper = {url_thumb : url_image}
                                      })),
                                  child: new Image.network(
                                    urlThumb,
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
