import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerManager extends StatefulWidget {
  final Function _changeThemeStatus;
  final bool _darkThemeEnabled;
  DrawerManager(this._changeThemeStatus, this._darkThemeEnabled);

  @override
  State<StatefulWidget> createState() {
    return _DrawerManagerState();
  }
}

class _DrawerManagerState extends State<DrawerManager> {
  Function _changeThemeStatus;
  bool _darkThemeEnabled;

  @override
  void initState() {
    _changeThemeStatus = widget._changeThemeStatus;
    _darkThemeEnabled = widget._darkThemeEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Image.asset("assets/NeverSettle.png"),
                trailing: InkWell(
                          child: Text("Powered By Wallpaper Abyss"),
                          onTap: () async {
                            if (await canLaunch("https://wall.alphacoders.com")) {
                              await launch("https://wall.alphacoders.com");
                            }
                          },
                        ),
              ),
            ),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.brightness_4),
            ),
            title: Text("Dark Theme"),
            trailing: Switch(
              value: _darkThemeEnabled,
              onChanged: (changedTheme) {
                _darkThemeEnabled = _darkThemeEnabled ? false : true;
                _changeThemeStatus();
              },
            ),
          )
        ],
      ),
    );
  }
}
