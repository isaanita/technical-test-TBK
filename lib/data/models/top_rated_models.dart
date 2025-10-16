class TopRatedModels {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;
  final double voteAverage;
  final int voteCount;
  final List<int> genreIds;
  final bool adult;
  final bool video;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;

  TopRatedModels({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.voteCount,
    required this.genreIds,
    required this.adult,
    required this.video,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
  });

  factory TopRatedModels.fromJson(Map<String, dynamic> json) {
    return TopRatedModels(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['name'] ?? 'Untitled',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] is num)
          ? (json['vote_average'] as num).toDouble()
          : 0.0,
      voteCount: json['vote_count'] ?? 0,
      genreIds: (json['genre_ids'] is List)
          ? List<int>.from(json['genre_ids'])
          : [],
      adult: json['adult'] ?? false,
      video: json['video'] ?? false,
      originalLanguage: json['original_language'] ?? '',
      originalTitle: json['original_title'] ?? '',
      popularity: (json['popularity'] is num)
          ? (json['popularity'] as num).toDouble()
          : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'poster_path': posterPath,
      'backdrop_path': backdropPath,
      'release_date': releaseDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'genre_ids': genreIds,
      'adult': adult,
      'video': video,
      'original_language': originalLanguage,
      'original_title': originalTitle,
      'popularity': popularity,
    };
  }

  /// Helper buat parsing list langsung dari response TMDB
  static List<TopRatedModels> fromJsonList(Map<String, dynamic> json) {
    if (json['results'] == null) return [];
    return (json['results'] as List)
        .map((e) => TopRatedModels.fromJson(e))
        .toList();
  }
}
