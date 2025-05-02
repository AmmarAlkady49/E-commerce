import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBarForCategoryProducts extends StatefulWidget
    implements PreferredSizeWidget {
  final String? categoryCode;
  final String? categoryCode2;
  const CustomAppBarForCategoryProducts(
      {super.key, this.categoryCode, this.categoryCode2});

  @override
  State<CustomAppBarForCategoryProducts> createState() =>
      _CustomAppBarForCategoryProductsState();

  @override
  Size get preferredSize => Size.fromHeight(55.h);
}

class _CustomAppBarForCategoryProductsState
    extends State<CustomAppBarForCategoryProducts> {
  late TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return AppBar(
      backgroundColor: const Color(0xff1D61E7),
      elevation: 4.0,
      shadowColor: Colors.black,
      toolbarHeight: 55.h,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: S.current.search_,
          hintStyle: FontHelper.fontText(
            context: context,
            size: 16.sp,
            weight: FontWeight.w600,
            color: Colors.grey,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 20.w),
          suffixIcon: _searchController.text.isEmpty
              ? null
              : IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    homeCubit.searchForProductsInCategory(
                        widget.categoryCode!, widget.categoryCode2, '');
                  },
                ),
        ),
        style: FontHelper.fontText(
          context: context,
          size: 16.sp,
          weight: FontWeight.w600,
          color: Colors.black87,
        ),
        onSubmitted: (value) async {
          homeCubit.searchForProductsInCategory(
              widget.categoryCode!, widget.categoryCode2, value);
        },
      ),
    );
  }
}
