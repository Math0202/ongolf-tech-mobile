import 'package:flutter/material.dart';
import 'package:ongolf_tech/On%20Boarding/OnBoarding4.dart';

class OnBoarding3 extends StatefulWidget {
  const OnBoarding3({Key? key}) : super(key: key);

  @override
  State<OnBoarding3> createState() => _OnBoarding3State();
}

class _OnBoarding3State extends State<OnBoarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/OB3.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              
              // Header Text
              Container(
                child: const Text(
                  'Golfing Made Easy',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 60 * 6),

              // Description Text
              Container(
                padding: const EdgeInsets.all(18.0),
                child: const Text(
                  'This app is your ultimate all in one companion, unlock tracking of your games, scores, handicap, connecting to fellow golf enthusiasts and so much more!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Spacer(),

              // Indicator Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildIndicatorDot(false),
                  buildIndicatorDot(true),
                  buildIndicatorDot(false),
                ],
              ),

              const SizedBox(height: 20),

              // Next Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => navigateToOnBoarding4(context),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 28.0),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build an indicator dot with specified color
  Widget buildIndicatorDot(bool isActive) {
    return Container(
      width: 10,
      height: 10,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.green : Colors.grey[100],
      ),
    );
  }

  // Method to navigate to OnBoarding4 screen
  void navigateToOnBoarding4(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OnBoarding4(),
      ),
    );
  }
}
