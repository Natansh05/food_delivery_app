// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:FlavorFleet/src/common%20widgets/success_snackbar.dart';
import 'package:FlavorFleet/src/pages/home_page.dart';
import 'package:FlavorFleet/src/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _hasShownWelcome = false;

  @override
  Widget build(BuildContext context) {
    final authService = Supabase.instance.client.auth;
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null && session.user.emailConfirmedAt != null) {
          // Show snackbar only once per login
          if (!_hasShownWelcome) {
            _hasShownWelcome = true;
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (authService.currentUser?.userMetadata == null ||
                  authService.currentUser!.userMetadata!['name'] == null) {
                final snackbar =
                    successSnackBar(context, "Welcome to FlavorFleet 😃", true);
                ScaffoldMessenger.of(context).showSnackBar(
                    snackbar); // Don't show snackbar if name is not set
              } else {
                final userName = authService.currentUser!.userMetadata!['name'];
                final snackbar =
                    successSnackBar(context, "Welcome Back $userName 😃", true);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }

              if (authService.currentUser?.userMetadata == null ||
                  authService.currentUser!.userMetadata!['address'].isEmpty) {
                final snackbar = successSnackBar(context,
                    "Please Setup default Address for your convinience", false);
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
              // Reset flag after showing snackbar
            });
          }
          return const HomePage();
        } else {
          // Reset flag when logged out so snackbar can show again next time
          _hasShownWelcome = false;
          return const LoginPage();
        }
      },
    );
  }
}
