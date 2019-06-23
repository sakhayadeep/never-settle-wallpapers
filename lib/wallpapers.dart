import 'dart:collection';

import 'package:flutter/material.dart';

import './fullscreen_image.dart';

class Wallpapers extends StatefulWidget {
  final HashMap<String, List<String>> wallpapers;
  final List thumbUrls;

  Wallpapers(this.wallpapers, this.thumbUrls);

  @override
  State<StatefulWidget> createState() {
    return _WallpapersState();
  }
}

class _WallpapersState extends State<Wallpapers>{
  List thumbUrls = new List<String>();
  HashMap<String, List<String>> wallpapers;

  @override
  void initState() {
    wallpapers = widget.wallpapers;
    thumbUrls = widget.thumbUrls;
    super.initState();
  }

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
                          ? 2
                          : 3,
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
                                        return new FullScreenImagePage(wallpapers[urlThumb]);//Map wallpaper = {url_thumb : [id, url_image]}
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
