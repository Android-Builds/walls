import 'package:flutter/material.dart';
import 'package:walls/constants.dart';
import 'package:walls/image_card.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
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
                    Expanded(
                      child: ImageCard(
                        link: 'https://c0.wallpaperflare.com/preview/690/207/730/monument-india-new-delhi-qutub-minar.jpg',
                        api: prefix+'India'+suffix,
                        label: 'India',
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
  );
  }
}