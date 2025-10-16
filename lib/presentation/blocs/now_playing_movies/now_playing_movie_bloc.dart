import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test_isaanita/data/models/now_playing_models.dart';
import 'package:technical_test_isaanita/data/repositories/now_playing_repository.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';
import 'dart:async';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  NowPlayingMovieBloc() : super(NowPlayingMovieInitial()) {
    on<NowPlayingMovieInitialFetchEvent>(nowPlayingMovieInitialFetchEvent);
  }

  FutureOr<void> nowPlayingMovieInitialFetchEvent(
    NowPlayingMovieInitialFetchEvent event,
    Emitter<NowPlayingMovieState> emit,
  ) async {
    emit(NowPlayingMovieFetchingLoadingState());
    final nowPlayingRepository = NowPlayingRepository(ApiService());

    List<NowPlayingModel> nowPlayingModels =
        await nowPlayingRepository.fetchNowPlayingMovies();

    if (nowPlayingModels.isEmpty) {
      emit(NowPlayingMovieFetchingErrorState());
    } else {
      emit(NowPlayingMovieSuccessfullFetchState(
          nowPlayingModels: nowPlayingModels));
    }
  }
}
