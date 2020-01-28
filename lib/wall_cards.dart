import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/wallpaper.dart';

class WallCards extends StatefulWidget {
  final String api;
  WallCards({this.api});
  @override
  _WallCardsState createState() => _WallCardsState();
}

class _WallCardsState extends State<WallCards> {   
  List item = new List();

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

  Future<String> getJsonData() async{
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
    return "Success";
  }

  @override 
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    int itemCount = item.length;

  return Padding(
    padding: EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 7,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(itemCount, (index) {
          return Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SimpleDialog(
                      backgroundColor: Colors.transparent,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                child: LinearProgressIndicator(),
                                color: Colors.white,
                                height: 500.0,
                                width: 300.0,
                              ),
                              imageUrl: item[index]['largeImageURL'],
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                          FloatingActionButton(),
                        ]
                        ),
                        // SizedBox(
                        //   height: 20.0,
                        // ),
                        // FloatingActionButton(
                        //   onPressed: () {
                        //     progressString =
                        //     Wallpaper.ImageDownloadProgress(item[index]['largeImageURL']);
                        //     progressString.listen((data) {
                        //       setState(() {
                        //         res = data;
                        //         downloading = true;  
                        //       });
                        //       print("DataReceived: " + data);
                        //     }, 
                        //     onDone: () async {
                        //       home = await Wallpaper.homeScreen();
                        //       setState(() {
                        //         downloading = false;
                        //         home = home;
                        //       });
                        //       print("Task Done");
                        //     }, 
                        //     onError: (error) {
                        //       setState(() {
                        //         downloading = false;
                        //       });
                        //       print("Some Error");
                        //     });
                        //   },
                        // ),
                      ],
                        );
                    }
                  );
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: item[index]['largeImageURL'],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget downDialog() {
    return Positioned(
      top: 200,
      left: 70,
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


