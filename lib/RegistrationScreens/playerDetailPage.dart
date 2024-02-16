
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/HomePage.dart';
import 'package:ongolf_tech/RegistrationScreens/MemberLogin.dart';
import 'package:ongolf_tech/components/my_button.dart';

import '../components/my_textfied.dart';

class PlayeDetailPage extends StatefulWidget {
  const PlayeDetailPage({super.key});

  @override
  State<PlayeDetailPage> createState() => PlayeDetailPageState();
}

class PlayeDetailPageState extends State<PlayeDetailPage> {

 //text editing controllers
   final homeClubController = TextEditingController();
   final handicapController = TextEditingController();
   final genderController = TextEditingController();
   final userNameController = TextEditingController();


          @override
       void dispose(){
        homeClubController.dispose();
        handicapController.dispose();
        genderController.dispose();
        userNameController.dispose();
        super.dispose();
       }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
          
              const SizedBox(height: 30 ),
            //logo
          
                const Center(
                  child: Icon(
                    Icons.person,
                  size: 100
                    ,),
                ),
            
              const SizedBox(height: 50 ),
              Text('Sign-up page for golf memebers only.',
              style: TextStyle(color: Colors.grey[700],
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
              const SizedBox(height: 50/2.5 ),
          
              //Player registration form

              MyTextFied(
                controller: homeClubController,
                hintText: 'Home club.',
                obscureText: false,
              ),const SizedBox(height: 25 ),
              MyTextFied(
                controller: handicapController,
                hintText: 'Handicap.',
                obscureText: false,
              ),const SizedBox(height: 25 ),
              MyTextFied(
                controller: genderController,
                hintText: 'Gender.',
                obscureText: false,
              ),const SizedBox(height: 25 ),
              MyTextFied(
                controller: userNameController,
                hintText: 'Create user name e.g @UserName.',
                obscureText: false,
              ),
            const SizedBox(height: 10 ),

            // sign in buttom
            MyButton(
              onTap: signUserIn,
              text: 'Submit form',
            ),
           const SizedBox(height: 70 ),
            
            //or continue with
             Row(
              children: [
                Expanded(
                  child: Divider(
                    thickness: 0.5,
                color: Colors.grey[400]
                )
                ),
                  ],
              ),
              GestureDetector(
              onTap: () {
                Navigator.push(context,
                 MaterialPageRoute(builder: (context) => const MemberLogin()));
              },
              child: const Text('Already have an account?\n Back to login.',
              style: TextStyle(color: Colors.blue, 
              fontWeight: FontWeight.bold,),
              textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20 ),

            ]
            ),
        )
          ),
    );
          
  }
     //sign user in
   void signUserIn(){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context)=> const HomePage()),
    );
   } 
}
