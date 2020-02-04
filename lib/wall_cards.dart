import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/wallpaper.dart';
import 'package:walls/constants.dart';
import 'dart:async';

class WallCards extends StatefulWidget {
  final String api;
  WallCards({this.api});
  @override
  _WallCardsState createState() => _WallCardsState();
}

class _WallCardsState extends State<WallCards> {   
  List item = new List();
  int wallIndex = 0;

  String home = "Home Screen",
    lock = "Lock Screen",
    both = "Both Screen",
    system="System";
  String res;
  bool downloading = false;
  var result = "Waiting to set wallpaper";
  Stream<String> progressString;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future getJsonData() async{
    var response;
    for(int i=1; i<=5; i++){
      response = await http.get(
        Uri.encodeFull(widget.api+i.toString()),
        headers: {"Accept": "application/json"}
      );
      setState(() {
      var toJsonData = json.decode(response.body);
      item.addAll(toJsonData['hits']);
      });
    }
    print(response.body);
    return item;
  }

  @override 
  Widget build(BuildContext context) {
  // return GridView.count(
  //   crossAxisCount: 1,
  //   // crossAxisSpacing: 5,
  //   // mainAxisSpacing: 7,
  //   // childAspectRatio: 1,
  //   children: List.generate(itemCount, (index) {
  //     return Container(
  //       // width: MediaQuery.of(context).size.width,
  //       // height: MediaQuery.of(context).size.height,
  //       child: GestureDetector(
  //         onTap: (){
  //           Navigator.push(
  //             context, MaterialPageRoute(
  //               builder: (context) => SetWallpaper(
  //                 link: item[index]['largeImageURL'],
  //                 ),
  //               ),
  //             );
  //           },
  //         child: ClipRRect(
  //           //borderRadius: BorderRadius.circular(8.0),
  //           child: CachedNetworkImage(
  //             //placeholder: (context, url) => CircularProgressIndicator(),
  //             imageUrl: item[index]['largeImageURL'],
  //             // width: double.infinity,
  //             // height: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //     );
  //   }),
  // );

  return Stack(
    children: <Widget>[
      Container(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Swiper(
          onIndexChanged: (index){
            wallIndex = index;
            print(wallIndex);
          },
          containerHeight: 100.0,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                placeholder: (context, url) => LinearProgressIndicator(),
                imageUrl: item[index]['largeImageURL'],
                fit: BoxFit.fill,
              ),
            );
          },
          viewportFraction: 0.8,
          scale: 0.9,
        ),
      ),
      SpeedDial(
        marginRight: 180.0,
        marginBottom: 30,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: true,
        closeManually: false,
        curve: Curves.easeInToLinear,
        overlayColor: Colors.white,
        overlayOpacity: 0.6,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Theme.of(context).backgroundColor,
        foregroundColor: getColor(context),
        elevation: 8.0,
        animationSpeed: 100,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.wallpaper),
            backgroundColor: Theme.of(context).backgroundColor,
            foregroundColor: getColor(context),
            label: 'Wallpaper',
            labelBackgroundColor: Theme.of(context).backgroundColor,
            labelStyle: TextStyle(fontSize: 12.0),
            onTap: () {
              progressString =
                      Wallpaper.ImageDownloadProgress(item[wallIndex]['largeImageURL']);
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
            backgroundColor: Theme.of(context).backgroundColor,
            foregroundColor: getColor(context),
            label: 'Lockscreen',
            labelBackgroundColor: Theme.of(context).backgroundColor,
            labelStyle: TextStyle(fontSize: 12.0),
            onTap: () {
              progressString =
                Wallpaper.ImageDownloadProgress(item[wallIndex]['largeImageURL']);
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
              backgroundColor: Theme.of(context).backgroundColor,
              foregroundColor: getColor(context),
              label: 'Both',
              labelBackgroundColor: Theme.of(context).backgroundColor,
              labelStyle: TextStyle(fontSize: 12.0),
              onTap: () {
                progressString =
                  Wallpaper.ImageDownloadProgress(item[wallIndex]['largeImageURL']);
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
      ]
    );
  }

  Widget downDialog() {
  return Positioned(
    top: 200,
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


