import 'package:flutter/material.dart';
import 'package:walls/walls.dart';

class NavBarList extends StatelessWidget {

  NavBarList({this.icon, @required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileWalls(
              label: label
            ),
          ),
        );
      },
      leading: Icon(
        icon
      ),
      title: Text(
        label,
      ),
    );
  }
}