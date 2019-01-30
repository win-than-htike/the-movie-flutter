import 'package:flutter/material.dart';
import 'package:the_movie/movie.dart';
import 'package:the_movie/trailer.dart';
import 'dart:convert';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:http/http.dart' as http;

class TrailerCell extends StatefulWidget {

  final Movie movie;

  TrailerCell(this.movie);

  @override
  _TrailerCellState createState() => _TrailerCellState();
}

class _TrailerCellState extends State<TrailerCell> {
  var videos;

  Future<List<Trailer>> _fetchData() async {
    final url = "https://api.themoviedb.org/3/movie/${widget.movie.id}/videos?api_key=67e10f963247313db2a79cd4368c1d9f&language=en-US";
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videosJson = map["results"];
      return Trailer.fromJson(videosJson);
    }

    return List();
  }

  @override
    void initState() {
      super.initState();
      _fetchData();
    }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<List<Trailer>>(
      future: _fetchData(),
      builder: (context, snapShot) {
        if (snapShot.hasData) {
            var list = snapShot.data;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () { 
                    FlutterYoutube.playYoutubeVideoByUrl(
                      apiKey: "AIzaSyDqILbU82SXBJzEU7aV4HurhrgG0q8UyDk",
                      videoUrl: "https://www.youtube.com/watch?v=${list[index].key}",
                    );  
                  },
                  child: Container(
                    width: 300.0,
                    height: 200.0,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                height: 120.0,
                                width: 300.0,
                                child: Image(image: NetworkImage("http://image.tmdb.org/t/p/w500" + widget.movie.backdropPath), fit: BoxFit.cover),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child:   Text(list[index].name),
                            )
                          ],
                        ),
                      ),
                    )
                  ),
                );
              },
            );
            // return Column(
            //   children: list.map((t) {
            //     return ListTile(
            //       title: Text(t.name),
            //     );
            //   }).toList(),
            // );
        } else if(snapShot.hasError) {
          return  Text("Error");
        }

        return Center(child: CircularProgressIndicator());
      },
    );

  }

    // text(String data,
    //     {Color color = Colors.black87,
    //     num size = 14,
    //     EdgeInsetsGeometry padding = EdgeInsets.zero,
    //     bool isBool = false}) => Padding(
    //       padding: padding,
    //       child: Text(data, style : TextStyle(
    //         color: color,
    //         fontSize: size.toDouble(),
    //         fontWeight: isBool ? FontWeight.bold : FontWeight.normal
    //       )),
    //     );

}