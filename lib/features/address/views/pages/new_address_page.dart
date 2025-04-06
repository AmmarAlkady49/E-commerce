import 'package:e_commerce_graduation/core/utils/themes/app_bar_default_theme.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/widgets/my_button1.dart';
import 'package:e_commerce_graduation/features/address/cubit/address_cubit.dart';
import 'package:e_commerce_graduation/features/address/models/address_model.dart';
import 'package:e_commerce_graduation/features/address/views/widgets/custom_drop_down_button.dart';
import 'package:e_commerce_graduation/features/address/views/widgets/text_form_field_address_page.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NewAddressPage extends StatefulWidget {
  const NewAddressPage({super.key});

  @override
  State<NewAddressPage> createState() => _NewAddressPageState();
}

class _NewAddressPageState extends State<NewAddressPage> {
  String? _selectedCountry;
  String? _selectedCite;
  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final List<String> countries = [
      S.of(context).egypt,
      S.of(context).palestine,
      S.of(context).saudi_arabia,
      S.of(context).qatar,
      S.of(context).bahrain,
    ];
    final List<String> cities = [
      S.of(context).alexandria,
      S.of(context).cairo,
      S.of(context).giza,
      S.of(context).mansoura,
      S.of(context).suez,
    ];

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final addressCubit = BlocProvider.of<AddressCubit>(context);
    return Scaffold(
      appBar: AppBarDefaultTheme(title: S.of(context).address_new),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 16.h),
                SvgPicture.asset('assets/images/other/map.svg'),
                SizedBox(height: 12.h),
                Text(
                  S.of(context).choose_your_location,
                  style: FontHelper.fontText(
                    context: context,
                    size: 22.sp,
                    weight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  S.of(context).make_sure_to_choose_your_location,
                  textAlign: TextAlign.center,
                  style: FontHelper.fontText(
                      context: context,
                      size: 16.sp,
                      weight: FontWeight.w500,
                      color: Colors.black54),
                ),
                SizedBox(height: 16.h),
                CustomDropDownButton(
                  title: S.of(context).country,
                  items: countries,
                  selectedValue: countries.first,
                  onChanged: (value) {
                    setState(() {
                      _selectedCountry = value;
                    });
                  },
                ),
                SizedBox(height: 8.h),
                CustomDropDownButton(
                  title: S.of(context).city,
                  items: cities,
                  selectedValue: cities.first,
                  onChanged: (value) {
                    setState(() {
                      _selectedCite = value;
                    });
                  },
                ),
                SizedBox(height: 8.h),
                TextFormFieldAddressPage(
                  title: S.of(context).area,
                  hintText: S.of(context).type_your_address,
                  formKey: formKey,
                  controller: addressController,
                ),
                SizedBox(height: 18.h),
                BlocBuilder<AddressCubit, AddressState>(
                  bloc: addressCubit,
                  buildWhen: (previous, current) =>
                      current is AddingNewAddress ||
                      current is AddNewAddressSucess ||
                      current is AddNewAddressError,
                  builder: (context, state) {
                    if (state is AddingNewAddress) {
                      return MyButton1(
                        width: double.infinity,
                        height: 48.h,
                        buttonTitle: S.of(context).loading,
                        onTap: () {},
                        isLoading: true,
                      );
                    }
                    return MyButton1(
                      width: double.infinity,
                      height: 48.h,
                      buttonTitle: S.of(context).save,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          addressCubit.addNewAddress(
                            AddressModel(
                              id: DateTime.now().toIso8601String(),
                              country: _selectedCountry ?? S.of(context).egypt,
                              city: _selectedCite ?? S.of(context).alexandria,
                              area: addressController.text,
                              // isDefault: false,
                            ),
                          );
                          Navigator.pop(context);
                          addressController.clear();
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
