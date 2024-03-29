import 'package:flutter/material.dart';

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
           IconButton(onPressed: (){}, icon: const Icon(Icons.shopping_cart))
         ],
        backgroundColor: Theme.of(context).colorScheme.background,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Sunset Dinner"),
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
