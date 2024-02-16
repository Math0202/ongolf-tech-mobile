import 'package:flutter/material.dart';
import 'package:ongolf_tech/On%20Boarding/OnBoardong2.dart';

class OnBoarding1 extends StatefulWidget {
  const OnBoarding1({Key? key}) : super(key: key);

  @override
  State<OnBoarding1> createState() => _OnBoarding1State();
}

class _OnBoarding1State extends State<OnBoarding1> {
  @override
  void initState() {
    super.initState();

    // Delayed navigation to OnBoarding2 after 6 seconds
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnBoarding2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Container with Black Color
          Container(
            color: Colors.black,
          ),
          // Background Image
          Image.asset('assets/OB1.jpg'),
          // Logo at the bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 110,
              child: Image.asset('assets/Logo.png'),
            ),
          ),
        ],
      ),
    );
  }
}
