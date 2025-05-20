import 'package:flutter/material.dart';
import 'package:myapp/src/pages/cart_page.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
      return SliverAppBar(
        expandedHeight: 340,
        collapsedHeight: 80,
        floating: false,
        pinned: true,
         actions: [
           IconButton(onPressed: (){
             // GO TO CART PAGE
             Navigator.push(context, MaterialPageRoute(builder: (context)=>const CartPage(),),);
           }, icon: const Icon(Icons.shopping_cart))
         ],
        backgroundColor: Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          "FLAVOR FLEET",
          style: TextStyle(
            // fontSize: 24.0, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Use a bold font weight for emphasis
            letterSpacing: 1.2, // Add some letter spacing for clarity
            color: Theme.of(context).colorScheme.primary, // Set the text color to stand out on the app bar
          ),
        ),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Padding(
            padding: const EdgeInsets.only(bottom: 50.0 ),
            child: child,
          ),
          title: title,
          centerTitle: true,
          titlePadding: const EdgeInsets.only(left: 0.0,right: 0.0,top: 0.0),
           expandedTitleScale: 1,

        ),

      );
  }
}
