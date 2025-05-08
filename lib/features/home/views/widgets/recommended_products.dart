import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/product_item.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(S.of(context).recommended_for_you,
                style: FontHelper.fontText(
                    size: 17.sp,
                    weight: FontWeight.w800,
                    color: Colors.black,
                    context: context)),
            const Spacer(),
            Text(S.of(context).see_all,
                style: FontHelper.fontText(
                    size: 12.sp,
                    weight: FontWeight.w800,
                    color: MyColor.kellyGreen3,
                    context: context)),
          ],
        ),
        SizedBox(height: 12.h),
        BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is ErrorHomeProducts) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: FontHelper.fontText(
                      size: 15.sp,
                      weight: FontWeight.w600,
                      color: Colors.white,
                      context: context),
                ),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
              ));
            }
          },
          listenWhen: (previous, current) =>
              current is LoadingHomeProducts ||
              current is LoadedHomeProducts ||
              current is ErrorHomeProducts,
          bloc: homeCubit,
          buildWhen: (previous, current) =>
              current is LoadingHomeProducts ||
              current is LoadedHomeProducts ||
              current is ErrorHomeProducts,
          builder: (context, state) {
            if (state is LoadingHomeProducts) {
              return const Center(
                  child: CupertinoActivityIndicator(color: Colors.black));
            } else if (state is ErrorHomeProducts) {
              return Center(child: Text(state.error));
            } else if (state is LoadedHomeProducts) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  mainAxisExtent: 230.h,
                  crossAxisCount: 2,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) =>
                    ProductItem(product: state.products[index]),
              );
            } else {
              return SizedBox.shrink();
            }
          },
        )
      ],
    );
  }
}
