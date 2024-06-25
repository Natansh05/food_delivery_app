import 'package:flutter/material.dart';
import 'package:myapp/Services/auth/auth_service.dart';
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
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();


    //login method
    //login method
    Future<void> signUserIn() async {
      final _authService = AuthService();
      try{
        await _authService.signInWithEmailPassword(emailController.text, passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Center(
              child: Text(
                "Logged - In Successfully",
                style: TextStyle(fontSize: 20.0),
              ),
            ))));


        // transfer to home page if login done
        Navigator.push(context,MaterialPageRoute(builder: ((context) => const HomePage())));
      }
      catch (e){
        showDialog(context: context, builder: (context)=> AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(e.toString()),
        ));
      }




    }



    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
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
                MyTextField(hintText: 'Username', obscureText: false,controller: emailController,check: false,),
          
                const SizedBox(
                  height: 20.0,
                ),
          
          
                //password
                MyTextField(hintText: 'Password', obscureText: true,controller: passwordController,check: true,),
          
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
        ),
      ),
    );
  }
}