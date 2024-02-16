// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/HomePage.dart';
import 'package:ongolf_tech/RegistrationScreens/MemberLogin.dart';
import 'package:ongolf_tech/components/my_button.dart';
import '../components/my_textfied.dart';

class signUpPage extends StatefulWidget {
  const signUpPage({super.key});

  @override
  State<signUpPage> createState() => signUpPageState();
}

class signUpPageState extends State<signUpPage> {
  PlatformFile? pickedFile;
  UploadTask? uploadTask;

 //text editing controllers
  final emailController     = TextEditingController();
  final passwordController1 = TextEditingController();
  final passwordController2 = TextEditingController();
  final homeClubController  = TextEditingController();
  final handicapController  = TextEditingController();
  final genderController    = TextEditingController();
  final userNameController  = TextEditingController();
  final fullNameController  = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController1.dispose();
    passwordController2.dispose();
    homeClubController.dispose();
    handicapController.dispose();
    genderController.dispose();
    userNameController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
  

Future<void> signUp() async {
  try {
    if (passwordController1.text.trim() == passwordController2.text.trim()) {
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController1.text.trim(),
      );

      final userId = userCredential.user!.uid;

      await userDetails(
        userId,
        fullNameController.text.trim(),
        homeClubController.text.trim(),
        int.parse(handicapController.text.trim()),
        genderController.text.trim(),
        userNameController.text.trim(),
      );

      await uploadFile(userId);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MemberLogin()),
      );

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Successful'),
            content: Text("Check your email inbox to verify your email."),
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Sign up error'),
            content: Text("Passwords don't match, try again."),
          );
        },
      );
    }
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
        );
      },
    );
  }
}

Future<void> userDetails(String userId, String fullName, String clubName, int handicap, String gender, String userName) async {
  try {
    await FirebaseFirestore.instance.collection("users").doc(userId).set({
      'Full Name': fullName,
      'Home club': clubName,
      'Handicap': handicap,
      'Gender': gender,
      'User Name': userName,
    });
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(e.toString()),
        );
      },
    );
  }
}

Future<void> uploadFile(String userId) async {
  if (pickedFile == null) return;
  final path = 'users/$userId/profilepic/${pickedFile!.name}';
  final file = File(pickedFile!.path!);
  final ref = FirebaseStorage.instance.ref().child(path);

  try {
    await ref.putFile(file);
    final downloadUrl = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection("users").doc(userId).update({
      'Profile Picture': downloadUrl,
    });
  } catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error uploading file'),
          content: Text(e.toString()),
        );
      },
    );
  }
}


   Future selectFile() async {
    final results = await FilePicker.platform.pickFiles();
    if (results == null) return;
    setState((){
    pickedFile = results.files.first;
  });
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
                controller: fullNameController,
                hintText: 'Full name.',
                obscureText: false,
              ),const SizedBox(height: 25),
               MyTextFied(
                controller: homeClubController,
                hintText: 'Home club.',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextFied(
                controller: handicapController,
                hintText: 'Handicap.',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextFied(
                controller: genderController,
                hintText: 'Gender.',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              MyTextFied(
                controller: userNameController,
                hintText: 'Create user name e.g @UserName.',
                obscureText: false,
              ),const SizedBox(height: 25),
              MyTextFied(
                 controller: emailController,
                hintText: 'Email.',
                obscureText: false,
              ),
              const SizedBox(height: 25 ),
              MyTextFied(
                controller: passwordController1,
                hintText: 'Create password.',
                obscureText: true,
              ),const SizedBox(height: 25 ),
              MyTextFied(
                 controller: passwordController2,
                hintText: 'Confirm password.',
                obscureText: true,
              ),
              const SizedBox(height: 10 ),

            //image button
            ElevatedButton(onPressed: selectFile, 
            child: Text('Select profile image')),
            SizedBox(height:10),
            if(pickedFile != null)



            // sign in buttom
            MyButton(
              onTap: signUp,
              text: 'Sign up!   ',
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
