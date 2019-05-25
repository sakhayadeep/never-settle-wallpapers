import 'package:flutter/material.dart';

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
            decoration: BoxDecoration(color: Colors.orange),
            child: Center(
              child: ListTile(
                title: Image.network(
                    "https://www.pexels.com/assets/pexels-logo-7e4af4630e66b6b786567041874586aeb1b5217589035c70a0def15aacd0f11a.png"),
                subtitle: Text("www.pexels.com"),
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
