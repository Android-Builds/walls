import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:walls/constants.dart';
import 'package:walls/home_page.dart';
import 'package:walls/set_wall.dart';
import 'package:walls/wall_cards.dart';
import 'nav_bar_list.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

Brightness brightness = Brightness.light;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
        primarySwatch: Colors.indigo,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Flutter Demo',
          theme: theme,
          home: new MainPage(title: 'Walls'),
        );
      }
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({this.title});
  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Featured'),
    Tab(text: 'Categories'),
  ];

  bool darkModeIsOn = true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: myTabs.length,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
            ),
            bottom: TabBar(
              tabs: myTabs,
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 150.0,
                  child: DrawerHeader(
                    child: Text(
                      'Walls',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0
                        ),
                      ),
                    decoration: BoxDecoration(
                       color: Colors.blue,
                      ),
                    ),
                  ),
                NavBarList(
                  icon: Icons.cloud,
                  label: 'Nature',
                  ),
                NavBarList(
                  icon: FontAwesome.bandcamp,
                  label: 'Abstract',
                ),
                NavBarList(
                  label: 'Anime',
                ),
                ListTile(
                  title: Text('Hi'),
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SetWall(),
                        ),
                      );
                  },
                ),
                ListTile(
                  trailing: Switch(
                  value: darkModeIsOn,
                    onChanged: (bool value) {
                      setState(() {
                        DynamicTheme.
                        of(context).setBrightness(
                          Theme.of(context).brightness == 
                          Brightness.dark? Brightness
                          .light: Brightness.dark);
                        if(darkModeIsOn == true){
                          darkModeIsOn = false;
                        }
                        else {
                          brightness = Brightness.dark;
                          darkModeIsOn = true;
                        }
                      });
                      print('Switched');
                    }, 
                  ),
                  leading: Text(
                    'Dark Mode'
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              WallCards(
                api: prefix+'phone+wallpapers'+suffix,
              ),
              MyHomePage(),
            ],
          ),
        ),
    );
  }
}