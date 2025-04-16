import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/model/favorite_item_model.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCartButtonFavPage extends StatelessWidget {
  final FavoriteItemModel productItem;
  const AddToCartButtonFavPage({super.key, required this.productItem});

  get favortiePageCubit => null;

  @override
  Widget build(BuildContext context) {
    final favortiePageCubit = BlocProvider.of<FavoritesCubit>(context);
    return BlocConsumer<FavoritesCubit, FavoritesState>(
      listenWhen: (previous, current) => current is AddProductToCartLoaded,
      listener: (context, state) {
        // if (State is AddProductToCartLoaded) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(S.of(context).added),
        //       duration: const Duration(seconds: 1),
        //     ),
        //   );
        // }
      },
      bloc: favortiePageCubit,
      buildWhen: (previous, current) =>
          (current is AddProductToCartLoading &&
              current.productId == productItem.productId) ||
          (current is AddProductToCartLoaded &&
              current.productId == productItem.productId) ||
          (current is AddProductToCartError &&
              current.productId == productItem.productId),
      builder: (context, state) {
        return TextButton(
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(state is AddProductToCartLoaded
                    // ? Colors.green.withValues(alpha: 0.9)
                    ? Colors.grey.withValues(alpha: 0.9)
                    : Color(0xff1D61E7).withValues(alpha: 0.8)),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          onPressed: () {
            // state is! AddProductToCartLoaded
            //   ? favortiePageCubit.addToCart(productItem)
            //   : null;
          },
          child: state is AddProductToCartLoading
              ? CupertinoActivityIndicator(color: Colors.white)
              : state is AddProductToCartLoaded
                  ? Text(S.of(context).added,
                      style: FontHelper.fontText(
                        color: Colors.white,
                        size: 13.sp,
                        weight: FontWeight.w800,
                        context: context,
                      ))
                  : Text(S.of(context).add_to_card2,
                      style: FontHelper.fontText(
                        color: Colors.white,
                        size: 13.sp,
                        weight: FontWeight.w800,
                        context: context,
                      )),
        );
      },
    );
  }
}
