import 'package:e_commerce_graduation/core/widgets/error_page.dart';
import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/custom_app_bar_for_category_products.dart';
import 'package:e_commerce_graduation/core/widgets/empty_search.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/product_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductsByCategory extends StatefulWidget {
  final String categoryCode;
  final String? categoryCode2;
  final String categoryName;
  const ProductsByCategory(
      {super.key,
      required this.categoryCode,
      this.categoryCode2,
      required this.categoryName});

  @override
  State<ProductsByCategory> createState() => _ProductsByCategoryState();
}

class _ProductsByCategoryState extends State<ProductsByCategory> {
  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  @override
  void initState() {
    super.initState();

    BlocProvider.of<HomeCubit>(context).getProductsByCategoryForHomePage(
      widget.categoryCode,
      widget.categoryCode2,
      page: _currentPage,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          !_isLoadingMore &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  void _loadMore() async {
    setState(() {
      _isLoadingMore = true;
      _currentPage++;
    });

    final cubit = BlocProvider.of<HomeCubit>(context);
    final moreProducts = await cubit.getProductsByCategoryForHomePage(
      widget.categoryCode,
      widget.categoryCode2,
      page: _currentPage,
    );

    setState(() {
      _isLoadingMore = false;
      if (moreProducts.isEmpty) _hasMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);
    return Scaffold(
      appBar: CustomAppBarForCategoryProducts(
          categoryCode: widget.categoryCode,
          categoryCode2: widget.categoryCode2),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          buildWhen: (previous, current) =>
              current is GetProductsByCategoryForHomePageLoading ||
              current is GetProductsByCategoryForHomePageError ||
              current is GetProductsByCategoryForHomePage,
          builder: (context, state) {
            if (state is GetProductsByCategoryForHomePageLoading) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (state is GetProductsByCategoryForHomePageError) {
              return ErrorPage();
            }
            if (state is GetProductsByCategoryForHomePage) {
              final products = state.products;
              if (products.isEmpty) {
                return EmptySearch();
              }
              return GridView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  mainAxisExtent: 240.h,
                  crossAxisCount: 2,
                ),
                itemCount: state.products.length + (_isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index < state.products.length) {
                    return ProductItem(
                      product: state.products[index],
                      isForCategoroesProducts: true,
                      categoryCode: widget.categoryCode,
                      categoryCode2: widget.categoryCode2,
                    );
                  } else {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(),
                      ],
                    );
                  }
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
