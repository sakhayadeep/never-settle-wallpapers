import 'package:flutter/material.dart';
import 'package:never_settle/search_page_manager.dart';
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

  final TextEditingController _searchController = new TextEditingController();

  @override
  void initState() {
    _changeThemeStatus = widget._changeThemeStatus;
    _darkThemeEnabled = widget._darkThemeEnabled;
    super.initState();
  }

  void _onSearchPressed(){
    FocusScope.of(context).requestFocus(new FocusNode());
    if(_searchController.text.isNotEmpty){

      String searchKeywords = Uri.encodeQueryComponent(_searchController.text);
    
      Navigator.push(context,
      new MaterialPageRoute(
        builder: (context){
          return SearchPageManager(searchKeyWords: searchKeywords,);
        }
      )
      );

    }
    else
      print("empty");
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
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.search)),
            title: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search wallpapers',
              ),
              enableInteractiveSelection: true,
              textInputAction: TextInputAction.search,
              onEditingComplete: (){
                _onSearchPressed();
              },
            ),
          )
        ],
      ),
    );
  }
}
