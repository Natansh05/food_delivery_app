import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(horizontal: 25.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(5.0)

        ),
        child: Center(
            child: Text(text,
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),),
        ),
      ),
    );
  }
}