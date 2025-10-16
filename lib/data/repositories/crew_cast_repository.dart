import 'package:technical_test_isaanita/data/models/crew_cast_models.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';

class CrewCastRepository {
  final ApiService apiService;

  CrewCastRepository(this.apiService);
  Future<List<CrewCastModel>> fetchCrewCast(int movieId) async {
    try {
      final response = await apiService.fetchCrewCast(movieId);
      final List cast = response['cast'];

      return cast.map((e) => CrewCastModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('Failed to fetch movie detail: $e');
    }
  }
}
