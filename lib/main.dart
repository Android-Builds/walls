import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:walls/image_card.dart';
import 'package:http/http.dart' as http;
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  Map map;
  List<dynamic> data;

  Future getData() async {
    var response = await http.get(
    Uri.encodeFull(
      'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=phone+wallpapers&image_type=photo&page=1')
    );
    map = json.decode(response.body);
    data = map["hits"];

    for(int i=2; i<5; i++)
    {
      var response = await http.get(
      Uri.encodeFull(
        'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=phone+wallpapers&image_type=photo&page='+i.toString())
      );
      map = json.decode(response.body);
      data.addAll(map["hits"]);
    }
    return data;
  }

  // @override
  // void initState() {
  //   getData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //getData();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            )
          ],
        ),
      ),
      body:Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ImageCard(
                      link: 'https://wallpaperaccess.com/full/200447.jpg', 
                      label: 'Nature',
                      //data: data,
                      api: 'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=phone+wallpapers&image_type=photo&page=1',
                      ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}