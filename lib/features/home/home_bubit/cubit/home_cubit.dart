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

  Future<void> searchProducts(
      {required String query,
      String? category,
      String? subcategory,
      String? brand,
      double? minPrice,
      double? maxPrice}) async {
    // emit(SearchLoading());
    try {
      final parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 25,
        pagesize: 25,
        search: query,
        categoryCode: category,
        subCategoryCode: subcategory,
        brandCode: brand,
        minPrice: minPrice,
        maxPrice: maxPrice,
      );
      final allProducts = await homeServices.getAllProducts(parameterRequest);
      searchResults = allProducts
          .where((product) =>
              product.name!.toLowerCase().contains(query.trim().toLowerCase()))
          .toList();

      addToRecentSearches(query);
      emit(SearchLoaded(searchResults));
    } catch (e) {
      emit(SearchError("Something went wrong: ${e.toString()}"));
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
      log(e.toString());
      emit(ErrorCategories(e.toString()));
    }
  }
}
