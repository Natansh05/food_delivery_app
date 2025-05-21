import 'package:flutter/material.dart';

SnackBar successSnackBar(BuildContext context, String message,bool isSuccess) {
  final snackbar = SnackBar(
    content: Text(
      message,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    ),
    duration: const Duration(milliseconds: 2000),
    behavior: SnackBarBehavior.floating,
    backgroundColor: isSuccess ? Colors.green : Colors.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
    margin: const EdgeInsets.only(
      bottom: 20.0,
      left: 20.0,
      right: 20.0,
    ),
  );

  return snackbar;
}
