import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test_isaanita/data/models/trending_movies.dart';
import 'package:technical_test_isaanita/data/repositories/trending_movies_repository.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';

part 'trending_movie_event.dart';
part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  TrendingMovieBloc() : super(TrendingMovieInitial()) {
    on<TrendingMovieInitialFetchEvent>(trendingMovieInitialFetchEvent);
  }

  FutureOr<void> trendingMovieInitialFetchEvent(
    TrendingMovieInitialFetchEvent event,
    Emitter<TrendingMovieState> emit,
  ) async {
    // tambahin instance ApiService di sini
    final trendingRepository = TrendingRepository(ApiService());

    List<TrendingMoviesModel> trendingMoviesModels =
        await trendingRepository.fetchTrendingMoviesModel();

    if (trendingMoviesModels.isEmpty) {
      emit(TrendingMovieFetchingErrorState());
    } else {
      emit(TrendingMovieSuccessfulFetchState(
        trendingMoviesModels: trendingMoviesModels,
      ));
    }
  }
}
