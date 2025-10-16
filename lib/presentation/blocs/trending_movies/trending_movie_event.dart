part of 'trending_movie_bloc.dart';

sealed class TrendingMovieEvent extends Equatable {
  const TrendingMovieEvent();

  @override
  List<Object> get props => [];
}

// trending movie all fetch event
class TrendingMovieInitialFetchEvent extends TrendingMovieEvent {}

// trending movie category fetch event
class TrendingMovieCategoryInitialFetchEvent extends TrendingMovieEvent {}

// trending tv fetch event
class TrendingTVCategoryInitialFetchEvent extends TrendingMovieEvent {}
