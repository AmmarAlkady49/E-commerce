import 'package:e_commerce_graduation/features/home/home_bubit/cubit/home_cubit.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/categort_tap.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/home_app_bar.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/home_tap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getUserData();
    context.read<HomeCubit>().getAllProducts();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: NestedScrollView(
            controller: ScrollController(),
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: HomeAppBar(tabController: _tabController),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: const [
                HomeTap(),
                CategoryTap(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
