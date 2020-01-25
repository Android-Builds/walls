import 'package:flutter/material.dart';

class MobileWalls extends StatelessWidget {

  MobileWalls({this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
    );
  }
}

