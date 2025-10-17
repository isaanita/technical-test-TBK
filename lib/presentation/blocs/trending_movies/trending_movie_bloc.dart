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
    on<TrendingMovieCategoryInitialFetchEvent>(
        trendingMovieCategoryInitialFetchEvent);
    on<TrendingTVCategoryInitialFetchEvent>(
        trendingTVCategoryInitialFetchEvent);
  }

  FutureOr<void> trendingMovieInitialFetchEvent(
    TrendingMovieInitialFetchEvent event,
    Emitter<TrendingMovieState> emit,
  ) async {

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

  FutureOr<void> trendingMovieCategoryInitialFetchEvent(
      TrendingMovieCategoryInitialFetchEvent event,
      Emitter<TrendingMovieState> emit) async {
    final trendingRepository = TrendingRepository(ApiService());

    List<TrendingMoviesModel> trendingMoviesCategoryModels =
        await trendingRepository.fetchTrendingMoviesCategory();

    if (trendingMoviesCategoryModels.isEmpty) {
      emit(TrendingMovieFetchingErrorState());
    } else {
      emit(TrendingMovieSuccessfulFetchState(
        trendingMoviesModels: trendingMoviesCategoryModels,
      ));
    }
  }

  FutureOr<void> trendingTVCategoryInitialFetchEvent(
      TrendingTVCategoryInitialFetchEvent event,
      Emitter<TrendingMovieState> emit) async {
    final trendingRepository = TrendingRepository(ApiService());

    List<TrendingMoviesModel> trendingTVCategoryModels =
        await trendingRepository.fetchTrendingTVCategory();

    if (trendingTVCategoryModels.isEmpty) {
      emit(TrendingMovieFetchingErrorState());
    } else {
      emit(TrendingMovieSuccessfulFetchState(
        trendingMoviesModels: trendingTVCategoryModels,
      ));
    }
  }
}
