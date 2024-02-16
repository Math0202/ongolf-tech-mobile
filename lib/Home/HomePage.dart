import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Navigation%20Pages%20Components/Community.dart';
import 'package:ongolf_tech/Home/Distance%20and%20GPS/distance.dart';
import 'package:ongolf_tech/Home/Navigation%20Pages%20Components/Eat&Drink.dart';
import 'package:ongolf_tech/Home/Navigation%20Pages%20Components/Home.dart';
import 'package:ongolf_tech/Home/Navigation%20Pages%20Components/Scores.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  final user = FirebaseAuth.instance.currentUser!;

  final List<Widget> _pages = [
    const Home(),
    const Scores(),
    const Distance(),
    const EatAndDrink(),
    const Community(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/HS.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => _navigateBottomBar(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_stories), label: 'Scores'),
          BottomNavigationBarItem(icon: Icon(Icons.gps_not_fixed), label: 'Distance'),
          BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: 'Eat|Drink'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Community'),
        ],
      ),
    
      floatingActionButton:  _selectedIndex == 3
              ? FloatingActionButton(
                  onPressed: cartButton,
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  child: const Icon(Icons.shopping_cart, color: Colors.green),
                )
              : null,
    );
  }

  void notificationButton() {
    // Functionality for notification button
  }
  void cartButton() {}
  // ignore: unused_field
  static const String mapApiKey =
      "AIzaSyA9BbeVOxIGhLJQSlCoGOJvpf2DeFm-K7M";

}
