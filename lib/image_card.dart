import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:walls/walls.dart';

class ImageCard extends StatelessWidget {

  ImageCard({@required this.link, @required this.label, this.api});

  final String link, label, api;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MobileWalls(
              label: label,
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
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: link,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitHeight,
              )
              // Image.network(
              //   link,
              //   width: double.infinity,
              //   height: double.infinity,
              //   fit: BoxFit.cover,
              // ),
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