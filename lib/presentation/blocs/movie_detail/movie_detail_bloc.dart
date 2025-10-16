import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test_isaanita/data/models/movie_detail_models.dart';
import 'package:technical_test_isaanita/data/repositories/movie_detail_repository.dart';
import 'dart:async';

import 'package:technical_test_isaanita/data/services/api_services.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  MovieDetailBloc() : super(MovieDetailInitial()) {
    on<MovieDetailInitialFetchEvent>(movieDetailInitialFetchEvent);
  }

  FutureOr<void> movieDetailInitialFetchEvent(
    MovieDetailInitialFetchEvent event,
    Emitter<MovieDetailState> emit,
  ) async {
    emit(MovieDetailLoadingState());
    final movieDetailRepository = MovieDetailRepository(ApiService());

    MovieDetailModel movieDetailModels =
        await movieDetailRepository.fetchMovieDetail(event.movieId);

    if (movieDetailModels.title.isEmpty) {
      emit(MovieDetailErrorState());
    } else {
      emit(MovieDetailSuccessfulFetchState(
          movieDetailModel: movieDetailModels));
    }
  }
}
