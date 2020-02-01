import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';
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
                _launchURL('https://www.facebook.com/insane.nihilist');
              },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 10.0, 
                      horizontal: 25.0),
                  child: ListTile(
                    leading: Icon(
                      FontAwesome.facebook,
                      color: Colors.black,
                    ),
                    title: Text(
                      'Debjit',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'SourceSansPro'
                      ),
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () async {
                  await FlutterEmailSender.send(email);
                },
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
                onPressed: (){
                  _launchURL('https://t.me/xyron');
                },
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

  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final Email email = Email(
    body: 'Email body',
    subject: 'Email subject',
    recipients: ['zxyron0@gmail.com'],
    //isHTML: false,
  );
  
}

