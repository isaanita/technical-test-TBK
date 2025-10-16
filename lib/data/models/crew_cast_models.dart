class CrewCastModel {
  final int id;
  final String name;
  final String originalName;
  final String? profilePath;
  final String character;
  final String knownForDepartment;
  final int gender;
  final int order;
  final bool adult;
  final double popularity;

  CrewCastModel({
    required this.id,
    required this.name,
    required this.originalName,
    required this.profilePath,
    required this.character,
    required this.knownForDepartment,
    required this.gender,
    required this.order,
    required this.adult,
    required this.popularity,
  });

  factory CrewCastModel.fromJson(Map<String, dynamic> json) {
    return CrewCastModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      originalName: json['original_name'] ?? '',
      profilePath: json['profile_path'],
      character: json['character'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      gender: json['gender'] ?? 0,
      order: json['order'] ?? 0,
      adult: json['adult'] ?? false,
      popularity: (json['popularity'] ?? 0).toDouble(),
    );
  }
}
