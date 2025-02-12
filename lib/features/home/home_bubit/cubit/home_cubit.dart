import 'package:e_commerce_graduation/core/models/user_data.dart';
import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/favorites_services.dart';
import 'package:e_commerce_graduation/features/home/services/home_page_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final HomePageServices homeServices = HomePageServicesImpl();
  final FavoritesServices favoriteServices = FavoritesServicesImpl();

  // Get UserData
  Future<UserData?> getUserData() async {
    emit(HomeAppBarLoading());
    try {
      final userData = await homeServices.getUserData();
      emit(HomeAppBarLoaded(userData));
      return userData;
    } catch (e) {
      emit(HomeAppBarError(e.toString()));
    }
    return null;
  }

  // Get All Products
  Future<void> getAllProducts() async {
    // final currentUser = await homeServices.getUserData();
    // final favoriteProducts =
    // await favoriteServices.getFavorites(currentUser.uid);

    emit(LoadingHomeProducts());
    try {
      final products = await homeServices.getAllProducts();
      //
      // final List<ProductResponse> finalProducts = products.map((product) {
      //   final isFavorite = favoriteProducts.any(
      //     (item) => item.id == product.id,
      //   );
      //   return product.copyWith(isFavorite: isFavorite);
      // }).toList();
      emit(LoadedHomeProducts(products));
    } catch (e) {
      emit(ErrorHomeProducts(e.toString()));
      debugPrint(e.toString());
    }
  }
}
