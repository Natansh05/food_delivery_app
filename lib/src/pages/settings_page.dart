import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/src/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 150.0,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [

          //SWICTH
          Container(
            padding: EdgeInsets.all(20.0),
            margin: EdgeInsets.only(left: 25.0, top: 10.0, right: 25.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text("Dark Mode ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),),
                CupertinoSwitch(
                    value: Provider.of<ThemeProvider>(context,listen: true).isDarkMode,
                    onChanged: (value)=>Provider.of<ThemeProvider>(context,listen: false).toggleTheme(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
