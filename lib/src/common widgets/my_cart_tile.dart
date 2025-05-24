
import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_quantity_selector.dart';
import 'package:myapp/src/models/cart_item.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({
    required this.cartItem,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context,restaurant,child)=> Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Theme.of(context).colorScheme.secondary,
        ),

        // color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // food name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // food name
                      Text(cartItem.food.name),

                      // food price
                      Text(' ₹${cartItem.food.price}',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),


                      // quantity changer
                      MyQuantitySelector(
                          food: cartItem.food,
                          quantity: cartItem.quantity,
                          onDecrement: (){
                            restaurant.removeFromCart(cartItem);
                          },
                          onIncrement: (){
                            restaurant.addToCart(cartItem.food, cartItem.selectedAddOns);
                          }),
                    ],
                  ),

                  // food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                        cartItem.food.imagePath,
                    height: 100.0,
                    width: 100.0,),
                  ),



                ],
              ),
            ),
            // AddOns
            SizedBox(
              height: cartItem.selectedAddOns.isEmpty ? 0 : 60,
              child: ListView(
                padding: EdgeInsets.only(left: 10,bottom: 10,right: 10),
                scrollDirection: Axis.horizontal,
                children: cartItem.selectedAddOns.map((addOn) => Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: FilterChip(
                      label: Row(

                        children: [
                          // addOn name
                          Text(addOn.name),


                          // add on price
                          Text(' (₹${addOn.price.toString()})'),
                        ],

                      ),
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onSelected: (value){
                      },
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),

                ),
                ).toList(),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
