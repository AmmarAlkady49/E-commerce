import 'package:e_commerce_graduation/core/utils/themes/font_helper.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/search/views/widgets/main_filter_page.dart';
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
                  backgroundColor: Colors.white,
                  isScrollControlled: true,
                  isDismissible: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Navigator(
                        onGenerateInitialRoutes:
                            (navigatorContext, initialRoute) {
                          return [
                            MaterialPageRoute(
                              builder: (navigatorContext) => MainFilterPage(),
                            ),
                          ];
                        },
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
    homeCubit.searchProducts(query: query);

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
              child: SingleChildScrollView(
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
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
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
