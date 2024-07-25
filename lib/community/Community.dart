import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ongolf_tech/Home/Golf%20Clubs%20Components/clubs_page.dart';
import 'package:ongolf_tech/community/chattingServices/chat.dart';
import 'package:ongolf_tech/community/clubs.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade900),
                      ),
                      child: const Center(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Search...',
                            prefixIcon: Icon(Icons.person_search),
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50,
              left: 0,
              right: 0,
              child: Container(
                height: 197,
                decoration: BoxDecoration(
                  color: Colors.green.shade200,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Spacer(),
                    Center(
                      child: Text(
                        'Golf clubs and other communities.',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 160,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('clubs').snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text("Error");
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Text('Loading...');
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final clubDoc = snapshot.data!.docs[index];
                              final clubData = clubDoc.data() as Map<String, dynamic>;
                              final club = Clubs(
                                id: clubDoc.id,
                                name: clubData['Club Name'],
                                imagePath: clubData['Profile Picture'],
                              );
                              return ClubWidget(club: club);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 220,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.green.shade400,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        'Chats',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                    ),
                    Expanded(
                      child: _buildUserList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        }
        return ListView(
          children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc)).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Get the current user
    User? currentUser = _auth.currentUser;

    // Display all users except the current user
    if (currentUser != null && currentUser.email != data['email']) {
      return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(data['uid']).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListTile(
              title: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 29,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage: NetworkImage(userData['Profile Picture']),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(data['Full Name']),
                    ],
                  ),
                  Divider(
                    indent: 40,
                  ),
                ],
              ),
              onTap: () {
                // Pass the clicked user's UID to the chat
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receivedUserFullName: data['Full Name'],
                      receivedUserID: data['uid'],
                      isGroupChat: false,
                    ),
                  ),
                );
              },
            );
          } else {
            return ListTile(
              title: Row(
                children: [
                  CircleAvatar(radius: 32, backgroundColor: Colors.grey),
                  const SizedBox(width: 8),
                  Text(data['Full Name']),
                ],
              ),
              onTap: () {
                // Pass the clicked user's UID to the chat
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receivedUserFullName: data['Full Name'],
                      receivedUserID: data['uid'],
                      isGroupChat: false,
                    ),
                  ),
                );
              },
            );
          }
        },
      );
    } else {
      return Container();
    }
  }
}

class PlayerWidget extends StatelessWidget {
  final String receiverImagePath;
  final String receiverFullName;

  const PlayerWidget({
    required this.receiverImagePath,
    required this.receiverFullName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(receiverImagePath),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      receiverFullName,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                    ),
                  ),
                  Text(
                    '',
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(''),
                  ),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.green.shade200,
                    child: Text(''),
                  ),
                ],
              ),
            ],
          ),
          Divider(
            indent: 70,
          )
        ],
      ),
    );
  }
}

class ClubWidget extends StatelessWidget {
  final Clubs club;

  const ClubWidget({
    required this.club,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context) => ChatPage(
                      receivedUserID: club.id, 
                      receivedUserFullName: club.name,
                      isGroupChat: true,
                      )));
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(club.imagePath),
                  ),
                ),
              ),
            ],
          ),
          Text(
            club.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
