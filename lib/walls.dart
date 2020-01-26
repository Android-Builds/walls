import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walls/wall_cards.dart';

class MobileWalls extends StatefulWidget {
  MobileWalls({@required this.label, this.api});
  final String label, api;

  @override
  _MobileWallsState createState() => _MobileWallsState();
}

class _MobileWallsState extends State<MobileWalls> {
  
  List data = new List();

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
      data.addAll(toJsonData['hits']);
      });
    }
    print(response.body);
    return "Success";
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: WallCards(item: data,),
      );
  }  
}