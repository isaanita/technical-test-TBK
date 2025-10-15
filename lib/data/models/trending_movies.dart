class TrendingMoviesModel {
  final int id;
  final String title;
  final String? name;
  final String posterPath;
  final String backdropPath;
  final String overview;

  TrendingMoviesModel({
    required this.id,
    required this.title,
    this.name,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
  });

  factory TrendingMoviesModel.fromJson(Map<String, dynamic> json) {
    return TrendingMoviesModel(
      id: json['id'],
      title: json['title'] ?? json['name'] ?? '',
      name: json['name'],
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
    );
  }
}
