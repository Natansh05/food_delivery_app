import 'package:FlavorFleet/src/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:FlavorFleet/src/common%20widgets/success_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient supabase = Supabase.instance.client;

  Future<(User?, String?)> signInWithEmailPassword(String email, String pass) async {
  try {
    final AuthResponse response = await supabase.auth.signInWithPassword(
      email: email,
      password: pass,
    );
    return (response.user, null);
  } on AuthException catch (e) {
    debugPrint('Auth error: ${e.message}');
    return (null, e.message);
  } catch (e) {
    debugPrint('General error: $e');
    return (null, 'An unknown error occurred.');
  }
}


  Future<AuthResponse?> signUpwithEmailPassword(String email, String pass) async {
    try {
      final AuthResponse response = await supabase.auth.signUp(
        email: email,
        password: pass,
      );
      return response;
    } catch (e) {
      debugPrint('Error signing in: $e');
      return null;
    }
  }

  User? getCurrentUser() {
    return supabase.auth.currentUser;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await supabase.auth.signOut();
      debugPrint('User signed out');
      // ignore: use_build_context_synchronously
      Provider.of<ThemeProvider>(context, listen: false).setLightMode();
      final snackBar = successSnackBar(
        // ignore: use_build_context_synchronously
        context,"Signed out successfully",true
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

    } catch (e) {
      debugPrint('Error signing out: $e');
    }
  }

}
