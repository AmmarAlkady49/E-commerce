import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class SearchSectionForFavoritePage extends StatefulWidget {
  const SearchSectionForFavoritePage({super.key});

  @override
  State<SearchSectionForFavoritePage> createState() =>
      _SearchSectionForFavoritePageState();
}

class _SearchSectionForFavoritePageState
    extends State<SearchSectionForFavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: S.of(context).search_in_your_favorite,
          hintStyle: FontHelper.fontText(
              context: context,
              size: 14.sp,
              weight: FontWeight.w600,
              color: Colors.black54),
          // prefixIcon: Icon(Iconsax.search_normal_1, color: Colors.black87),
          suffixIcon: IconButton(
              onPressed: () {},
              icon: Icon(Iconsax.search_normal_1, color: Colors.black87)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black54, width: 0.7.w),
            borderRadius: BorderRadius.circular(16.r),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black87, width: 1.2.w),
            borderRadius: BorderRadius.circular(16.r),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.2.w),
            borderRadius: BorderRadius.circular(16.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.w),
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return S.of(context).please_enter_a_search_term;
          }
          return null;
        },
        onChanged: (value) => BlocProvider.of<FavoritesCubit>(context)
            .searchFavoriteProducts(value, context),
      ),
    );
  }
}
