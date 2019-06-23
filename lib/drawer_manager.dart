import 'package:flutter/material.dart';

import './settings_page.dart';
import './search_page_manager.dart';
import './categories.dart';

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

  void _onSettingsPressed(){
    Navigator.push(context,
      new MaterialPageRoute(
        builder: (context){
          return SettingsPage(changeThemeStatus: _changeThemeStatus, darkThemeEnabled: _darkThemeEnabled,);
        }
      )
      );
  }

  void _onSearchPressed(){
    FocusScope.of(context).requestFocus(new FocusNode());
    if(_searchController.text.isNotEmpty){
    String searchKeywords = _searchController.text;
    Navigator.push(context,
      new MaterialPageRoute(
        builder: (context){
          return SearchPageManager(searchKeyWords: searchKeywords, method: 'search',);
        }
      )
      );

    }
    else
      print("empty");
  }

  void _onCategoriesPressed(){
    Navigator.push(context,
      new MaterialPageRoute(
        builder: (context){
          return Categories();
        }
      )
      );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              image:DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/DrawerBackground.png")
                ),
              ),
            child: Center(
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Image.asset("assets/NeverSettle.png"),
              ),
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
              onEditingComplete: () => _onSearchPressed(),
            ),
          ),
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.wallpaper),),
            title: Text("Categories"),
            onTap: () => _onCategoriesPressed(),
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.settings),
            ),
            title: Text("Settings"),
            onTap: () => _onSettingsPressed(),
          ),
        ],
      ),
    );
  }
}
