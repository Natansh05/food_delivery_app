// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';
import 'package:myapp/src/common%20widgets/progress_indicator.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
import 'package:myapp/src/pages/home_page.dart';
import 'package:myapp/src/pages/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> signUserIn() async {
      if (emailController.text.isEmpty ||
          passwordController.text.isEmpty) {
        final snackbar = successSnackBar(
            context, "Please fill in all fields.", false);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }
      showLoadingDialog(context);
      final authService = AuthService();

      final (user, error) = await authService.signInWithEmailPassword(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      hideLoadingDialog(context);

      if (user == null) {
        final snackbar =
            successSnackBar(context, error ?? "Login failed", false);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      if (user.emailConfirmedAt == null) {
        final snackbar =
            successSnackBar(context, "Please verify your email.", false);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      final snackbar = successSnackBar(
        context,
        "Welcome back ${user.userMetadata?['name'] ?? ''}",
        true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50.0,
                ),

                //logo
                const Icon(
                  Icons.lock_open_rounded,
                  size: 80.0,
                ),

                const SizedBox(
                  height: 20.0,
                ),

                //tagline
                Text(
                  "GLAD TO SEE YOU BACK !!! ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),

                const SizedBox(
                  height: 50.0,
                ),

                //username textfield
                MyTextField(
                  hintText: 'Username',
                  obscureText: false,
                  controller: emailController,
                  check: false,
                ),

                const SizedBox(
                  height: 20.0,
                ),

                //password
                MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  controller: passwordController,
                  check: true,
                ),

                //forgot password ?
                const SizedBox(
                  height: 10,
                ),
                //forgot password option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password ??',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                // login
                const SizedBox(
                  height: 40.0,
                ),

                MyButton(onTap: signUserIn, text: "SIGN IN !"),

                const SizedBox(
                  height: 50.0,
                ),

                //not a member ? register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member ?",
                      style: TextStyle(
                        color: Colors.grey[700],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const RegisterPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Register Now !!",
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
