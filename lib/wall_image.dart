import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class WallImage extends StatefulWidget {
  @override
  WallImageState createState() => WallImageState();
}

class WallImageState extends State<WallImage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Container(
      //   padding: const EdgeInsets.symmetric(vertical: 10.0),
      //   constraints: const BoxConstraints(maxHeight: 200.0),
      //   child: ListView(
      //     controller: _controller,
      //     scrollDirection: Axis.horizontal,
      //     children: [
      //     ParallaxImage(
      //       image: NetworkImage('https://cdn.droidviews.com/wp-content/uploads/2019/07/asus-rog-phone-2-wall-droidviews-07.jpg'),
      //       extent: 100.0,
      //       child: Text('January'),
      //       controller: _controller,
      //     ),
      //   ]),
      // ),
      body: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "http://via.placeholder.com/288x188",
            fit: BoxFit.fill,
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}