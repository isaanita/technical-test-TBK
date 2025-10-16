import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:technical_test_isaanita/data/models/crew_cast_models.dart';
import 'package:technical_test_isaanita/data/repositories/crew_cast_repository.dart';
import 'dart:async';

import 'package:technical_test_isaanita/data/services/api_services.dart';

part 'crew_cast_event.dart';
part 'crew_cast_state.dart';

class CrewCastBloc extends Bloc<CrewCastEvent, CrewCastState> {
  CrewCastBloc() : super(CrewCastInitial()) {
    on<FetchCrewCastInitialFetchEvent>(fetchCrewCastInitialFetchEvent);
  }

  FutureOr<void> fetchCrewCastInitialFetchEvent(
    FetchCrewCastInitialFetchEvent event,
    Emitter<CrewCastState> emit,
  ) async {
    emit(CrewCastLoadingState());
    final crewCastRepository = CrewCastRepository(ApiService());

    List<CrewCastModel> crewCastModels =
        await crewCastRepository.fetchCrewCast(event.movieId);

    if (crewCastModels.isEmpty) {
      emit(CrewCastErrorState());
    } else {
      emit(CrewCastSuccessfullFetchState(crewCastModels: crewCastModels));
    }
  }
}
