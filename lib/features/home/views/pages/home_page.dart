import 'package:e_commerce_graduation/features/home/views/widgets/categort_tap.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/home_app_bar.dart';
import 'package:e_commerce_graduation/features/home/views/widgets/home_tap.dart';
import 'package:flutter/material.dart';

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
          appBar: HomeAppBar(
            tabController: _tabController,
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              HomeTap(),
              CategoryTap(),
            ],
          ),
        ));
  }
}
