import 'package:flutter/material.dart';
import 'package:technical_test_isaanita/presentation/pages/movie_detail_page.dart';
import 'package:technical_test_isaanita/presentation/pages/trending_page.dart';
import 'package:technical_test_isaanita/presentation/pages/watchlist_page.dart';
import '../pages/splash_page.dart';
import '../pages/login_page.dart';
import '../pages/home_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String watchlist = '/watchlist';
  static const String trending = '/trending';
  static const String movieDetail = '/movieDetail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case watchlist:
        return MaterialPageRoute(builder: (_) => const WatchlistPage());
      case trending:
        return MaterialPageRoute(builder: (_) => const TrendingPage());
      case movieDetail:
  final movieId = settings.arguments as int;
  return MaterialPageRoute(
    builder: (_) => MovieDetailPage(movieId: movieId),
  );


      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Page not found')),
          ),
        );
    }
  }
}
