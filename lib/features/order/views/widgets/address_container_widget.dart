import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

class AddressContainerWidget extends StatelessWidget {
  const AddressContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddressCubit()..getAllAddresses(),
      child: Builder(builder: (context) {
        final addressCubit = BlocProvider.of<AddressCubit>(context);

        return BlocBuilder<AddressCubit, AddressState>(
          bloc: addressCubit,
          buildWhen: (previous, current) =>
              current is GettingAddresses ||
              current is GetAddressesSucess ||
              current is GetAddressesError,
          builder: (context, state) {
            if (state is GetAddressesSucess &&
                state.addresses.address == "null") {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.5),
                      blurRadius: 5,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          S.of(context).the_address,
                          style: FontHelper.fontText(
                            context: context,
                            size: 16,
                            weight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: () => Navigator.of(context)
                              .pushNamed(AppRoutes.addressPage)
                              .then(
                                (value) => addressCubit.getAllAddresses(),
                              ),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 12.h),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  // Icons.add_location_alt_outlined,
                                  Iconsax.location_add,
                                  size: 40,
                                  color: Colors.black45,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  S.of(context).no_address_found,
                                  style: FontHelper.fontText(
                                    context: context,
                                    size: 16,
                                    weight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    blurRadius: 5,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).the_address,
                      style: FontHelper.fontText(
                        context: context,
                        size: 16,
                        weight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(AppRoutes.addressPage)
                            .then(
                              (value) => addressCubit.getAllAddresses(),
                            ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 6.h),
                        leading: Image(
                          image: ResizeImage(
                            AssetImage(
                                'assets/images/home_page/location-unscreen2.gif'),
                            width: 110,
                            height: 110,
                          ),
                          width: 40,
                          height: 40,
                        ),
                        title: Padding(
                          padding: EdgeInsets.only(bottom: 4.h),
                          child: Text(
                            S.of(context).delivery_to,
                            style: FontHelper.fontText(
                              context: context,
                              size: 14,
                              weight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        subtitle: state is GetAddressesSucess
                            ? Text(
                                '${S.of(context).street2} ${state.addresses.address}, ${state.addresses.city}, ${state.addresses.country}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: FontHelper.fontText(
                                  context: context,
                                  size: 15,
                                  weight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              )
                            : Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor: Colors.grey[200]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 20.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(AppRoutes.addressPage),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
