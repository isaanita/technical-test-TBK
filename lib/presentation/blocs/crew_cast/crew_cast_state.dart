part of 'crew_cast_bloc.dart';

sealed class CrewCastState extends Equatable {
  const CrewCastState();
  
  @override
  List<Object> get props => [];
}

final class CrewCastInitial extends CrewCastState {}

abstract class CrewCastActionState extends CrewCastState {}

final class CrewCastLoadingState extends CrewCastState {}
final class CrewCastErrorState extends CrewCastState {}
final class CrewCastSuccessfullFetchState extends CrewCastState {
  final List<CrewCastModel> crewCastModels;

  const CrewCastSuccessfullFetchState({
    required this.crewCastModels,
  });
}
