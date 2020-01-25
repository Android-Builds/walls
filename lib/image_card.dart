import 'package:flutter/material.dart';
import 'package:walls/walls.dart';

class ImageCard extends StatelessWidget {

  ImageCard({@required this.link, @required this.label, this.data});

  final String link, label;
  final List data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileWalls(
              label: label,
              data: data,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(15.0),
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                link,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}