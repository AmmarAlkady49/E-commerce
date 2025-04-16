import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/features/address/models/address_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressCardItem extends StatelessWidget {
  final AddressModel address;
  const AddressCardItem({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return ElevatedButton(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Color(0xff1D61E7), width: 2),
        ),
      ),
      onPressed: () {
        // addressCubit.updateAddress(address);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Stack(
          children: [
            Positioned(
              top: 6.h,
              left: Localizations.localeOf(context).languageCode == 'ar'
                  ? 0.w
                  : null,
              right: Localizations.localeOf(context).languageCode == 'en'
                  ? 0.w
                  : null,
              child: Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    addressCubit.deleteAddress();
                  },
                  borderRadius: BorderRadius.circular(50.r),
                  child: Padding(
                    padding: EdgeInsets.all(2.0.r),
                    child:
                        Icon(Icons.clear, color: Colors.black87, size: 18.sp),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xff1D61E7), width: 2.0),
                  ),
                  child: Image.asset(
                    'assets/images/other/location.png',
                    height: 60.h,
                    width: 60.w,
                  ),
                ),
                SizedBox(width: 12.w),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.country,
                        style: FontHelper.fontText(
                            size: 16.sp,
                            context: context,
                            weight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      Text(
                        "${address.city}, ${address.address}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: FontHelper.fontText(
                            size: 15.sp,
                            context: context,
                            weight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
