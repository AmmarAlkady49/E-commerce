part of 'home_cubit.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeAppBarLoading extends HomeState {}

final class HomeAppBarLoaded extends HomeState {
  final UserData userData;

  HomeAppBarLoaded(this.userData);
}

final class HomeAppBarError extends HomeState {
  final String error;

  HomeAppBarError(this.error);
}

final class LoadingHomeProducts extends HomeState {}

final class LoadedHomeProducts extends HomeState {
  final List<ProductItemModel> products;

  LoadedHomeProducts(this.products);
}

final class ErrorHomeProducts extends HomeState {
  final String error;

  ErrorHomeProducts(this.error);
}

final class SetFavoriteLoading extends HomeState {
  final String productId;

  SetFavoriteLoading({required this.productId});
}

final class SetFavoriteSuccess extends HomeState {
  final bool isFavorite;
  final String productId;

  SetFavoriteSuccess({required this.isFavorite, required this.productId});
}

final class SetFavoriteError extends HomeState {
  final String error;
  final String productId;

  SetFavoriteError({required this.error, required this.productId});
}
