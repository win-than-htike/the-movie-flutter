import 'package:flutter/material.dart';
import 'package:the_movie/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularPage extends StatefulWidget {
  @override
  _PopularPageState createState() => _PopularPageState();
}

class _PopularPageState extends State<PopularPage> {

  List<Movie> movies = List(0);

  _fetchData() async {

    final url = "https://api.themoviedb.org/3/movie/popular?api_key=67e10f963247313db2a79cd4368c1d9f&language=en-US&page=1";
    final response = await http.get(url);

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      this.movies = Movie.fromJson(data['results']);
      if (this.mounted) {
        setState(() {

        });
      }

    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}