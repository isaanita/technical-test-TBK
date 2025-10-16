import 'package:technical_test_isaanita/data/models/now_playing_models.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';

class NowPlayingRepository {
  final ApiService apiService;

  NowPlayingRepository(this.apiService);

  Future<List<NowPlayingModel>> fetchNowPlayingMovies() async {
    final response = await apiService.fetchNowPlaying();
    final List results = response['results'];

    return results.map((e) => NowPlayingModel.fromJson(e)).toList();
  }
}
