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

  Future<Map<String, dynamic>> fetchTrendingMoviesCategory() async {
    final url = '$baseUrl/trending/movie/day?api_key=$apiKey';

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

  Future<Map<String, dynamic>> fetchTrendingTVCategory() async {
    final url = '$baseUrl/trending/tv/day?api_key=$apiKey';

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

  Future<Map<String, dynamic>> fetchNowPlaying() async {
    final url = '$baseUrl/movie/now_playing?api_key=$apiKey';

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
        throw Exception('Failed to fetch movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchTopRated() async {
    final url = '$baseUrl/movie/top_rated?api_key=$apiKey';

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
        throw Exception('Failed to fetch top rated movies');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final url = '$baseUrl/movie/$movieId?api_key=$apiKey';

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
        throw Exception('Failed to fetch movie details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCrewCast(int movieId) async {
    final url = '$baseUrl/movie/$movieId/credits?api_key=$apiKey';

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
        throw Exception('Failed to fetch crew details');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
