part of 'home_cubit.dart';

class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeAppBarLoading extends HomeState {}

final class HomeAppBarLoaded extends HomeState {
  final String userName;
  final String photoUrl;
  final String? gender;

  HomeAppBarLoaded(
      {required this.userName, required this.photoUrl, required this.gender});
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

final class SearchLoading extends HomeState {}

final class SearchLoaded extends HomeState {
  final List<ProductResponse> searchResults;

  SearchLoaded(this.searchResults);
}

final class SearchError extends HomeState {
  final String message;

  SearchError(this.message);
}

final class SearchRecentUpdated extends HomeState {
  final List<String> recentSearches; // 👈 New state clas  s

  SearchRecentUpdated(this.recentSearches);
}

final class LoadedCategories extends HomeState {
  final List<CategoryModel> categories;

  LoadedCategories(this.categories);
}

final class ErrorCategories extends HomeState {
  final String error;

  ErrorCategories(this.error);
}

final class SetMinMaxPrice extends HomeState {}

final class FilterLoading extends HomeState {}

final class FilterLoaded extends HomeState {
  final List<ProductResponse> filteredProducts;

  FilterLoaded(this.filteredProducts);
}

final class FilterError extends HomeState {
  final String error;

  FilterError(this.error);
}

final class SetSelectedCategoryCode extends HomeState {
  final String selectedCategoryCode;

  SetSelectedCategoryCode(this.selectedCategoryCode);
}

final class FiltersReset extends HomeState {}

final class GetAllCategoriesForHomePage extends HomeState {
  final List<Map<String, String>> categories;

  GetAllCategoriesForHomePage(this.categories);
}

final class GetAllCategoriesForHomePageError extends HomeState {
  final String error;

  GetAllCategoriesForHomePageError(this.error);
}

final class GetAllCategoriesForHomePageLoading extends HomeState {}

final class GetProductsByCategoryForHomePageLoading extends HomeState {}

final class GetAllCategoriesForHomePageSuccess extends HomeState {
  final List<CategoryModel> categories;

  GetAllCategoriesForHomePageSuccess(this.categories);
}

final class GetProductsByCategoryForHomePage extends HomeState {
  final List<ProductResponse> products;

  GetProductsByCategoryForHomePage(this.products);
}

final class GetProductsByCategoryForHomePageError extends HomeState {
  final String error;

  GetProductsByCategoryForHomePageError(this.error);
}
