import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test_isaanita/data/models/top_rated_models.dart';
import 'package:technical_test_isaanita/data/repositories/top_rated_repository.dart';
import 'package:technical_test_isaanita/data/services/api_services.dart';
import 'dart:async';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  TopRatedMovieBloc() : super(TopRatedMovieInitial()) {
    on<TopRatedMovieInitialFetchEvent>(topRatedMovieInitialFetchEvent);
  }

  FutureOr<void> topRatedMovieInitialFetchEvent(
    TopRatedMovieInitialFetchEvent event,
    Emitter<TopRatedMovieState> emit,
  ) async {
    final topRatedRepository = TopRatedRepository(ApiService());

    List<TopRatedModels> topRatedModels =
        await topRatedRepository.fetchTopRatedMovies();

    if (topRatedModels.isEmpty) {
      emit(TopRatedMovieErrorState());
    } else {
      emit(TopRatedMovieSuccessfullFetchState(topRatedModels: topRatedModels));
    }
  }
}
