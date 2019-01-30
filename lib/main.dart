import 'package:flutter/material.dart';
import 'package:the_movie/movie.dart';
import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      elevation: .5,
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {

        },
      ),
      title: Text("The Movie"),
      actions: <Widget>[
        IconButton(
        icon: Icon(Icons.search),
        onPressed: () {

        },
      )
      ],
    );
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {

              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "Now Playing"),
                Tab(text: "Popular"),
                Tab(text: "Top Rated"),
                Tab(text: "Upcoming")
              ],
            ),
            title: Text('The Movies'),
          ),
          body: TabBarView(
            children: [
              HomePage("now_playing"),
              HomePage("popular"),
              HomePage("top_rated"),
              HomePage("upcoming")
            ],
          ),
        ),
      ),
    );
  }

}
