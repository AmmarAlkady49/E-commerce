import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/features/address/models/address_model.dart';
import 'package:e_commerce_graduation/features/address/views/widgets/address_card_item.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotEmptyAddresses extends StatelessWidget {
  final AddressModel address;
  const NotEmptyAddresses({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: double.infinity),
        Text(
          S.of(context).choose_your_location,
          style: FontHelper.fontText(
            context: context,
            size: 20.sp,
            weight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          S.of(context).please_select_axact_address,
          style: FontHelper.fontText(
            context: context,
            size: 15.sp,
            weight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          S.of(context).selecet_location,
          style: FontHelper.fontText(
            context: context,
            size: 20.sp,
            weight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12.h),
        AddressCardItem(address: address),
        Spacer(),
        MyButton1(
            width: double.infinity,
            height: 48.h,
            buttonTitle: S.of(context).change_address,
            onTap: () {
              addressCubit.deleteAddress();
              Navigator.pushNamed(context, AppRoutes.newAddressPage).then(
                (value) => addressCubit.getAllAddresses(),
              );
            }),
        SizedBox(height: 32.h),
      ],
    );
  }
}
