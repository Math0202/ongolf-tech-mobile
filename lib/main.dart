import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/HomePage.dart';
import 'package:ongolf_tech/On%20Boarding/OnBoarding1.dart';
import 'package:ongolf_tech/auth.dart';
import 'package:ongolf_tech/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: AuthMethod().getCurrentUser(), // Replace with your actual future
        builder: (context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              return HomePage();
            } else {
              return OnBoarding1();
            }
          }
        },
      ),
    );
  }
}
