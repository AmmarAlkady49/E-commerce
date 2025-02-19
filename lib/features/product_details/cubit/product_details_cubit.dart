import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/auth/services/auth_services.dart';
import 'package:e_commerce_graduation/features/product_details/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  final ProductDetailsServices _productDetailsServices =
      ProductDetailsServicesImpl();
  final AuthServices authServices = AuthServicesImpl();

  Future<void> setProductFavorite(ProductResponse product) async {
    emit(SetProductFavoriteLoading(productId: product.id!));
    try {
      final currentUser = authServices.getCurrentUser();
      final favoriteProducts =
          await _productDetailsServices.getFavoriteProducts(currentUser!.uid);
      final isFavorite = favoriteProducts.any(
        (element) => element.id == product.id,
      );
      if (isFavorite) {
        await _productDetailsServices.deleteFavoriteProduct(
            currentUser.uid, product.id!);
      } else {
        await _productDetailsServices.addFavoriteProduct(
            currentUser.uid, product);
      }
      emit(SetProductFavoriteSuccess(
          isFavorite: !isFavorite, productId: product.id!));
    } catch (e) {
      emit(SetProductFavoriteError(
        message: e.toString(),
        productId: product.id!,
      ));
    }
  }
}
