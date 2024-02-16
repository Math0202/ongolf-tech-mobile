import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/On%20Boarding/OnBoarding1.dart';
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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnBoarding1(),
    );
  }
}
