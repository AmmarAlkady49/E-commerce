import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/features/address/views/widgets/empty_addresses.dart';
import 'package:e_commerce_graduation/features/address/views/widgets/not_empty_addresses.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBarDefaultTheme(title: S.of(context).address),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 16.h),
        child: BlocConsumer<AddressCubit, AddressState>(
          bloc: addressCubit,
          listenWhen: (previous, current) =>
              current is DeleteAddressSucess ||
              current is AddNewAddressSucess ||
              current is UpdateAddressSucess ||
              current is UpdateAddressError,
          listener: (context, state) {
            if (state is DeleteAddressSucess ||
                state is AddNewAddressSucess ||
                state is UpdateAddressSucess) {
              addressCubit.getAllAddresses();
            }
          },
          buildWhen: (previous, current) =>
              current is GettingAddresses ||
              current is GetAddressesSucess ||
              current is GetAddressesError,
          builder: (context, state) {
            if (state is GettingAddresses) {
              return const Center(child: CupertinoActivityIndicator());
            } else if (state is GetAddressesError) {
              return Center(child: Text(state.message));
            } else if (state is GetAddressesSucess) {
              final addresses = state.addresses;
              if (addresses.isEmpty) {
                return EmptyAddresses();
              } else {
                return NotEmptyAddresses(
                  addresses: addresses,
                );
              }
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
