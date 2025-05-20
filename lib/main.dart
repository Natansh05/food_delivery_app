import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_gate.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/models/user_data.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // Only after at least the action method is set, the notification events are delivered
    super.initState();
  }
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


