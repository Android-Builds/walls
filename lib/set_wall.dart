import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

void main() =>
    runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SetWall()));

class SetWall extends StatefulWidget {
  SetWall({this.link});
  final String link;
  @override
  _SetWall createState() => _SetWall();
}

class _SetWall extends State<SetWall> {
  String home = "Home Screen",
      lock = "Lock Screen",
      both = "Both Screen",
      system="System";

  Stream<String> progressString;
  String res;
  bool downloading = false;
  var result = "Waiting to set wallpaper";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
          Stack(
            children: <Widget>[
              FittedBox(
                fit: BoxFit.fill,
                child: Image.network(
                  widget.link,
                  // fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: 10,
                bottom: 0,
                child: RaisedButton(
                  onPressed: () {
                    progressString =
                        Wallpaper.ImageDownloadProgress(widget.link);
                    progressString.listen((data) {
                      setState(() {
                        res = data;
                        downloading = true;
                      });
                      print("DataReceived: " + data);
                    }, onDone: () async {
                      home = await Wallpaper.homeScreen();
                      setState(() {
                        downloading = false;
                        home = home;
                      });
                      print("Task Done");
                    }, onError: (error) {
                      setState(() {
                        downloading = false;
                      });
                      print("Some Error");
                    });
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF0D47A1),
                            Color(0xFF1976D2),
                            Color(0xFF42A5F5),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(home, style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ),
              ),
              downDialog()
            ],
          ),
      ),
    );
  }

  Widget downDialog() {
    return Positioned(
      top: 250,
      left: 100,
      child: downloading
          ? Container(
        height: 120.0,
        width: 200.0,
        child: Card(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(height: 20.0),
              Text(
                "Downloading File : $res",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      )
          : Text(""),
    );
  }
}
