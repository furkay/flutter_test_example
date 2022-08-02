class Movie {
  final String? title;
  final String? year;
  final String? imdbID;
  final String? type;
  final String? poster;

  const Movie({this.title, this.year, this.imdbID, this.type, this.poster});

  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
        title: json['Title'],
        year: json['Year'],
        imdbID: json['imdbID'],
        type: json['Type'],
        poster: json['Poster']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['Title'] = title;
    data['Year'] = year;
    data['imdbID'] = imdbID;
    data['Type'] = type;
    data['Poster'] = poster;
    return data;
  }
}
