import 'dart:developer';

import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/secure_storage.dart';
import 'package:e_commerce_graduation/core/utils/helper_functions.dart';
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
  List<ProductResponse> homeProducts = [];
  List<Map<String, String>> homeCategories = [];
  String? currentSearchQuery;
  int selectedCategoryIndex = 0;

  bool isFiltering = false;

  double? _minPrice;
  double? _maxPrice;
  String? categoryCode;
  String? _sortBy;

  //
  bool _categoriesDone = false;
  bool _productsDone = false;
  bool _categoriesError = false;
  bool _productsError = false;

  bool get isLoading => !_categoriesDone || !_productsDone;
  bool get hasError => _categoriesError || _productsError;
//
  // Get UserData
  Future<String> getUserData() async {
    emit(HomeAppBarLoading());
    try {
      final userName = await secureStorage.readSecureData('name');
      final photoUrl = await secureStorage.readSecureData("photoUrl");
      final gender = await secureStorage.readSecureData('gender');

      final firstName = userName.split(' ')[0];
      final capitalizedName =
          firstName[0].toUpperCase() + firstName.substring(1).toLowerCase();
      emit(HomeAppBarLoaded(
          userName: capitalizedName, photoUrl: photoUrl, gender: gender));
      return userName;
    } catch (e) {
      emit(HomeAppBarError(e.toString()));
      log("failed to get user data");
      throw Exception('Failed to fetch user data');
    }
  }

  // Get All Products
  Future<void> getAllProducts() async {
    _productsDone = false;
    _productsError = false;
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
      homeProducts = finalProducts;
      _productsDone = true;
      emit(LoadedHomeProducts(finalProducts));
    } on Exception catch (e) {
      _productsDone = true;
      _productsError = true;
      emit(ErrorHomeProducts(e.toString()));
    } catch (e) {
      _productsDone = true;
      _productsError = true;
      emit(ErrorHomeProducts(e.toString()));
      log(e.toString());
    }
  }

  Future<void> getRecommendedProducts() async {
    _productsDone = false;
    _productsError = false;
    emit(LoadingHomeProducts());

    try {
      final userId = await secureStorage.readSecureData('userId');
      // Fetching the recommended products ID
      final recommendedProductsIds =
          await homeServices.getRecommendedProductsID(userId);
      final recommendedProducts =
          await homeServices.getRecommendedProducts(recommendedProductsIds);
      log("Recommended Products IDs: $recommendedProductsIds");
      log("Recommended Products: $recommendedProducts");
      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final List<ProductResponse> finalProducts =
          recommendedProducts.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.productId == product.productID,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();
      homeProducts = finalProducts;
      _productsDone = true;
      emit(LoadedHomeProducts(finalProducts));
    } on Exception catch (e) {
      _productsDone = true;
      _productsError = true;
      emit(ErrorHomeProducts(e.toString()));
    } catch (e) {
      _productsDone = true;
      _productsError = true;
      emit(ErrorHomeProducts(e.toString()));
      log(e.toString());
    }
  }

  Future<void> setFavortie(String productId) async {
    log("Setting favorite for product ID: $productId");
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
      log("Favorite status for product ID $productId: ${!isFavorite}");
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
    resetFilters();
    log("Searching for products with query: $query");

    emit(SearchLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');

      final parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 30,
        pagesize: 30,
        search: query,
      );

      final allProducts = await homeServices.getAllProducts(parameterRequest);

      searchResults = allProducts;

      // Fetch favorites
      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);

      // Update `isFavorite` in search results
      final finalProducts = searchResults.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.productId == product.productID,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();

      searchResults = finalProducts;
      currentSearchQuery = query;
      addToRecentSearches(query);

      log("Search results count: ${searchResults.length}");

      // ✅ Emit the correct list
      emit(SearchLoaded(searchResults));
    } catch (e) {
      log("Error in searchProducts: ${e.toString()}");
      emit(SearchError("Something went wrong: ${e.toString()}"));
    }
  }

  void filterProducts() async {
    isFiltering = true;
    final userId = await secureStorage.readSecureData('userId');

    emit(FilterLoading());
    final parameterRequest = ParameterRequest(
      pagenum: 1,
      maxpagesize: 30,
      pagesize: 30,
      categoryCode: categoryCode,
      search: currentSearchQuery,
      sort: _sortBy,
      minPrice: _minPrice,
      maxPrice: _maxPrice,
    );
    try {
      final products = await homeServices.getAllProducts(parameterRequest);
      final favoriteProducts =
          await _favoriteProductsServices.getFavoriteProducts(userId);
      final List<ProductResponse> finalProducts = products.map((product) {
        final isFavorite = favoriteProducts.any(
          (item) => item.productId == product.productID,
        );
        return product.copyWith(isFavorite: isFavorite);
      }).toList();

      searchResults = finalProducts;
      log("search results: ${searchResults.length}");
      log("category: $categoryCode max: $_maxPrice min: $_minPrice sort: $_sortBy");
      log("filter results: ${finalProducts.length}");
      emit(FilterLoaded(finalProducts));
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

  Future<void> getProductsByCategory(String categoryCode,
      {String? query}) async {
    emit(FilterLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final ParameterRequest parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 30,
        pagesize: 30,
        categoryCode: categoryCode,
        search: currentSearchQuery,
        sort: _sortBy,
        minPrice: _minPrice,
        maxPrice: _maxPrice,
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

      searchResults = finalProducts;

      emit(FilterLoaded(finalProducts));
    } on Exception catch (e) {
      emit(FilterError(e.toString()));
    } catch (e) {
      emit(FilterError(e.toString()));
    }
  }

  void setSelectedCategoryIndex(int index) {
    selectedCategoryIndex = index;
    if (index == 0) {
      categoryCode = null;
    } else {
      categoryCode = categoriesList[index].categoryCode;
    }
    emit(SetSelectedCategoryCode(index.toString()));
  }

  void resetFilters() {
    _minPrice = null;
    _maxPrice = null;
    categoryCode = null;
    _sortBy = null;
    emit(FiltersReset());
  }

  //   void getAllCategories() async {
  //   try {
  //     categoriesList = await homeServices.getAllCategories();

  //     categoriesList.removeWhere(
  //         (category) => category.name.toLowerCase() == "no category");

  //     categoriesList.insert(
  //         0, CategoryModel(categoryCode: '', name: "كل الفئات"));

  //     emit(LoadedCategories(categoriesList));
  //     log(categoriesList.length.toString());
  //   } catch (e) {
  //     log(" error in get all categories: ${e.toString()}");
  //     emit(ErrorCategories(e.toString()));
  //   }
  // }

  void getAllCategoriesForHomePage() async {
    _categoriesDone = false;
    _categoriesError = false;
    emit(GetAllCategoriesForHomePageLoading());
    try {
      categoriesList = await homeServices.getAllCategories();
      categoriesList.removeWhere(
          (category) => category.name.toLowerCase() == "no category");

      categoriesList.insert(
          0, CategoryModel(categoryCode: '', name: "كل الفئات"));

      final returnedCategoriesList = categoriesList
          .map((category) =>
              HelperFunctions.getAllCategoriesForHomePage(category))
          .where((categoryMap) => categoryMap.isNotEmpty)
          .toList();

      // final categoryToMove = 'اخري';
      // final index = returnedCategoriesList.indexWhere(
      //   (category) => category['name'] == categoryToMove,
      // );

      // if (index != -1) {
      //   final movedCategory = returnedCategoriesList.removeAt(index);
      //   returnedCategoriesList.add(movedCategory);
      // }
      _categoriesDone = true;
      emit(GetAllCategoriesForHomePage(returnedCategoriesList));
      homeCategories = returnedCategoriesList;
    } on Exception catch (e) {
      _categoriesDone = true;
      _categoriesError = true;
      emit(GetAllCategoriesForHomePageError(e.toString()));
    } catch (e) {
      _categoriesDone = true;
      _categoriesError = true;
      log("error in get all categories: ${e.toString()}");
      emit(GetAllCategoriesForHomePageError(e.toString()));
    }
  }

  List<ProductResponse> _categoryProducts = [];

  Future<List<ProductResponse>> getProductsByCategoryForHomePage(
      String categoryCode, String? categoryCode2,
      {int page = 1}) async {
    if (page == 1) emit(GetProductsByCategoryForHomePageLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final parameterRequest = ParameterRequest(
        pagenum: page,
        maxpagesize: 10,
        pagesize: 10,
        categoryCode: categoryCode,
        categoryCode2: categoryCode2,
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

      if (page == 1) {
        _categoryProducts = finalProducts;
      } else {
        _categoryProducts.addAll(finalProducts);
      }

      emit(GetProductsByCategoryForHomePage(_categoryProducts));
      return finalProducts;
    } catch (e) {
      emit(GetProductsByCategoryForHomePageError(e.toString()));
      return [];
    }
  }

  void searchForProductsInCategory(
      String categoryCode, String? categoryCode2, String query) async {
    emit(GetProductsByCategoryForHomePageLoading());
    try {
      final userId = await secureStorage.readSecureData('userId');
      final ParameterRequest parameterRequest = ParameterRequest(
        pagenum: 1,
        maxpagesize: 10,
        pagesize: 10,
        categoryCode: categoryCode,
        categoryCode2: categoryCode2,
        search: query,
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

      emit(GetProductsByCategoryForHomePage(finalProducts));
    } catch (e) {
      log("error in get products by category for home page: ${e.toString()}");
      emit(GetProductsByCategoryForHomePageError(e.toString()));
    }
  }
}
