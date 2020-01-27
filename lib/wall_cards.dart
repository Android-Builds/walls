import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WallCards extends StatefulWidget {
  final List item;
  final String api;
  WallCards({this.item, this.api});
  @override
  _WallCardsState createState() => _WallCardsState();
}

class _WallCardsState extends State<WallCards> {   
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

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    int itemCount = data.length;

  //TODO: Make Image corners rounded 
  return Padding(
    padding: EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 5,
        mainAxisSpacing: 7,
        childAspectRatio: (itemWidth / itemHeight),
        children: List.generate(itemCount, (index) {
          return Center(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: SimpleDialog(
                          backgroundColor: Colors.transparent,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Container(
                                  child: LinearProgressIndicator(),
                                  color: Colors.white,
                                  height: 500.0,
                                  width: 300.0,
                                ),
                                imageUrl: data[index]['largeImageURL'],
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            FloatingActionButton(),
                          ],
                        ),
                      );
                    }
                  );
                });
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) => CircularProgressIndicator(),
                  imageUrl: data[index]['previewURL'],
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}


