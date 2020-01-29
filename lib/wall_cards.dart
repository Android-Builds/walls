import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walls/setwalls.dart';

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

  return GridView.count(
    crossAxisCount: 1,
    // crossAxisSpacing: 5,
    // mainAxisSpacing: 7,
    // childAspectRatio: 1,
    children: List.generate(itemCount, (index) {
      return Container(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        child: GestureDetector(
          onTap: (){
            Navigator.push(
              context, MaterialPageRoute(
                builder: (context) => SetWallpaper(
                  link: item[index]['largeImageURL'],
                  ),
                ),
              );
            },
          child: ClipRRect(
            //borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              //placeholder: (context, url) => CircularProgressIndicator(),
              imageUrl: item[index]['largeImageURL'],
              // width: double.infinity,
              // height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }),
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


