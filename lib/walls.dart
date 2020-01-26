import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:walls/wall_cards.dart';

// List<Walls> parseWalls(var responseBody) { 
//    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
//    return parsed.map<Walls>((json) => Walls.fromMap(json)).toList(); 
// } 
// Future<List<Walls>> fetchWalls() async { 
//    final response = await http.get(
//      Uri.encodeFull(
//        'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=phone+wallpapers&image_type=photo&page=1'
//        ),
//       );
//    if (response.statusCode == 200) { 
//       return parseWalls(response.body);
//    } else { 
//       throw Exception('Unable to fetch Walls from the REST API');
//    } 
// }

Future walls;

  Future fetchWalls() async {
    var response = await http.get(
    Uri.encodeFull(
      'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=phone+wallpapers&image_type=photo&page=1')
    );
    Map map = json.decode(response.body);
    walls = map["hits"].toList();

    // for(int i=2; i<5; i++)
    // {
    //   var response = await http.get(
    //   Uri.encodeFull(
    //     'https://pixabay.com/api/?key=15000771-9bb9ac0763d9ad28b6694f6d2&q=phone+wallpapers&image_type=photo&page='+i.toString())
    //   );
    //   map = json.decode(response.body);
    //   data.addAll(map["hits"]);
    // }
    //return data;
  }

class Walls {
  final String largeImageURL;
  final String previewURL;

  Walls(this.largeImageURL, this.previewURL);
  factory Walls.fromMap(Map<String, dynamic> json) { 
    return Walls(
      json['largeImageURL'], 
      json['previewURL'], 
      );
   }
}
class MobileWalls extends StatefulWidget {

  MobileWalls({@required this.label});

  final String label;

  @override
  _MobileWallsState createState() => _MobileWallsState();
}

class _MobileWallsState extends State<MobileWalls> {
  // Future<List<Walls>> walls;
  //Future walls;

  @override
  void initState() {
    super.initState();
    fetchWalls();
  }

  @override
  Widget build(BuildContext context) {
    //fetchWalls();
    // var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    // final double itemWidth = size.width / 2;
//    final int length = data.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.label,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: walls,
            builder: (context, snapshot) {
              // if (snapshot.hasError) print(snapshot.error);
              // return snapshot.hasData ? /*print('Yes')*/WallCards(items: snapshot.data):
              // /*:print('No');*/Center(child: CircularProgressIndicator());
              return Image.network(snapshot.data.previewURL);
            },
          ),
        ),
      ),
    );
  }
}