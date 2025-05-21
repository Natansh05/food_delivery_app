import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/cart_page_footer.dart';
import 'package:myapp/src/common%20widgets/my_cart_tile.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>
      (builder: (context,restaurant,child){
        // cart
        final userCart = restaurant.cart;

        // scaffold ui
        return Scaffold(
          appBar: AppBar(
            title: const Text("C A R T"),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            foregroundColor: Theme.of(context).colorScheme.inversePrimary,
            actions: [
              // clear cart button
              IconButton(onPressed: (){
                showDialog(context: context, builder: (context)=> AlertDialog(
                  title: Text("Are you sure you want to clear the cart ?"),
                  actions: [
                    // cancel button
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text("Cancel"),),

                    // yes button
                    TextButton(onPressed: (){
                      restaurant.clearCart();
                      Navigator.pop(context);
                    }, child: Text("Clear"),),
                  ],
                ),);
              }, icon: Icon(Icons.delete),)
            ],
          ),
          body: Column(
            children: [


              //list of items in the cart
              Expanded(
                child: Column(
                  children: [
                    userCart.isEmpty ?
                    Expanded(child: Center(child: Text("Cart is empty..",style: TextStyle(
                      fontSize: 16.0,
                    ),),
                    )) :
                    Expanded(
                        child: ListView.builder(
                          itemCount: userCart.length,
                            itemBuilder: (context,index){

                              final cartItem = userCart[index];
                              return MyCartTile(cartItem: cartItem);
                            },
                        ),
                    ),
                    // checkout button
                    if(userCart.isNotEmpty)
                      // MyButton(
                      //     onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentPage())),
                      //     text: "Proceed to pay"),
                      // const SizedBox(
                      //   height: 25.0,
                      // )
                      CartPageFooter()
                  ],
                ),
              ),

            ],
          ),
        );

    });
  }
}
