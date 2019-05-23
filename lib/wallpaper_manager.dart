import 'package:flutter/material.dart';

import './wallpapers.dart';

class WallpaperManager extends StatefulWidget {
  final String startingWallpaper;

  WallpaperManager(this.startingWallpaper);

  @override
  State<StatefulWidget> createState() {
    return _WallpaperManagerState();
  }
}

class _WallpaperManagerState extends State<WallpaperManager> {
  List<String> _wallpapers = [];

  @override
  void initState() {
    _wallpapers.add(widget.startingWallpaper);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: RaisedButton(
            color: Colors.deepPurple,
            onPressed: () {
              setState(() {
                _wallpapers.add("Selfie");
              });
            },
            child: Text("Press this"),
          ),
        ),
        Wallpapers(_wallpapers)
      ],
    );
  }
}
