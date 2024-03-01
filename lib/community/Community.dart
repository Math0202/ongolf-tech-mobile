import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/community/chatPage.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Center(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search...',
                          prefixIcon: Icon(Icons.person_search),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 1),
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
                  )),
              child: Column(
                children: [
                  Spacer(),
                  Center(
                    child: Text(
                      'Golf clubs and other entities.',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        UserWidget(
                          imagePath: 'assets/wgcc.jpg',
                          entityName: 'Windhoek',
                          numberOfMessages: 2,
                        ),
                        UserWidget(
                          imagePath: 'assets/tsumeb.jpg',
                          entityName: 'Tsumeb',
                          numberOfMessages: 12,
                        ),
                        UserWidget(
                          imagePath: 'assets/nagu.png',
                          entityName: 'NAGU',
                          numberOfMessages: 32,
                        ),
                        UserWidget(
                          imagePath: 'assets/omeya.jpg',
                          entityName: 'Omeya',
                          numberOfMessages: 42,
                        ),
                        UserWidget(
                          imagePath: 'assets/oshakati.jpg',
                          entityName: 'Oshakati',
                          numberOfMessages: 120,
                        )
                      ],
                    ),
                  )
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
              decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      'Chats',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800]),
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
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot document = snapshot.data!.docs[index];
            return _buildUserListItem(document);
          },
        );
      },
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    // Display all users except the current user
    if (_auth.currentUser!.email != data['email']) {
      return ListTile(
        title: Text(data['Full Name']),
        onTap: () {
          // Pass the clicked user's UID to the chat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => chatPage(
                receivedUserFullName: data['Full Name'],
                receivedUserID: data['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}

class UserWidget extends StatelessWidget {
  final String imagePath;
  final String entityName;
  final int numberOfMessages;

  const UserWidget({
    required this.entityName,
    required this.imagePath,
    required this.numberOfMessages,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 48,
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
              Positioned(
                right: 0,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Color.fromARGB(255, 55, 153, 58),
                  child: Text(numberOfMessages.toString()),
                ),
              ),
            ],
          ),
          Text(
            entityName,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
          )
        ],
      ),
    );
  }
}
