// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flavorfleet/src/common%20widgets/success_snackbar.dart';
import 'package:flavorfleet/src/pages/home_page.dart';
import 'package:flavorfleet/src/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  _AuthGateState createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  Session? _session;
  bool _hasShownWelcome = false;

  @override
  void initState() {
    super.initState();

    // Check current session on start
    final auth = Supabase.instance.client.auth;
    _session = auth.currentSession;

    // Listen for auth state changes
    auth.onAuthStateChange.listen((data) {
      final session = data.session;
      setState(() {
        _session = session;
      });

      if (session != null && !_hasShownWelcome) {
        _hasShownWelcome = true;
        final user = session.user;
        final name = user.userMetadata?['name'];
        final address = user.userMetadata?['address'];

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final nameSnack = successSnackBar(
            context,
            name == null
                ? "Welcome to flavorfleet 😃"
                : "Welcome Back $name 😃",
            true,
          );
          ScaffoldMessenger.of(context).showSnackBar(nameSnack);

          if (address == null || (address is String && address.isEmpty)) {
            final addressSnack = successSnackBar(
              context,
              "Please Setup default Address for your convenience",
              false,
            );
            ScaffoldMessenger.of(context).showSnackBar(addressSnack);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_session != null && _session!.user.emailConfirmedAt != null) {
      return const HomePage();
    } else {
      _hasShownWelcome = false;
      return const LoginPage();
    }
  }
}
