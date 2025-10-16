part of 'top_rated_movie_bloc.dart';

sealed class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

final class TopRatedMovieInitial extends TopRatedMovieState {}

abstract class TopRatedMovieActionState extends TopRatedMovieState {}

final class TopRatedMovieLoadingState extends TopRatedMovieState {}

final class TopRatedMovieErrorState extends TopRatedMovieState {}

final class TopRatedMovieSuccessfullFetchState extends TopRatedMovieState {
  final List<TopRatedModels> topRatedModels;

  const TopRatedMovieSuccessfullFetchState({
    required this.topRatedModels,
  });
}
