part of 'trending_movie_bloc.dart';

sealed class TrendingMovieEvent extends Equatable {
  const TrendingMovieEvent();

  @override
  List<Object> get props => [];
}

class TrendingMovieInitialFetchEvent extends TrendingMovieEvent {
  final DateTime focusedDay;

  TrendingMovieInitialFetchEvent(this.focusedDay);

  @override
  List<Object> get props => [focusedDay];
}
