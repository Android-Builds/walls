import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:walls/walls.dart';

class WallCards extends StatelessWidget {
   final List item; 
   WallCards({this.item}); 
   
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
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(itemCount, (index) {
          return Center(
            child: GestureDetector(
              child: CachedNetworkImage(
                placeholder: (context, url) => CircularProgressIndicator(),
                imageUrl: item[index]['previewURL'],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.fitHeight,
              ),
            ),
          );
        }),
      ),
    );
  }
}

