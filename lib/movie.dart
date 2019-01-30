import 'dart:core';

class Movie {

  int id;
  String title;
  String poster;
  String overview;
  String backdropPath;
  double rating;

  Movie({this.id, this.title, this.poster, this.overview, this.rating, this.backdropPath});

  static List<Movie> fromJson(List<dynamic> json) {

      List<Movie> movieList = List();

      for(dynamic movie in json) {
        var m = Movie(
          id: movie['id'],
          title: movie['title'],
          poster: movie['poster_path'],
          overview: movie['overview'],
          rating: double.parse(movie['vote_average'].toString()),
          backdropPath: movie['backdrop_path']
        );
        movieList.add(m);
        print(double.parse(movie['vote_average'].toString()));
      }

      return movieList;

  }

}