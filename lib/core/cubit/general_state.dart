part of 'general_cubit.dart';

class GeneralState {}

final class GeneralInitial extends GeneralState {}

final class FavoriteProductsLoadingGeneral extends GeneralState {}

final class UpdateFavoritePageGeneral extends GeneralState {}

final class FavoriteProductsErrorGeneral extends GeneralState {
  final String message;

  FavoriteProductsErrorGeneral({required this.message});
}

final class FavoriteProductsLoadedGeneral extends GeneralState {
  final List<FavoriteItemModel> favoriteProducts;

  FavoriteProductsLoadedGeneral({required this.favoriteProducts});
}
