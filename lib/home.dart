import 'package:flutter/material.dart';
import 'package:the_movie/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie_detail.dart';

class HomePage extends StatefulWidget {

  final String category;

  HomePage(this.category);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _isLoading = true;

  List<Movie> movies = List(0);

  _fetchData() async {

    print("c ==> ${widget.category}");
    final url = "https://api.themoviedb.org/3/movie/${widget.category}?api_key=67e10f963247313db2a79cd4368c1d9f&language=en-US&page=1";
    final response = await http.get(url);

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      this.movies = Movie.fromJson(data['results']);
      print(this.movies);
      if (this.mounted) {
        setState(() {
          _isLoading = false;
        });
      }

    }

  }

  @override
    void initState() {
      super.initState();
      print("category " + widget.category);
      _fetchData();
    }

  @override
  Widget build(BuildContext context) {

    createTitle(Movie movie) => Hero(
        tag: movie.title,
        child: Material(
          elevation: 15.0,
          shadowColor: Colors.yellow.shade900,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => MovieDetail(movie)
              ));
            },
            child: Image(
              image: NetworkImage("http://image.tmdb.org/t/p/w500" + movie.poster),
              fit: BoxFit.cover,
            ),
          ),
        ),
    );

    final grid = CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverGrid.count(
            childAspectRatio: 2 / 3,
            crossAxisCount: 3,
            mainAxisSpacing: 20.0,
            crossAxisSpacing: 20.0,
            children: this.movies.map((movie) => createTitle(movie)).toList(),
          ),
        )
      ],
    );

    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator()) : grid
    );
    
  }

}