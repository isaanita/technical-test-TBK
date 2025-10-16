part of 'now_playing_movie_bloc.dart';

sealed class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMovieInitial extends NowPlayingMovieState {}

abstract class NowPlayingMovieActionState extends NowPlayingMovieState {}

class NowPlayingMovieFetchingLoadingState extends NowPlayingMovieState {}

class NowPlayingMovieFetchingErrorState extends NowPlayingMovieState {}

class NowPlayingMovieSuccessfullFetchState extends NowPlayingMovieState {
  final List<NowPlayingModel> nowPlayingModels;
  const NowPlayingMovieSuccessfullFetchState({
    required this.nowPlayingModels,
  });
}
