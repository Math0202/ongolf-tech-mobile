import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Golf%20Clubs%20Components/clubs_page.dart';
import 'package:ongolf_tech/Player%20components/player_profile.dart';
import 'package:table_calendar/table_calendar.dart';
import '../Golf Clubs Components/ClubsTile.dart';
import 'Homecomponents/Weather.dart';

class MyCalendar extends StatefulWidget {
  final DateTime selectedDay;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final void Function(DateTime) onDaySelected;
  final void Function(CalendarFormat) onFormatChanged;

  const MyCalendar({
    Key? key,
    required this.selectedDay,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
  }) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: widget.focusedDay,
          firstDay: DateTime.utc(2022, 3, 14),
          lastDay: DateTime(2030, 11, 11),
          startingDayOfWeek: StartingDayOfWeek.monday,
          selectedDayPredicate: (day) {
            return isSameDay(widget.selectedDay, day);
          },
        ),
        const SizedBox(height: 8.0),
        // Removed the event list
      ],
    );
  }
}
// fetching club details


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController _scrollController = ScrollController();
  DateTime _selectedDay = DateTime.now();
  final DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50, // Adjust the height as needed
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
                    border: Border.all(color: Colors.grey), // Adjust the color as needed
                  ),
                  child: const Center(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search...',
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 1), // Adjust padding as needed
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _buildProfileContainer(),
                    const Spacer(),
                    Container(
                      child: const Weather(),
                    ),
                  ],
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: getLoggedInUserDetails,
                  child: Text(
                    '\nGood golfing weather \n conditions 🌥️',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      backgroundColor: Colors.grey[600]!.withOpacity(0.50),
                    ),
                  ),
                ),
              ),

           Container(
                height: _containerHeight,
              ),

              GestureDetector(
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 180,
                  child: SizedBox(
                    height: 200,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }
                
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                
                        return ListView.builder(
                          padding: const EdgeInsets.all(16),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            var club = snapshot.data!.docs[index];
                            
                          return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClubsPage(
                        assetPath: club['Profile Picture'],
                        clubName: club['Club Name'],
                        description: club['Club Discription'],
                      ),
                    ),
                  );
                },
                child: ClubsTile(
                  assetPath: club['Profile Picture'],
                  clubName: club['Club Name'],
                  description: club['Club Discription'],)
                );
                          },
                        );
                      },
                    ),
                  ),
                ),
                
                 ),
              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: MyCalendar(
                      selectedDay: _selectedDay,
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      onDaySelected: (selectedDay) {
                        _handleDaySelected(selectedDay);
                      },
                      onFormatChanged: (format) {
                        _handleFormatChanged(format);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final double _containerHeight = 380;

  void _handleDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
    });
  }

  void _handleFormatChanged(CalendarFormat format) {
    setState(() {
      _calendarFormat = format;
    });
  }

  Widget _buildProfileContainer() {
    return FutureBuilder<DocumentSnapshot>(
      future: getLoggedInUserDetails(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            String imageUrl = data['Profile Picture'] ?? 'assets/RO.jpg'; // Use 'Profile Picture' field from Firestore
            print('Image URL: $imageUrl'); // Debugging
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => playerProfile(
                    userName: data['User Name'], 
                    handicap: data['Handicap'],
                    profileImageUrl:imageUrl, 
                    homeClub: data['Home club'],
                    playerFullName: data['Full Name'] 
                    )
                    ),
                );
              },
              child: Stack(
                children: [
                  Container(
                    height: 119,
                    width: 262,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.0),
                      color: Colors.grey[500]!.withOpacity(0.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 3),
                          height: 103,
                          width: 103,
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black,
                            image: DecorationImage(
                              image: NetworkImage(imageUrl), // Use NetworkImage for Firebase Storage URLs
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            ' \n Cap: ${data['Handicap'].toString()} \n ${data['User Name']} \n \n ${data['Home club']}',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(7),
                          alignment: Alignment.topRight,
                          child: const Icon(Icons.verified, color: Colors.blue, size: 26),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('No user currently logged in 1');
          }
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<DocumentSnapshot> getLoggedInUserDetails() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userId = user.uid;
      return await FirebaseFirestore.instance.collection('users').doc(userId).get();
    } else {
      throw Exception('No user currently logged in 2');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
