import 'dart:developer';

import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/services/favorite_products_services.dart';
import 'package:e_commerce_graduation/features/home/model/category_model.dart';
import 'package:e_commerce_graduation/features/home/model/parameter_request.dart';
import 'package:e_commerce_graduation/features/home/services/home_page_services.dart';
import 'package:e_commerce_graduation/features/profile/services/profile_page_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final FavoritesCubit favoritesCubit;
  HomeCubit({required this.favoritesCubit}) : super(HomeInitial());

  final HomePageServices homeServices = HomePageServicesImpl();
  final ProfilePageServices profileServices = ProfilePageServicesimpl();
  final FavoriteProductsServices _favoriteProductsServices =
      FavoriteProductsServicesImpl();
  final secureStorage = SecureStorage();
  List<String> reacentSearches = [];
  List<ProductResponse> searchResults = [];
  List<CategoryModel> categoriesList = [];
  String? currentSearchQuery;
 int selectedCategoryIndex = 0;

  bool isFiltering = false;

  double? _minPrice;
  double? _maxPrice;
  String? categoryCode;
  String? subCategoryCode;
  String? brandCode;
  String? _sortBy;
  // Get UserData
  Future<String> getUserData() async {
    emit(HomeAppBarLoading());
    try {
      final userName = await secureStorage.readSecureData('name');

      final firstName = userName.split(' ')[0];
      final capitalizedName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
      emit(HomeAppBarLoaded(capitalizedName));
      return userName;
    } catch (e) {
      emit(HomeAppBarError(e.toString()));
      log("failed to get user data");
      throw Exception('Failed to fetch user data');
    }
  }

  // Get All Products
  Future<void> getAllProducts() async {
    emit(LoadingHomeProducts());

    try {
      final userId = await secureStorage.readSecureData('userId');
      final ParameterRequest parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 10,
        pagesize: 10,
      );
      final products = await homeServices.getAllProducts(parameterRequest);
      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final List<ProductResponse> finalProducts = products.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.productId == product.productID,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();
      emit(LoadedHomeProducts(finalProducts));
    } on Exception catch (e) {
      emit(ErrorHomeProducts(e.toString()));
    } catch (e) {
      emit(ErrorHomeProducts(e.toString()));

      log(e.toString());
    }
  }

  Future<void> setFavortie(String productId) async {
    emit(SetFavoriteLoading(productId: productId));
    try {
      final userId = await secureStorage.readSecureData('userId');

      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final isFavorite = favoriteProducts.any(
        (element) => element.productId.toString() == productId,
      );
      if (isFavorite) {
        await _favoriteProductsServices.removeFavoriteProduct(
            userId, productId);
        favoritesCubit.hasFetchedFavorites = false;
      } else {
        await _favoriteProductsServices.addFavoriteProduct(userId, productId);
        favoritesCubit.hasFetchedFavorites = false;
      }
      emit(SetFavoriteSuccess(isFavorite: !isFavorite, productId: productId));
    } catch (e) {
      log("error in set favorite: ${e.toString()}");
      emit(SetFavoriteError(error: e.toString(), productId: productId));
    }
  }

  void setMinMaxPrice(double min, double max) {
    log("min: $min max: $max");
    _minPrice = min;
    _maxPrice = max;
    emit(SetMinMaxPrice());
    log("min price: $_minPrice max price: $_maxPrice");
  }

  void setSortBy({required String sortBy}) {
    if (sortBy == "asc_price") {
      _sortBy = "PriceAsc";
    } else if (sortBy == "desc_price") {
      _sortBy = "PriceDesc";
    } else if (sortBy == "asc_rating") {
      _sortBy = "Rating";
    }
  }

  Future<void> searchProducts({required String query}) async {
    isFiltering = false;
    emit(SearchLoading());
    try {
      final parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 30,
        pagesize: 30,
        search: query,
      );
      final allProducts = await homeServices.getAllProducts(parameterRequest);
      searchResults = allProducts
          .where((product) =>
              product.name!.toLowerCase().contains(query.trim().toLowerCase()))
          .toList();
      log("search results: ${searchResults.length}");
      currentSearchQuery = query;
      addToRecentSearches(query);
      emit(SearchLoaded(searchResults));
    } catch (e) {
      log("error in search products: ${e.toString()}");
      emit(SearchError("Something went wrong: ${e.toString()}"));
    }
  }

  void filterProducts(
      {String? category, String? subcategory, String? brand}) async {
    isFiltering = true;

    emit(FilterLoading());
    final parameterRequest = ParameterRequest(
      pagenum: 1,
      maxpagesize: 30,
      pagesize: 30,
      categoryCode: category,
      subCategoryCode: subcategory,
      brandCode: brand,
      search: currentSearchQuery,
      sort: _sortBy,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
    );
    try {
      final products = await homeServices.getAllProducts(parameterRequest);
      searchResults = products;
      emit(FilterLoaded(searchResults));
    } catch (e) {
      log("error in filter products: ${e.toString()}");
      emit(FilterError("Something went wrong: ${e.toString()}"));
    }
  }

  void addToRecentSearches(String query) {
    if (query.trim().isEmpty) return;
    reacentSearches.remove(query);
    reacentSearches.insert(0, query);
    if (reacentSearches.length > 10) {
      reacentSearches = reacentSearches.sublist(0, 10);
    }
    emit(SearchRecentUpdated(reacentSearches));
  }

  void clearRecentSearches() {
    reacentSearches.clear();
    emit(SearchRecentUpdated(reacentSearches));
  }

  void removeSearchItem(String item) {
    reacentSearches.remove(item);
    emit(SearchRecentUpdated(reacentSearches));
  }

  void getAllCategories() async {
    try {
      categoriesList = await homeServices.getAllCategories();

      emit(LoadedCategories(categoriesList));
      log(categoriesList.length.toString());
    } catch (e) {
      log(" error in get all categories: ${e.toString()}");
      emit(ErrorCategories(e.toString()));
    }
  }

  Future<void> getProductsByCategory(String categoryCode) async {
    emit(FilterLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final ParameterRequest parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 30,
        pagesize: 30,
        categoryCode: categoryCode,
      );
      final products = await homeServices.getAllProducts(parameterRequest);
      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final List<ProductResponse> finalProducts = products.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.productId == product.productID,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();

      searchResults = finalProducts; // ✨ add this line

      emit(FilterLoaded(finalProducts));
    } on Exception catch (e) {
      emit(FilterError(e.toString()));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }
void setSelectedCategoryIndex(int index) {
  selectedCategoryIndex = index;
  emit(SetSelectedCategoryCode(index.toString()));
}
}
