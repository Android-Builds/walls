import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class SetWallpaper extends StatefulWidget {
  SetWallpaper({this.link});
  final String link;
  @override
  _SetWallpaperState createState() => _SetWallpaperState();
}

class _SetWallpaperState extends State<SetWallpaper> {
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
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Image.network(widget.link),
            ),
            SpeedDial(
            // both default to 16
              marginRight: 30,
              marginBottom: 30,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              // this is ignored if animatedIcon is non null
              // child: Icon(Icons.add),
              visible: true,
              // If true user is forced to close dial manually
              // by tapping main button and overlay is not rendered.
              closeManually: false,
              curve: Curves.easeInToLinear,
              overlayColor: Colors.white,
              overlayOpacity: 0.6,
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              elevation: 8.0,
              animationSpeed: 100,
              shape: CircleBorder(),
              children: [
              SpeedDialChild(
                child: Icon(Icons.wallpaper),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                label: 'Wallpaper',
                labelBackgroundColor: Theme.of(context).backgroundColor,
                labelStyle: TextStyle(fontSize: 12.0),
                onTap: () {
                  progressString =
                    Wallpaper.ImageDownloadProgress(widget.link);
                  progressString.listen((data) {
                    setState(() {
                      res = data;
                      downloading = true;
                    });
                    print("DataReceived: " + data);
                  }, 
                  onDone: () async {
                    home = await Wallpaper.homeScreen();
                    setState(() {
                      downloading = false;
                      home = home;
                      Fluttertoast.showToast(
                        msg: "Wallpaper Set",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 14.0
                      );
                    });
                    print("Task Done");
                    }, 
                  onError: (error) {
                    setState(() {
                      downloading = false;
                    });
                    print("Some Error");
                  });
                }
              ),
              SpeedDialChild(
                child: Icon(Icons.lock),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                label: 'Lockscreen',
                labelBackgroundColor: Theme.of(context).backgroundColor,
                labelStyle: TextStyle(fontSize: 12.0),
                onTap: () {
                  progressString =
                    Wallpaper.ImageDownloadProgress(widget.link);
                  progressString.listen((data) {
                    setState(() {
                      res = data;
                      downloading = true;
                    });
                    print("DataReceived: " + data);
                  }, 
                  onDone: () async {
                    lock = await Wallpaper.lockScreen();
                    setState(() {
                      downloading = false;
                      lock = lock;
                      Fluttertoast.showToast(
                        msg: "Lockscreen Set",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 14.0
                      );
                    });
                    print("Task Done");
                    }, 
                  onError: (error) {
                    setState(() {
                      downloading = false;
                    });
                    print("Some Error");
                  });
                }
              ),
              SpeedDialChild(
                child: Icon(Icons.system_update_alt),
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                label: 'Both',
                labelBackgroundColor: Theme.of(context).backgroundColor,
                labelStyle: TextStyle(fontSize: 12.0),
                onTap: () {
                  progressString =
                    Wallpaper.ImageDownloadProgress(widget.link);
                  progressString.listen((data) {
                    setState(() {
                      res = data;
                      downloading = true;
                    });
                    print("DataReceived: " + data);
                  }, 
                  onDone: () async {
                    both = await Wallpaper.bothScreen();
                    setState(() {
                      downloading = false;
                      both = both;
                      Fluttertoast.showToast(
                        msg: "Wallpaper and Lockscreen Set",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIos: 1,
                        backgroundColor: Colors.white,
                        textColor: Colors.black,
                        fontSize: 14.0
                      );
                    });
                    print("Task Done");
                    }, 
                  onError: (error) {
                    setState(() {
                      downloading = false;
                    });
                    print("Some Error");
                  });
                }
              ),
            ],
          ),
          downDialog(),
          ],
        ),
      )
    );
  }

  Widget downDialog() {
  return Positioned(
    top: 300,
    left: 120,
    child: downloading
      ? Container(
        height: 150.0,
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
              ),
            ],
          ),
        ),
      )
      : Text(""),
    );
  }
}