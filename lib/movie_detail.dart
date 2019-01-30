import 'package:flutter/material.dart';
import 'package:the_movie/movie.dart';
import 'package:the_movie/trailer_cell.dart';
import 'rating_bar.dart';
import 'dart:ui';

class MovieDetail extends StatefulWidget {

  final Movie movie;

  MovieDetail(this.movie);

  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {

  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      elevation: .5,
      title: Text("Details"),
      actions: <Widget>[
        IconButton(
        icon: Icon(Icons.search),
        onPressed: () {

        },
      )
      ],
    );


    final topLeft = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Hero(
            tag: widget.movie.title,
            child: Material(
              elevation: 8.0,
              shadowColor: Colors.yellow.shade900,
              child: Image(
                image: NetworkImage("http://image.tmdb.org/t/p/w500" + widget.movie.poster),
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ],
    );

    final topRight = Column(
      children: <Widget>[
        text('${widget.movie.title}',color: Colors.white, size: 16.0, isBool: true, padding: EdgeInsets.only(top: 16.0))
      ],
    );

    final topContent = Container(
      child: new Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            height: 250,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: new BoxDecoration(
                          image: new DecorationImage(
                          image: NetworkImage("http://image.tmdb.org/t/p/w500" + widget.movie.backdropPath),
                          fit: BoxFit.cover,
                      ),  
                    ),
                    child: new BackdropFilter(
                        filter: new ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: new Container(
                        decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ), 
                  )
                )
              ],
            )
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Flexible(
                  flex: 2,
                  child: topLeft,
              ),
              Flexible(
                  flex: 3,
                  child: topRight,
              )
            ],
          ),

        ],
      )
    );

    final bottomContent = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          text("Overview", color: Colors.black87, size: 16.0, padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0, top: 16.0), isBool: true),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
            child: Text(widget.movie.overview,
            style: TextStyle(fontSize: 12.0, height: 1.2)),
          ),
          text("Trailer", color: Colors.black87, size: 16.0, padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 4.0), isBool: true),
        ],
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          topContent,
          bottomContent,
          Container(
            height: 200.0,
            child: TrailerCell(widget.movie),
          )
        ],
      )
    );
  }

  text(String data,
        {Color color = Colors.black87,
        num size = 14,
        EdgeInsetsGeometry padding = EdgeInsets.zero,
        bool isBool = false}) => Padding(
          padding: padding,
          child: Text(data, style : TextStyle(
            color: color,
            fontSize: size.toDouble(),
            fontWeight: isBool ? FontWeight.bold : FontWeight.normal
          )),
        );


}