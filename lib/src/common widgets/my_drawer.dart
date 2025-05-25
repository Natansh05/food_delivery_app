// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/common%20widgets/my_drawer_tile.dart';
import 'package:myapp/src/pages/login_page.dart';

import '../pages/past_orders.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> signOut() async{
      final authService = AuthService();
      try{
        await authService.signOut(context);
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginPage()));
      }
      catch (e){
        showDialog(context: context, builder: (context)=>AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.surface,
          title: Text(e.toString()),
        ));
      }
    }
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        
        children: [
          // app logo
          const Padding(
            padding: EdgeInsets.only(top: 100.0),
            child: Icon(
            Icons.lock_open_rounded,
            size: 100.0,
            //color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),

           Padding(
             padding: const EdgeInsets.all(25.0),
             child: Divider(
              height: 25.0,
              color: Theme.of(context).colorScheme.onSecondary,
             ),
           ),



          // home list tile
          MyDrawerTile(text: 'H O M E', icon: Icons.home, 
              onTap: ()=> Navigator.pop(context),),

          // profile list tile
          MyDrawerTile(text: 'P R O F I L E', icon: Icons.person,
              onTap: (){
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfilePage()));
              }),

          // Past Orders Tile
          MyDrawerTile(text: 'O R D E R  H I S T O R Y', icon: Icons.calendar_month_outlined,
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PastOrdersPage()));
              }),

          MyDrawerTile(text: 'S E T T I N G S', icon: Icons.settings,
              onTap: (){
            Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SettingsPage()));
              }),

          const Spacer(),
          //logout
          MyDrawerTile(text: 'L O G O U T', icon: Icons.logout_sharp, onTap: signOut),
          const SizedBox(height: 25.0),

        ],
      ),
    );
  }
}