part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class MovieDetailInitialFetchEvent extends MovieDetailEvent {
  final int movieId;
  const MovieDetailInitialFetchEvent({required this.movieId});
}
