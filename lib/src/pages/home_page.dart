import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:FlavorFleet/src/common%20widgets/custom_cart_item.dart';
import 'package:FlavorFleet/src/common%20widgets/my_current_location.dart';
import 'package:FlavorFleet/src/common%20widgets/my_description_box.dart';
import 'package:FlavorFleet/src/common%20widgets/my_drawer.dart';
import 'package:FlavorFleet/src/common%20widgets/my_food_tile.dart';
import 'package:FlavorFleet/src/common%20widgets/my_sliver_appbar.dart';
import 'package:FlavorFleet/src/common%20widgets/my_tab_bar.dart';
import 'package:FlavorFleet/src/models/food.dart';
import 'package:FlavorFleet/src/models/restaurants.dart';
import 'package:FlavorFleet/src/pages/cart_page.dart';
import 'package:FlavorFleet/src/pages/food_page.dart';
import 'package:FlavorFleet/src/models/user_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();

    // Initialize user data and foods
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final restaurant = Provider.of<Restaurant>(context, listen: false);
      final user = Provider.of<UserData>(context, listen: false);

      await restaurant.fetchCategories();

      if (mounted) {
        setState(() {
          _tabController = TabController(
            length: restaurant.categories.length,
            vsync: this,
          );
        });
      }

      await restaurant.fetchFoods();
      user.initialize();
      debugPrint("Restaurant categories: ${restaurant.categories[0].name}");
      debugPrint("Restaurant menu: ${restaurant.menu[0].category.name}");
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  // Filter menu by category
  List<Food> _filterMenuByCategory(Category category, List<Food> menu) {
    List<Food> filtered =
        menu.where((food) => food.category.id == category.id).toList();
    debugPrint(
        "Filtered menu for category ${category.name}: ${filtered.length} items");
    return filtered;
  }

  // Build list of food widgets for each category tab
  Widget _buildCategoryTab(List<Food> menu, Category category) {
    final categoryMenu = _filterMenuByCategory(category, menu);
    if (categoryMenu.isEmpty) {
      return const Center(child: Text("No items found in this category"));
    }

    return Container(
      color: Theme.of(context).colorScheme.surface, // or .surface
      child: ListView.builder(
        itemCount: categoryMenu.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final food = categoryMenu[index];
          return FoodTile(
            food: food,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => FoodPage(food: food)),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        // Wait until both categories and controller are ready
        if (restaurant.categories.isEmpty || _tabController == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return Scaffold(
          drawer: const MyDrawer(),
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              MySliverAppBar(
                title: MyTabBar(
                  tabController: _tabController!,
                  categories: restaurant.categories,
                ),
                actions: [
                  CartIconWithBadge(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const CartPage()),
                    ),
                  ),
                ],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const MyCurrentLocation(icon: Icon(Icons.location_on)),
                    const MyDescriptionBox(),
                  ],
                ),
              ),
            ],
            body: TabBarView(
              controller: _tabController,
              children: restaurant.categories
                  .map((category) =>
                      _buildCategoryTab(restaurant.menu, category))
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
