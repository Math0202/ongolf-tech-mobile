import 'package:flutter/material.dart';
import 'package:ongolf_tech/On%20Boarding/TandCs.dart';

class OnBoarding4 extends StatefulWidget {
  const OnBoarding4({Key? key}) : super(key: key);

  @override
  State<OnBoarding4> createState() => _OnBoarding4State();
}

class _OnBoarding4State extends State<OnBoarding4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/OB4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 30),
              
              // Header Text
              Container(
                child: const Text(
                  'Par Excellence Awaits.',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 60 * 7),

              // Description Text
              Container(
                padding: const EdgeInsets.all(18.0),
                child: const Text(
                  'From personalized tips to real-time scoring, our app is designed to enhance your game and make every golfing moment unforgettable.',
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
                  buildIndicatorDot(false),
                  buildIndicatorDot(true),
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
                onPressed: () => navigateToTandCs(context),
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

  // Method to navigate to terms and conditions screen
  void navigateToTandCs(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const TandCs(),
      ),
    );
  }
}
