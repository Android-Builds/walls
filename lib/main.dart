import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:walls/constants.dart';
import 'package:walls/home_page.dart';
import 'package:walls/set_wall.dart';
import 'package:walls/wall_cards.dart';
import 'nav_bar_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Walls'),
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
                )
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