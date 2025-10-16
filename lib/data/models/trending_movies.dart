class TrendingMoviesModel {
  final int id;
  final String displayTitle;
  final String posterPath;
  final String backdropPath;
  final String overview;
  final String voteAverage; // GANTI ke String

  TrendingMoviesModel({
    required this.id,
    required this.displayTitle,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.voteAverage,
  });

  factory TrendingMoviesModel.fromJson(Map<String, dynamic> json) {
    return TrendingMoviesModel(
      id: json['id'] ?? 0,
      displayTitle: json['title'] ?? json['name'] ?? 'Untitled',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      overview: json['overview'] ?? '',
      voteAverage: json['vote_average']?.toString() ?? '0.0', // <— AMAN
    );
  }
}
