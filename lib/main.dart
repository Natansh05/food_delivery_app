
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_gate.dart';
import 'package:myapp/Services/auth/login_or_register.dart';
import 'package:myapp/firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:myapp/src/models/restaurants.dart';
import 'package:myapp/src/models/user_data.dart';
import 'package:myapp/src/pages/home_page.dart';
import 'package:myapp/src/pages/login_page.dart';
import 'package:myapp/src/pages/register_page.dart';
import 'package:myapp/src/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'Services/notifcations/notification_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      '',
      [
        NotificationChannel(
            channelGroupKey: 'Orders_Group_key',
            channelKey: 'orders_channel',
            channelName: 'Order notifications',
            channelDescription: 'Notification channel for managing user order notifications',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.Max,
            playSound: true,
            enableVibration: true,
            enableLights: true,
            locked: false, // Allow the notification to be dismissed
        )
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'Orders_Group_key',
            channelGroupName: 'Orders group')
      ],
      debug: true
  );

  bool isAllowedtoSendNotifications = await AwesomeNotifications().isNotificationAllowed();
    if(!isAllowedtoSendNotifications){
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
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
    AwesomeNotifications().setListeners(
        onActionReceivedMethod:         NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:    NotificationController.onNotificationCreatedMethod,
        onNotificationDisplayedMethod:  NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:  NotificationController.onDismissActionReceivedMethod
    );
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


