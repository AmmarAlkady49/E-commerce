import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/favorite_product_item.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/search_section_for_favorite_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotEmptyFavoriteProducts extends StatelessWidget {
  final List<ProductItemModel> favoriteProducts;
  const NotEmptyFavoriteProducts({super.key, required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
        child: Column(
          children: [
            SearchSectionForFavoritePage(),
            SizedBox(height: 12.h),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.h,
                mainAxisExtent: 260.h,
                crossAxisCount: 2,
              ),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) =>
                  FavoriteProductItem(product: favoriteProducts[index]),
            ),
          ],
        ),
      ),
    );
  }
}
