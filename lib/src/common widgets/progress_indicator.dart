import 'package:flutter/material.dart';
import 'package:flavorfleet/src/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Provider.of<ThemeProvider>(context).isDarkMode
            ? Colors.white
            : Colors.black,
      ),
    );
  }
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => const CustomProgressIndicator(),
  );
}

/// Function to hide the loading dialog
void hideLoadingDialog(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}
