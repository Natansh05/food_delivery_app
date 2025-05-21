import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/custom_cart_item.dart';
import 'package:myapp/src/common%20widgets/my_current_location.dart';
import 'package:myapp/src/common%20widgets/my_description_box.dart';
import 'package:myapp/src/common%20widgets/my_drawer.dart';
import 'package:myapp/src/common%20widgets/my_food_tile.dart';
import 'package:myapp/src/common%20widgets/my_sliver_appbar.dart';
import 'package:myapp/src/common%20widgets/my_tab_bar.dart';
import 'package:myapp/src/models/food.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/pages/cart_page.dart';
import 'package:myapp/src/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  late TabController _tabController;


  @override

  void initState(){
    super.initState();
    _tabController = TabController(length: FoodCategory.values.length , vsync: this );
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

// sort out and return a list of food items that belong to a specific category
  List<Food> _filterMenubyCategory(FoodCategory category,List<Food> fullMenu){
    return fullMenu.where((food) => food.category==category).toList();
  }


  // return the list of foods in given category
  List<Widget> getFoodInThisCategory(List<Food> fullMenu){
    return FoodCategory.values.map((category){
       // get category menu
      List<Food> categoryMenu = _filterMenubyCategory(category, fullMenu);
      return ListView.builder(
        itemCount: categoryMenu.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
          // getting individual food item
          final food = categoryMenu[index];

          // return food tile for each food
            return FoodTile(food: food,
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=> FoodPage(food: food),
                  ),
                ),
            );
          },);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context,innerBoxIsScrolled)=>[
           MySliverAppBar(
            title: MyTabBar(tabController: _tabController,),
            actions: [
              CartIconWithBadge(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const CartPage()));
                },
                // icon: const Icon(Icons.shopping_cart),
              ),
            ],
            child:  Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                 Divider(
                  indent: 25.0,
                  endIndent: 25.0,
                  color: Theme.of(context).colorScheme.secondary,
                ),


                //my current location
                MyCurrentLocation(icon: Icon(Icons.location_on),),
                // description box
                const MyDescriptionBox(),

              ],
            ),
          ),
          
        ],
        body: Consumer<Restaurant>(
          builder : (context,restaurant,child)=> TabBarView(
            controller: _tabController,
              children: getFoodInThisCategory(restaurant.menu))
        )
      ),
    );
  }
}