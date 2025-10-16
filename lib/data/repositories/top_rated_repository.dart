import 'package:technical_test_isaanita/data/models/top_rated_models.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';

class TopRatedRepository {
  final ApiService apiService;

  TopRatedRepository(this.apiService);

  Future<List<TopRatedModels>> fetchTopRatedMovies() async {
    final response = await apiService.fetchTopRated();
    final List results = response['results'];

    return results.map((e) => TopRatedModels.fromJson(e)).toList();
  }
}