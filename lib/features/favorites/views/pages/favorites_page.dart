import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_graduation/core/cubit/general_cubit.dart';
import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/empty_favorite_products.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/not_empty_favorite_products.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesCubit favoritesCubit;

  @override
  void initState() {
    super.initState();
    favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    favoritesCubit.getFavoriteProducts(context);
  }

  void _showModernConfirmationDialog(
      BuildContext context, GeneralCubit generalCubit) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.scale,
      dialogBackgroundColor: MyColor.white,
      barrierColor: Colors.black.withAlpha(175),
      title: S.of(context).confirm_deletion,
      desc: S.of(context).are_you_sure,
      titleTextStyle: FontHelper.fontText(
        size: 20.sp,
        weight: FontWeight.w800,
        color: Colors.black87,
        context: context,
      ),
      descTextStyle: FontHelper.fontText(
        size: 16.sp,
        weight: FontWeight.w600,
        color: Colors.black54,
        context: context,
      ),
      borderSide: BorderSide(
        color: MyColor.poppy.withAlpha(60),
        width: 2,
      ),
      width: MediaQuery.of(context).size.width * 0.9,
      dialogBorderRadius: BorderRadius.circular(20.r),
      headerAnimationLoop: false,
      showCloseIcon: true,
      closeIcon: Container(
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close,
          color: Colors.black54,
          size: 20.sp,
        ),
      ),
      // Custom header with warning icon
      customHeader: Container(
        height: 90.h,
        width: 90.w,
        decoration: BoxDecoration(
          color: MyColor.poppy.withAlpha(20),
          shape: BoxShape.circle,
          border: Border.all(
            color: MyColor.poppy.withAlpha(100),
            width: 3,
          ),
        ),
        child: Icon(
          Iconsax.warning_2,
          color: MyColor.poppy,
          size: 45.sp,
        ),
      ),
      // Cancel button
      btnCancelOnPress: () {},
      btnCancelText: S.of(context).cancel,
      btnCancelColor: Colors.grey.shade500,
      btnCancelIcon: Iconsax.close_circle,
      // Confirm delete button
      btnOkOnPress: () {
        generalCubit.clearFavorites(context);
      },
      btnOkText: S.of(context).delete.toUpperCase(),
      btnOkColor: MyColor.poppy,
      btnOkIcon: Iconsax.trash,
      // Enhanced button styling
      buttonsTextStyle: FontHelper.fontText(
        size: 16.sp,
        weight: FontWeight.w700,
        color: Colors.white,
        context: context,
      ),
      buttonsBorderRadius: BorderRadius.circular(25.r),
      // Animation and interaction enhancements
      dismissOnTouchOutside: false,
      dismissOnBackKeyPress: false,
      useRootNavigator: true,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    // final favoritesCubit = BlocProvider.of<FavoritesCubit>(context);
    final generalCubit = BlocProvider.of<GeneralCubit>(context);
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      bloc: favoritesCubit,
      listenWhen: (previous, current) =>
          current is SetFavoriteItemLoaded ||
          current is UpdateFavoritePage ||
          current is FavoriteProductsError ||
          current is AddProductToCartError,
      listener: (context, state) {
        if (state is SetFavoriteItemLoaded || state is UpdateFavoritePage) {
          favoritesCubit.getFavoriteProducts(context);
        }
        if (state is AddProductToCartError) {
          log(state.message);
          favoritesCubit.hasFetchedFavorites = false;
        }
        if (state is FavoriteProductsError || state is AddProductToCartError) {
          favoritesCubit.hasFetchedFavorites = false;
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
                                  color: MyColor.poppy)),
                          onTap: () {
                            _showModernConfirmationDialog(
                                context, generalCubit);
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
                ? Center(child: CupertinoActivityIndicator())
                : state is FavoriteProductsLoaded
                    ? state.favoriteProducts.isEmpty
                        ? EmptyFavoriteProducts()
                        : NotEmptyFavoriteProducts(
                            favoriteProducts: state.favoriteProducts)
                    : state is FavoriteProductsError ||
                            state is AddProductToCartError
                        ? ErrorPage()
                        : SizedBox.shrink(),
          ),
        );
      },
    );
  }
}
