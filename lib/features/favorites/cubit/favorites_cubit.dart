import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/services/favorites_services.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final FavoritesServices _favoritesServices = FavoritesServicesImpl();
  final AuthServices _authServices = AuthServicesImpl();
  Future<void> setFavoriteItem(ProductResponse productItem) async {
    emit(FavoriteItemLoading(
      productId: productItem.id!,
    ));
    try {
      final user = _authServices.getCurrentUser();
      final getFavoriteProducts =
          await _favoritesServices.getFavorites(user!.uid);
      final isFavorite =
          getFavoriteProducts.any((product) => product.id == productItem.id);
      if (isFavorite) {
        _favoritesServices.removeFavorite(user.uid, productItem);
        emit(FavoriteItemLoaded(
          productId: productItem.id!,
        ));
      } else {
        _favoritesServices.addFavorite(user.uid, productItem);
        emit(FavoriteItemLoaded(
          productId: productItem.id!,
        ));
      }
    } catch (e) {
      emit(
          FavoriteItemError(message: e.toString(), productId: productItem.id!));
    }
  }
}
