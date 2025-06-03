part of 'general_cubit.dart';

class GeneralState {}

final class GeneralInitial extends GeneralState {}

final class SetFavoriteLoading extends GeneralState {
  final String productId;

  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends GeneralState {
  final bool isFavorite;
  final String productId;

  SetFavoriteSuccess({required this.isFavorite, required this.productId});
}

final class SetFavoriteError extends GeneralState {
  final String error;
  final String productId;

  SetFavoriteError({required this.error, required this.productId});
}
