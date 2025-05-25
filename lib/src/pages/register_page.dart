// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';
import 'package:myapp/src/common%20widgets/progress_indicator.dart';
import 'package:myapp/src/common%20widgets/success_snackbar.dart';
import 'package:myapp/src/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String email = "";

  Future<void> addUser(
      User? user, String email, String name, String phoneNumber) async {
    debugPrint("User ID: ${user!.id}");

    await Supabase.instance.client.from('profiles').insert({
      'id': user.id,
      'name': name,
      'phone': phoneNumber,
      'email': email,
    });
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final name = nameController.text.trim();
    final phoneNumber = phoneNumberController.text.trim();

    if (password != confirmPasswordController.text.trim()) {
      final snackbar = successSnackBar(
          context, "Passwords do not match. Please try again.", false);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    if (email.isEmpty ||
        password.isEmpty ||
        name.isEmpty ||
        phoneNumber.isEmpty) {
      final snackbar =
          successSnackBar(context, "Please fill in all fields.", false);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }
    if (password.length < 6) {
      final snackbar = successSnackBar(
          context, "Password must be at least 6 characters long.", false);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      return;
    }

    // Show loading indicator
    showLoadingDialog(context);

    final authService = AuthService();

    try {
      // Sign up the user
      final response =
          await authService.signUpwithEmailPassword(email, password);
      
      if (response?.user == null) {
        hideLoadingDialog(context);
        final snackbar = successSnackBar(
            context, "Registration failed. Please try again.", false);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        return;
      }

      // Show success and ask user to verify email
      setState(() {
        this.email = email;
      });
      await addUser(
        response!.user,
        email,
        name,
        phoneNumber,
      );
      hideLoadingDialog(context);
      final snackbar = successSnackBar(
        context,
        "Welcome $name! Please verify your email and login.",
        true,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    } catch (e) {
      hideLoadingDialog(context);
      final snackbar = successSnackBar(
          context, "An error occurred. Please try again.", false);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      debugPrint('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50.0),
                    const Icon(Icons.lock_open_rounded, size: 80.0),
                    const SizedBox(height: 20.0),
                    Text(
                      "GET READY TO EXPERIENCE FOOD-GASM :)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    MyTextField(
                      hintText: 'Name',
                      obscureText: false,
                      controller: nameController,
                      check: false,
                    ),
                    const SizedBox(height: 15.0),
                    MyTextField(
                      hintText: 'Phone Number',
                      obscureText: false,
                      controller: phoneNumberController,
                      check: false,
                    ),
                    const SizedBox(height: 15.0),
                    MyTextField(
                      hintText: 'Email Id',
                      obscureText: false,
                      controller: emailController,
                      check: false,
                    ),
                    const SizedBox(height: 15.0),
                    MyTextField(
                      hintText: 'Password',
                      obscureText: true,
                      controller: passwordController,
                      check: true,
                    ),
                    const SizedBox(height: 15.0),
                    MyTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: confirmPasswordController,
                      check: true,
                    ),
                    const SizedBox(height: 40.0),
                    MyButton(onTap: register, text: "SIGN UP !"),
                    const SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a member ?",
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          },
                          child: const Text(
                            "Login Now !!",
                            style: TextStyle(
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
