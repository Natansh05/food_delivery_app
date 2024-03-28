import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  const RegisterPage({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();



    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
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
            MyTextField(hintText: 'Username', obscureText: false,controller: _emailController,),

            const SizedBox(
              height: 15.0,
            ),


            //password
            MyTextField(hintText: 'Password', obscureText: true,controller: _passwordController,),

            //forgot password ?
            const SizedBox(
              height: 15.0,
            ),


            //password
            MyTextField(hintText: 'Confirm Password', obscureText: true,controller: _confirmPasswordController,),


            // login
            const SizedBox(
              height: 40.0,
            ),

            MyButton(onTap: (){}, text: "SIGN UP !"),

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
                onPressed: onTap,
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
    );
  }
}