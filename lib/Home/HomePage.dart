import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/club%20management%20properties/club%20sign%20up.dart';
import 'package:ongolf_tech/community/Community.dart';
import 'package:ongolf_tech/Distance%20and%20GPS/distance.dart';
import 'package:ongolf_tech/Eat&Drink/Eat&Drink.dart';
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/HS.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
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
    
      floatingActionButton:   /*_selectedIndex == 0
             ? FloatingActionButton(
                  onPressed: addClub,
                  backgroundColor: Colors.white,
                  shape: CircleBorder(),
                  child: const Icon(Icons.add_business, color: Colors.green),
                )
           : */_selectedIndex == 3
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

  void addClub(){
  Navigator.push(context,
  MaterialPageRoute(builder: (context) => ClubSignUp()));
  }

  void cartButton() {}
  // ignore: unused_field
  static const String mapApiKey =
      "AIzaSyA9BbeVOxIGhLJQSlCoGOJvpf2DeFm-K7M";

}