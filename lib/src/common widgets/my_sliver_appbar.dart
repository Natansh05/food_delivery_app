import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  final List<Widget>? actions;

  const MySliverAppBar({
    super.key,
    required this.child,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
      return SliverAppBar(
        expandedHeight: 270,
        collapsedHeight: 80,
        floating: false,
        pinned: true,
         actions: actions,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        title: Text(
          "FLAVOR FLEET",
          style: TextStyle(
            // fontSize: 24.0, // Adjust the font size as needed
            fontWeight: FontWeight.bold, // Use a bold font weight for emphasis
            letterSpacing: 1.2, // Add some letter spacing for clarity
            color: Theme.of(context).colorScheme.onPrimary, // Set the text color to stand out on the app bar
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
