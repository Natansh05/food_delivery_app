
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_gate.dart';
import 'package:myapp/Services/auth/login_or_register.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/models/user_data.dart';
import 'package:myapp/src/pages/home_page.dart';
import 'package:myapp/src/pages/login_page.dart';
import 'package:myapp/src/pages/register_page.dart';
import 'package:myapp/src/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
      // theme provider
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      // restaurant provider
      ChangeNotifierProvider(create: (context)=>Restaurant()),
      ChangeNotifierProvider(create: (context) => UserData()),
    ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: LoginOrRegister(),
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,

    );
  }
}
