import 'package:cached_network_image/cached_network_image.dart';
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
              marginRight: 18,
              marginBottom: 20,
              animatedIcon: AnimatedIcons.menu_close,
              animatedIconTheme: IconThemeData(size: 22.0),
              // this is ignored if animatedIcon is non null
              // child: Icon(Icons.add),
              visible: true,
              // If true user is forced to close dial manually
              // by tapping main button and overlay is not rendered.
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen: () => print('OPENING DIAL'),
              onClose: () => print('DIAL CLOSED'),
              tooltip: 'Speed Dial',
              heroTag: 'speed-dial-hero-tag',
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 8.0,
              shape: CircleBorder(),
              children: [
              SpeedDialChild(
                child: Icon(Icons.wallpaper),
                backgroundColor: Colors.red,
                label: 'Wallpaper',
                labelStyle: TextStyle(fontSize: 18.0),
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
                backgroundColor: Colors.blue,
                label: 'Lockscreen',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('SECOND CHILD'),
              ),
              SpeedDialChild(
                child: Icon(Icons.system_update_alt),
                backgroundColor: Colors.green,
                label: 'Both',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => print('THIRD CHILD'),
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