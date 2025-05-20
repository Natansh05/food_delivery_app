import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool check;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    Key? key,
    required this.check,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          suffixIcon: widget.check
              ? IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Theme.of(context).colorScheme.onPrimary, // Set icon color here
            ),
          )
              : IconButton(
            onPressed: () {
              widget.controller.clear();
            },
            icon: const Icon(Icons.clear),
            color: Theme.of(context).colorScheme.onPrimary, // Set icon color here
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          fillColor: Theme.of(context).colorScheme.background,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
    );
  }
}
