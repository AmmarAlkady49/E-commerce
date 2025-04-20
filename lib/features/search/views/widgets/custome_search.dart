import 'dart:developer';

import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
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
          backgroundColor: Colors.white,
          elevation: 0,
          shape: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 1.0)),
          toolbarHeight: 55.h,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: FontHelper.fontText(
              size: 16.sp,
              weight: FontWeight.w400,
              color: Colors.black54,
              context: context),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(
              color: Colors.black45,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide.none,
          ),
        ));
  }

  @override
  TextStyle? get searchFieldStyle => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  @override
  List<Widget>? buildActions(BuildContext context) {
    // log(homeCubit.categoriesList.length.toString());
    return [
      Padding(
        padding: EdgeInsets.only(left: 8.w),
        child: InkWell(
            borderRadius: BorderRadius.circular(13.r),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 4.w, top: 4.w, bottom: 4.w, right: 4.w),
              child: const Icon(Icons.clear, color: Colors.black87),
            ),
            onTap: () {
              query = '';
              showSuggestions(context);
            }),
      ),
      Padding(
        padding: EdgeInsets.only(left: 4.w),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          buildWhen: (previous, current) => current is LoadedCategories,
          builder: (context, state) {
            return IconButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Color(0xff1D61E7).withAlpha(730),
                ),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.r),
                  ),
                ),
              ),
              icon: const Icon(
                CupertinoIcons.slider_horizontal_3,
                color: Colors.white,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.r)),
                  ),
                  backgroundColor: Colors.white,
                  isScrollControlled: true, // in case your content is big
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 40.w,
                              height: 4.h,
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Text(
                            S
                                .of(context)
                                .filter_options, // Make sure to localize this string
                            style: FontHelper.fontText(
                              context: context,
                              size: 18.sp,
                              weight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          // Example filters

                          Text("Category"),
                          Wrap(
                            spacing: 8,
                            children: state is LoadedCategories
                                ? List.generate(
                                    state.categories.length,
                                    (index) {
                                      final category = state.categories[index];
                                      final isSelected = homeCubit
                                          .categoriesList
                                          .contains(category);

                                      return ChoiceChip(
                                        label: Text(category.name),
                                        selected: isSelected,
                                        // onSelected: (_) {
                                        //   homeCubit.toggleCategorySelection(
                                        //       category);
                                        // },
                                      );
                                    },
                                  )
                                : [Text("Loading...")],
                          ),

                          SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Close modal
                              // Trigger filter logic
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                            ),
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                child: Text(
                                  S.of(context).apply_filters,
                                  style: FontHelper.fontText(
                                    context: context,
                                    size: 14.sp,
                                    weight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
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
        color: Colors.black87,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // return SizedBox.shrink();
    homeCubit.searchProducts(query); // 👈 تشغيل البحث

    return Container(
      decoration: BoxDecoration(color: Colors.grey.shade50),
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: homeCubit,
        buildWhen: (previous, current) =>
            current is SearchLoaded ||
            current is SearchError ||
            current is SearchLoading,
        builder: (context, state) {
          if (state is SearchLoading) {
            return Center(child: CupertinoActivityIndicator());
          } else if (state is SearchLoaded) {
            if (state.searchResults.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: 50.h),
                    Icon(CupertinoIcons.search,
                        size: 75, color: Colors.black54),
                    SizedBox(height: 4.h),
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
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${S.of(context).search_result_for} "$query" (${state.searchResults.length})',
                    style: FontHelper.fontText(
                        size: 16.sp,
                        weight: FontWeight.w600,
                        color: Colors.black,
                        context: context),
                  ),
                  SizedBox(height: 16.h),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 15,
                            crossAxisCount: 2,
                            mainAxisExtent: 300,
                            mainAxisSpacing: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => ProductSearchItem(
                      product: state.searchResults[index],
                      homeCubit: homeCubit,
                    ),
                    itemCount: state.searchResults.length,
                  )
                ],
              ),
            );
          } else if (state is SearchError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
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
                          color: Color(0xff1D61E7),
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
