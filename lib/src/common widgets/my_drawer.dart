import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        
        children: [

          const SizedBox(
            height: 100.0,
          ),
          // app logo
          Icon(
          Icons.lock_open_rounded,
          size: 100.0,
          color: Theme.of(context).colorScheme.primary,
          ),

           Divider(
            height: 25.0,
            color: Theme.of(context).colorScheme.primary,
          ),


          // home list tile
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
              Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 10.0,),
              Text("H O M E",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ],),
          ),

          const SizedBox(
            height: 10.0,
          ),



          // settings list tile
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
              Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 10.0,),
              Text("S E T T I N G S",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),),
            ],),
          ),



          //logout
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 20.0),
            child: Row(
              children: [
                Icon(Icons.logout_sharp),
                SizedBox(width: 10.0,),
                Text("L O G O U T",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),),
              ],
            ),
          )




        ],
      ),
    );
  }
}