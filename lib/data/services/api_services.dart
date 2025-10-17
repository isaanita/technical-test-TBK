import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:technical_test_isaanita/config/env.dart';

class ApiService {
  final String baseUrl = Env.baseUrl;
  final Dio _dio = Dio();

  // SharedPreferences
  static const String _tokenKey = 'auth_token';
  static const String _apiKeyKey = 'api_key';

  // token & apiKey dari SharedPreferences
  Future<Map<String, String?>> _getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'token': prefs.getString(_tokenKey),
      'apiKey': prefs.getString(_apiKeyKey),
    };
  }

  // header authorization
  Future<Map<String, String>> _getHeaders() async {
    final authData = await _getAuthData();
    final token = authData['token'] ?? '';
    return {
      'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> fetchTrendingMovies() async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/trending/all/day?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch trending movies');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchTrendingMoviesCategory() async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/trending/movie/day?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch trending movies category');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchTrendingTVCategory() async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/trending/tv/day?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch trending TV shows');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchNowPlaying() async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/movie/now_playing?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch now playing movies');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchTopRated() async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/movie/top_rated?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch top rated movies');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/movie/$movieId?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch movie details');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchCrewCast(int movieId) async {
    final authData = await _getAuthData();
    final apiKey = authData['apiKey'] ?? '';
    final url = '$baseUrl/movie/$movieId/credits?api_key=$apiKey';

    try {
      final headers = await _getHeaders();
      final response = await _dio.get(url, options: Options(headers: headers));

      if (response.statusCode == 200) return response.data;
      throw Exception('Failed to fetch crew & cast');
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
