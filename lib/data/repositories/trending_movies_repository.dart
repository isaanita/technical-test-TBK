import 'package:technical_test_isaanita/data/models/trending_movies.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';

class TrendingRepository {
  final ApiService apiService;

  TrendingRepository(this.apiService);

  Future<List<TrendingMoviesModel>> fetchTrendingMoviesModel() async {
    final response = await apiService.fetchTrendingMovies();
    final List results = response['results'];

    return results.map((e) => TrendingMoviesModel.fromJson(e)).toList();
  }

  Future<List<TrendingMoviesModel>> fetchTrendingMoviesCategory() async {
    final response = await apiService.fetchTrendingMoviesCategory();
    final List results = response['results'];

    return results.map((e) => TrendingMoviesModel.fromJson(e)).toList();
  }

  Future<List<TrendingMoviesModel>> fetchTrendingTVCategory() async {
    final response = await apiService.fetchTrendingTVCategory();
    final List results = response['results'];

    return results.map((e) => TrendingMoviesModel.fromJson(e)).toList();
  }
}
