part of 'crew_cast_bloc.dart';

sealed class CrewCastEvent extends Equatable {
  const CrewCastEvent();

  @override
  List<Object> get props => [];
}

class FetchCrewCastInitialFetchEvent extends CrewCastEvent {
  final int movieId;
  const FetchCrewCastInitialFetchEvent({required this.movieId});
}