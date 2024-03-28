import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('H O M E'),
        centerTitle: true,
        elevation: 150.0,
      ),
      drawer: MyDrawer(),
    );
  }
}