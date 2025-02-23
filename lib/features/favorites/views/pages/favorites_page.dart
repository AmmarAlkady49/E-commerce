import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/empty_favorite_products.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/not_empty_favorite_products.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      bloc: favoritesCubit,
      listenWhen: (previous, current) => current is SetFavoriteItemLoaded,
      listener: (context, state) {
        if (state is SetFavoriteItemLoaded) {
          favoritesCubit.getFavoriteProducts();
        }
      },
      buildWhen: (previous, current) =>
          current is FavoriteProductsLoading ||
          current is FavoriteProductsLoaded ||
          current is FavoriteProductsError,
      builder: (context, state) {
        return SafeArea(
          top: false,
          bottom: true,
          child: Scaffold(
            appBar: AppBarDefaultTheme(
              title: S.of(context).Favorites,
              needLeadingButton: false,
            ),
            body: state is FavoriteProductsLoading
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : state is FavoriteProductsError
                    ? Center(child: Text(state.message))
                    : state is FavoriteProductsLoaded
                        ? state.favoriteProducts.isEmpty
                            ? EmptyFavoriteProducts()
                            : NotEmptyFavoriteProducts(
                                favoriteProducts: state.favoriteProducts)
                        : SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
