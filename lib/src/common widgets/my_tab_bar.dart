import 'package:flutter/material.dart';
import 'package:FlavorFleet/src/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Category> categories;

  const MyTabBar({
    super.key,
    required this.tabController,
    required this.categories,
  });

  List<Tab> _buildCategoryTabs() {
    return categories.map((category) {
      return Tab(
        text: category.name, // or category.title, depending on your model
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelColor: Theme.of(context).colorScheme.surface,
      controller: tabController,
      tabs: _buildCategoryTabs(),
    );
  }
}
