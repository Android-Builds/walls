import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:walls/image_card.dart';
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

  @override
  Widget build(BuildContext context) {

    String prefix = 'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=';
    String suffix = '&image_type=photo&page=';

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
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
      return SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 20.0,
          ),
          child: IntrinsicHeight(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: ImageCard(
                            link: 'https://wallpaperaccess.com/full/200447.jpg',
                            api: prefix+'Nature'+suffix,
                            label: 'Nature',
                          ),
                        ),
                        Expanded(
                          child: ImageCard(
                            link: 'https://wallpapercave.com/wp/wp2679565.jpg',
                            api: prefix+'Abstract'+suffix,
                            label: 'Abstract',
                          ),
                      ),
                  ],
                ),
              ],
            ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ImageCard(
                      link: 'https://www.digitalcare.org/wp-content/uploads/2016/11/Free-Desktop-Wallpaper-feature-696x465.jpg',
                      api: prefix+'Featured'+suffix,
                      label: 'Featured',
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: ImageCard(
                        link: 'https://wallpaperaccess.com/full/184117.jpg',
                        api: prefix+'Cars'+suffix,
                        label: 'Cars',
                      ),
                    ),
                    //TODO: Add few more cards
                    Expanded(
                      child: ImageCard(
                        link: 'https://wallpaperaccess.com/full/184117.jpg',
                        api: prefix+'Cars'+suffix,
                        label: 'Cars',
                      ),
                    ),
                  ],
                ),
              ),
          ]
          ),
        ),
      ));
    },
  ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
      ),
    );
  }
}