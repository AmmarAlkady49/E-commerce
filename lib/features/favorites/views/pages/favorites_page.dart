import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/empty_favorite_products.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/not_empty_favorite_products.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      bloc: favoritesCubit,
      listenWhen: (previous, current) =>
          current is SetFavoriteItemLoaded || current is UpdateFavoritePage,
      listener: (context, state) {
        if (state is SetFavoriteItemLoaded || state is UpdateFavoritePage) {
          // favoritesCubit.getFavoriteProducts();
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
              actions: [
                SizedBox(width: 10.w),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTapUp: (TapUpDetails details) {
                    final RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    final Offset offset =
                        renderBox.localToGlobal(details.globalPosition);

                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(offset.dx + -50,
                          offset.dy + 20.h, offset.dx + 40, offset.dy + 10),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 5,
                      items: [
                        PopupMenuItem(
                          child: Text(S.of(context).delete_all,
                              style: FontHelper.fontText(
                                  context: context,
                                  size: 14.sp,
                                  weight: FontWeight.w600,
                                  color: Colors.red.shade700)),
                          onTap: () {
                            Future.delayed(Duration(milliseconds: 200), () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(S.of(context).confirm_deletion,
                                      style: FontHelper.fontText(
                                          context: context,
                                          size: 18.sp,
                                          weight: FontWeight.w700,
                                          color: Colors.black87)),
                                  content: Text(S.of(context).are_you_sure,
                                      style: FontHelper.fontText(
                                          context: context,
                                          size: 14.sp,
                                          weight: FontWeight.w700,
                                          color: Colors.black54)),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        S.of(context).cancel,
                                        style: FontHelper.fontText(
                                            color: Colors.black,
                                            context: context,
                                            size: 13.sp,
                                            weight: FontWeight.w700),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        // favoritesCubit.clearFavorites();
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red),
                                      child: Text(
                                        S.of(context).delete.toUpperCase(),
                                        style: FontHelper.fontText(
                                            color: Colors.white,
                                            context: context,
                                            size: 13.sp,
                                            weight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          },
                        ),
                      ],
                    );
                  },
                  child: Icon(CupertinoIcons.ellipsis_vertical,
                      color: Colors.white),
                ),
                SizedBox(width: 10.w),
              ],
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
