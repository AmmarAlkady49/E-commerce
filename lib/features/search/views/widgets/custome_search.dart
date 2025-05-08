import 'package:e_commerce_graduation/core/utils/routes/app_routes.dart';
import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/core/utils/themes/my_color.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/category_list_view_widget.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/filter_icon_button.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/product_search_item.dart';
import 'package:e_commerce_graduation/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeSearch extends SearchDelegate {
  final HomeCubit homeCubit;
  CustomeSearch({required this.homeCubit});

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: MyColor.kellyGreen3,
          elevation: 4,
          shadowColor: Colors.black,
          toolbarHeight: 57.h,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w400,
              color: Colors.black54,
              context: context),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide.none,
          ),
        ));
  }

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'cairo',
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: InkWell(
            borderRadius: BorderRadius.circular(13.r),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 4.w, top: 4.w, bottom: 4.w, right: 4.w),
              child: const Icon(Icons.clear, color: Colors.white),
            ),
            onTap: () {
              query = '';
              showSuggestions(context);
            }),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13.r),
          ),
        ),
      ),
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.white,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    homeCubit.searchProducts(query: query);

    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Colors.grey.shade100),
      child: SingleChildScrollView(
        child: Column(
          children: [
            CategoryListViewWidget(),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: homeCubit,
              buildWhen: (previous, current) =>
                  current is SearchLoaded ||
                  current is SearchError ||
                  current is SearchLoading ||
                  current is FilterLoaded ||
                  current is FilterError ||
                  current is FilterLoading ||
                  current is LoadedCategories,
              builder: (context, state) {
                if (state is SearchLoading || state is FilterLoading) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height -
                        AppBar().preferredSize.height -
                        60.h,
                    child: const Center(child: CupertinoActivityIndicator()),
                  );
                } else if (state is SearchLoaded || state is FilterLoaded) {
                  final products = homeCubit.searchResults;

                  if (products.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 50.h),
                          Icon(CupertinoIcons.search,
                              size: 75, color: Colors.black54),
                          SizedBox(height: 8.h),
                          Text(
                            S.of(context).no_products_found,
                            style: FontHelper.fontText(
                              size: 16.sp,
                              weight: FontWeight.w600,
                              color: Colors.black54,
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${S.of(context).search_result_for} "$query" (${products.length})',
                              style: FontHelper.fontText(
                                size: 16.sp,
                                weight: FontWeight.w700,
                                color: Colors.black,
                                context: context,
                              ),
                            ),
                            FilterIconButton(),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  crossAxisCount: 2,
                                  mainAxisExtent: 300,
                                  mainAxisSpacing: 15),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, AppRoutes.productPage,
                                arguments: products[index]),
                            child: ProductSearchItem(
                              product: products[index],
                              homeCubit: homeCubit,
                            ),
                          ),
                          itemCount: products.length,
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  );
                } else if (state is SearchError || state is FilterError) {
                  return Center(child: Text('Something went wrong'));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final cubit = homeCubit;
    return Container(
      color: Colors.white,
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: cubit,
        buildWhen: (previous, current) => current is SearchRecentUpdated,
        builder: (context, state) {
          final recent = cubit.reacentSearches;

          if (recent.isEmpty) {
            return Center(
              child: Text(
                S.of(context).no_recent_searches,
                style: FontHelper.fontText(
                  size: 14.sp,
                  weight: FontWeight.w500,
                  color: Colors.black54,
                  context: context,
                ),
              ),
            );
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      S.of(context).last_search,
                      style: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: Colors.black87,
                        context: context,
                      ),
                    ),
                    TextButton(
                      onPressed: () => cubit.clearRecentSearches(),
                      child: Text(
                        S.of(context).clear_all,
                        style: FontHelper.fontText(
                          size: 12.sp,
                          weight: FontWeight.w700,
                          color: MyColor.kellyGreen2,
                          context: context,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: recent.length,
                  separatorBuilder: (_, __) =>
                      Divider(color: Colors.grey.shade300),
                  itemBuilder: (context, index) {
                    final item = recent[index];

                    return ListTile(
                      leading:
                          Icon(CupertinoIcons.clock, color: Colors.black54),
                      title: Text(
                        item,
                        style: FontHelper.fontText(
                          size: 16.sp,
                          weight: FontWeight.w600,
                          color: Colors.black,
                          context: context,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.clear, size: 20, color: Colors.grey),
                        onPressed: () => cubit.removeSearchItem(item),
                      ),
                      onTap: () {
                        query = item;
                        showResults(context);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
