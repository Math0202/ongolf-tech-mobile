import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/HomePage.dart';
import 'package:ongolf_tech/RegistrationScreens/signUpPage.dart';
import 'package:ongolf_tech/basic%20components/my_button.dart';
import 'package:ongolf_tech/basic%20components/my_textfied.dart';

class MemberLogin extends StatefulWidget {
  const MemberLogin({super.key});

  @override
  State<MemberLogin> createState() => _MemberLoginState();
}

class _MemberLoginState extends State<MemberLogin> {
  @override
  Widget build(BuildContext context) {
       final emailController = TextEditingController();
       final passwordController = TextEditingController();
        Future<void> signUserIn() async {
          showDialog(
        context: context, 
        builder: (context){
       return Center(
        child:  CircularProgressIndicator(),
       );   
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
        Navigator.of(context).pop();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const HomePage()));
    } catch (e) {
      // Handle the exception
      Navigator.of(context).pop();
      showDialog(
        context: context, 
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('Sign-in error'),
            content: Text(e.toString()),
          );
        });
    }
  }


       @override
       void dispose(){
        passwordController.dispose();
        emailController.dispose();
        super.dispose();
       }


    return Scaffold(

      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              const SizedBox(height: 50 ),
            //logo
          
                const Center(
                  child: Icon(
                    Icons.lock,
                  size: 50
                    ,),
                ),
              const SizedBox(height: 50 ),
          
            //welcome back, you've been missed!
            Text('Welcome Back we have missed you!',
              style: TextStyle(color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
              const SizedBox(height: 50/2.5 ),
          
              //username text feild
              MyTextFied(
                 controller: emailController,
                hintText: 'Enter Email......',
                obscureText: false,
              ),
              const SizedBox(height: 10 ),
          
            //passord text field
              MyTextFied(
                controller: passwordController,
                hintText: 'Enter password......',
                obscureText: true,
              ),
              const SizedBox(height: 5.9 ),
          
            //forget password
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Forgot password?',
                  style: TextStyle(color: Colors.blue, fontSize: 16,),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10 ),
          
          
            // sign in buttom
           MyButton(
            
              onTap: signUserIn,
              text: 'Sign In',
            ),
           const SizedBox(height: 40 ),
          
            //or continue wit
                      const SizedBox(height: 70 ),
          
            //not a member? register now
            const Text('Not a memeber yet?'),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const signUpPage()));
              },
              child: const Text('Register now.',
              style: TextStyle(color: Colors.blue, 
              fontWeight: FontWeight.bold,),
              ),
            ),
                ]
          ,),
        ),
      )

    );
  }
    //text editing controllers

  

}