import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
import 'package:myapp/Services/database/firestore.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({required this.onTap,super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {

    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    Future addUser(User? user,String email,String password) async{
      final FirestoreService db = FirestoreService();
      Map<String, dynamic> addUserInfo = {
        "Password": password,
        "Email": email,
        "Id": user!.uid,
      };
      db.addUserDetail(addUserInfo, user.uid);

    }

    Future<void> register() async{
      final email = emailController.text;
      final password = passwordController.text;

      final _authService = AuthService();
      if(passwordController.text == confirmPasswordController.text){
          try{
            await _authService.signUpWithEmailPassword(emailController.text, passwordController.text);
            User? user = _authService.getCurrentUser();
            addUser(user, email, password);
            Navigator.push(context,MaterialPageRoute(builder: ((context) => const HomePage())));

            ScaffoldMessenger.of(context).showSnackBar((SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: const Center(
                  child: Text(
                    "Logged - In Successfully",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ))));

          }
          catch (e){
            showDialog(context: context, builder: (context)=>AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text(e.toString()),
            ));
          }

      }
      else{
        showDialog(context: context,
            builder: (context)=>AlertDialog(
              backgroundColor: Theme.of(context).colorScheme.background,
              title: Text("Passwords don't match"),
            )
        );
      }
    }


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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
                  "GET READY TO EXPERIENCE FOOD-GASM :) ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
            
                const SizedBox(
                  height: 30.0,
                ),
            
            
                //username textfield
                MyTextField(hintText: 'Email Id', obscureText: false,controller: emailController,check: false,),
            
                const SizedBox(
                  height: 15.0,
                ),
            
            
                //password
                MyTextField(hintText: 'Password', obscureText: true,controller: passwordController,check : true),
            
                //forgot password ?
                const SizedBox(
                  height: 15.0,
                ),
            
            
                //password
                MyTextField(hintText: 'Confirm Password', obscureText: true,controller: confirmPasswordController,check: true,),

            
                // login
                const SizedBox(
                  height: 40.0,
                ),
            
                MyButton(onTap: register, text: "SIGN UP !"),
            
                const SizedBox(
                  height: 50.0,
                ),
            
            
                //not a member ? register
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
                ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}