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
  final List<ProductResponse> products;

  LoadedHomeProducts(this.products);
}

final class ErrorHomeProducts extends HomeState {
  final String error;

  ErrorHomeProducts(this.error);
}
