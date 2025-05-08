import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class EmptyAddresses extends StatelessWidget {
  const EmptyAddresses({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.location,
              size: 55.sp,
              color: Colors.black,
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).no_saved_addresses,
              style: FontHelper.fontText(
                  size: 22.sp,
                  weight: FontWeight.bold,
                  color: Colors.black,
                  context: context),
            ),
            SizedBox(height: 4.h),
            Text(
              S.of(context).you_havenot_saved_any_address,
              textAlign: TextAlign.center,
              style: FontHelper.fontText(
                  size: 16.sp,
                  weight: FontWeight.w500,
                  color: Colors.black45,
                  context: context),
            ),
            SizedBox(height: 16.h),
            MyButton1(
              width: double.infinity,
              height: 48.h,
              buttonTitle: S.of(context).add_new_address,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.newAddressPage)
                    .then((_) {
                  addressCubit.getAllAddresses();
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
