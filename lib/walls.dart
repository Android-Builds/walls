import 'package:flutter/material.dart';
import 'package:walls/wall_cards.dart';

class MobileWalls extends StatefulWidget {
  MobileWalls({@required this.label, this.api});
  final String label, api;

  @override
  _MobileWallsState createState() => _MobileWallsState();
}

class _MobileWallsState extends State<MobileWalls> {
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
      body: WallCards(api: widget.api,),
      );
  }  
}