import 'package:dio/dio.dart' as dio;
import '../../config/env.dart';

class ApiService {
  final String baseUrl = Env.baseUrl;
  final String apiKey = Env.apiKey;
  final String bearerToken = Env.bearerToken;

  final dio.Dio _dio = dio.Dio();

  Future<Map<String, dynamic>> fetchTrendingMovies() async {
    final url = '$baseUrl/trending/all/day?api_key=$apiKey';

    try {
      final response = await _dio.get(
        url,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $bearerToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to fetch trending movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
