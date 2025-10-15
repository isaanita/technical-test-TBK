part of 'trending_movie_bloc.dart';

sealed class TrendingMovieState extends Equatable {
  const TrendingMovieState();
  @override
  List<Object> get props => [];
}

final class TrendingMovieInitial extends TrendingMovieState {}

abstract class TrendingMovieActionState extends TrendingMovieState {}

class TrendingMovieFetchingLoadingState extends TrendingMovieState {}

class TrendingMovieFetchingErrorState extends TrendingMovieState {}

class TrendingMovieSuccessfulFetchState extends TrendingMovieState {
  final List<TrendingMoviesModel> trendingMoviesModels;
  const TrendingMovieSuccessfulFetchState({
    required this.trendingMoviesModels,
  });
}
