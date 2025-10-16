part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

abstract class MovieDetailActionState extends MovieDetailState {}

final class MovieDetailLoadingState extends MovieDetailState {}

final class MovieDetailErrorState extends MovieDetailState {}

final class MovieDetailSuccessfulFetchState extends MovieDetailState {
  final MovieDetailModel movieDetailModel;

  const MovieDetailSuccessfulFetchState({
    required this.movieDetailModel,
  });
}
