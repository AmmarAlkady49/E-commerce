import 'package:e_commerce_graduation/core/models/product_response.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/favorites/cubit/favorites_cubit.dart';
import 'package:e_commerce_graduation/features/favorites/views/widgets/add_to_cart_button_fav_page.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddToCardAndDeleteFromFavorite extends StatelessWidget {
  final ProductItemModel productItem;
  const AddToCardAndDeleteFromFavorite({super.key, required this.productItem});

  @override
  Widget build(BuildContext context) {
    final favortiePageCubit = BlocProvider.of<FavoritesCubit>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: AddToCartButtonFavPage(productItem: productItem),
        ),
        IconButton(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  side: BorderSide(color: Colors.black54, width: 1.5.w),
                ),
              ),
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                      height: 80.h,
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.r),
                          topRight: Radius.circular(12.r),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          // favortiePageCubit.setFavoriteItem(productItem);
                          Navigator.of(context).pop();
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red.shade700),
                            SizedBox(width: 8.w),
                            Text(S.of(context).delete,
                                style: FontHelper.fontText(
                                  color: Colors.red.shade700,
                                  size: 16.sp,
                                  weight: FontWeight.w800,
                                  context: context,
                                )),
                          ],
                        ),
                      ));
                },
              );
            },
            icon: Icon(CupertinoIcons.ellipsis,
                color: Colors.black54, size: 20.sp)),
      ],
    );
  }
}
