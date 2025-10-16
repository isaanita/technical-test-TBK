import 'package:technical_test_isaanita/data/models/movie_detail_models.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';

class MovieDetailRepository {
  final ApiService apiService;

  MovieDetailRepository(this.apiService);

  /// Fetch single movie detail by movieId
  Future<MovieDetailModel> fetchMovieDetail(int movieId) async {
    try {
      final response = await apiService.fetchMovieDetails(movieId);
      return MovieDetailModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to fetch movie detail: $e');
    }
  }
}
