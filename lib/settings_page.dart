import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget{
  final Function changeThemeStatus;
  final bool darkThemeEnabled;
  //final bool changeWallpaperDaily = true;

  SettingsPage({@required this.changeThemeStatus, @required this.darkThemeEnabled});

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage>{
  Function _changeThemeStatus;
  bool _darkThemeEnabled;
  //bool _changeWallpaperDaily;

  @override
  void initState() {
    _changeThemeStatus = widget.changeThemeStatus;
    _darkThemeEnabled = widget.darkThemeEnabled;
    //_changeWallpaperDaily = widget.changeWallpaperDaily;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings'),),
      body: Column(
        children: <Widget>[
          Card(
            child: ListTile(
              leading: Icon(Icons.brightness_6),
              title: Text('Dark Theme'),
              trailing: Switch(
                value: _darkThemeEnabled,
                onChanged: (changedTheme) {
                  _darkThemeEnabled = _darkThemeEnabled ? false : true;
                  _changeThemeStatus(_darkThemeEnabled);
                },
              ),
            ),
          ),
          /*Card(
            child: ListTile(
              leading: Icon(Icons.event_available),
              title: Text('Change Wallpaper Daily'),
              trailing: Switch(
              value: _changeWallpaperDaily,
              onChanged: (changed) {
                _changeWallpaperDaily = changed;
              },
            ),
            ),
          )*/
        ],
      ),
      bottomSheet: Card(
        child: ListTile(
          title: InkWell(
            child: Text("Powered By Wallpaper Abyss",textScaleFactor: 0.8, style: TextStyle(fontStyle: FontStyle.italic),),
            onTap: () async {
              if (await canLaunch("https://wall.alphacoders.com")) {
                await launch("https://wall.alphacoders.com");
              }
            },
          ),
        ),
      ),
    );
  }
}
