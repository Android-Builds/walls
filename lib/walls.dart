import 'package:flutter/material.dart';

class MobileWalls extends StatelessWidget {

  MobileWalls({@required this.label, this.data});
  
  final String label;
  final List data;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    final int length = data.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          label,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverPadding(
                padding: const EdgeInsets.all(10),
                sliver: SliverGrid.count(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  childAspectRatio: (itemWidth / itemHeight),
                  children: List.generate(length, (index){
                    return Center(
                      child: Image.network(data[index]["largeImageURL"]),
                    );
                  }),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

