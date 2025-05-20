import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/Services/database/firestore.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';
import 'email_verification.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showEmailVerificationPage = false;
  String email = "";

  Future<void> addUser(User? user, String email, String password, String name,
      String phoneNumber) async {
    final FirestoreService db = FirestoreService();
    Map<String, dynamic> addUserInfo = {
      "Password": password,
      "Email": email,
      "Name": name,
      "Phone Number": phoneNumber,
      "Id": user!.uid,
      "Adress" : "",
    };

    db.addUserDetail(addUserInfo, user.uid);
  }

  Future<void> register() async {
    final email = emailController.text;
    final password = passwordController.text;
    final name = nameController.text;
    final phoneNumber = phoneNumberController.text;

    final _authService = AuthService();
    if (passwordController.text == confirmPasswordController.text) {
      try {
        await _authService.signUpWithEmailPassword(
            emailController.text, passwordController.text);
        User? user = _authService.getCurrentUser();
        await user?.updateDisplayName(name);
        addUser(user, email, password, name, phoneNumber);

        setState(() {
          this.email = email;
          showEmailVerificationPage = true;
          user?.sendEmailVerification();
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          content: const Center(
            child: Text(
              "Registered Successfully. Please verify your email.",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        ));
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text("Passwords don't match"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                          onPressed: widget.onTap,
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
            if (showEmailVerificationPage)
              Positioned.fill(
                child: EmailVerificationPage(
                  email: email,
                  onClose: () {
                    setState(() {
                      showEmailVerificationPage = false;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
