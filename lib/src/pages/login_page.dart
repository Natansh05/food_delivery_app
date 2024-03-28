import 'package:flutter/material.dart';
import 'package:myapp/src/common%20widgets/my_button.dart';
import 'package:myapp/src/common%20widgets/my_textfield.dart';
import 'package:myapp/src/pages/home_page.dart';

class LoginPage extends StatelessWidget {

  final void Function()? onTap;
  const LoginPage({
    required this.onTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();


    //login method
    void signUserIn(){
      /*
        Complete authentication method here

      */


      // transfer to home page if login done
      Navigator.push(context,MaterialPageRoute(builder: ((context) => const HomePage())));
    }


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
            MyTextField(hintText: 'Username', obscureText: false,controller: _emailController,),

            const SizedBox(
              height: 20.0,
            ),


            //password
            MyTextField(hintText: 'Password', obscureText: true,controller: _passwordController,),

            //forgot password ?
            const SizedBox(height: 10,),
                //forgot password option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot password ??',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),),
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
                onPressed: onTap,
                child: const Text(
                  "Register Now !!",
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