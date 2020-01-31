import 'package:flutter/material.dart';
import 'custom/telegram_icons.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('assets/debjit.jpg'),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                  'Debjit Chakraborty',
                style: TextStyle(
                  fontFamily: 'ShadowsIntoLight',
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'STUDENT DEVELOPER',
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 20.0,
                  color: Colors.grey,
                  letterSpacing: 2.0
                ),
              ),
              SizedBox(
                height: 20.0,
                width: 150.0,
                child: Divider(
                  color: Colors.white,
                ),
              ),
              FlatButton(onPressed: (){
                
              },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, 
                      horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      color: Colors.black,
                    ),
                    title: Text(
                      '',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSansPro'
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0,
                      horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    title: Text(
                      'zxyron0@gmail.com',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSansPro'
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0,
                      horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Telegram.telegram,
                      color: Colors.black,
                    ),
                    title: Text(
                      'xyron',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSansPro'
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

