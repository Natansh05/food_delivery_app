import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
import 'package:myapp/src/pages/home_page.dart';
import 'package:myapp/src/pages/login_page.dart';
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
              final snackbar =
                  successSnackBar(context, "Welcome Back User", true);
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
