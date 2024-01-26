part of 'post_cubit.dart';

@immutable
abstract class PostState {}

class PostInitial  extends PostState{}

class PostLoading extends PostState {}

class PostError extends PostState {
  final String message;

  PostError({required this.message});
}

class PostLoaded extends PostState {
  final PostResultsModel results;

  PostLoaded(this.results);
}
