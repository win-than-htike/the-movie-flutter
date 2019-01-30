
class Trailer {

  String id;
  String key;
  String name;

  Trailer({this.id, this.key, this.name});

  static List<Trailer> fromJson(List<dynamic> json) {

      List<Trailer> trailerList = List();

      for(dynamic trailer in json) {
        var m = Trailer(
          id: trailer['id'],
          key: trailer['key'],
          name: trailer['name'],
        );
        trailerList.add(m);
      }

      return trailerList;

  }

}