import 'package:flutter/material.dart';

class Community extends StatefulWidget {
  const Community({Key? key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 50, // Adjust the height as needed
                  child: Container(
                    margin: const EdgeInsets.all(5),
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
              ],
            ),
          ),
          Positioned(
            top: 80,
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
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,color: Colors.grey[800] ),
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
            top: 250,
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
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      children: const [
                        PlayerWidget(
                          imagePath: 'assets/OB3.jpg',
                          entityName: 'John van Dyk',
                          numberOfMessages: 2,
                          message: 'Sup? The sky looks clear today.',
                          timeOfDay: '06:11',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/Player1.jpg',
                          entityName: 'Alice Vetji',
                          numberOfMessages: 3,
                          message: 'Hello!, How have you been.',
                          timeOfDay: '10:04',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/Player2.jpg',
                          entityName: 'Bob Marry',
                          numberOfMessages: 8,
                          message: 'How are you? Why ignoring me?',
                          timeOfDay: '10:16',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/Player3.jpeg',
                          entityName: 'Bob Peter',
                          numberOfMessages: 1,
                          message: 'I can not make it this weekend.',
                          timeOfDay: '12:46',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/tee.png',
                          entityName: 'John van Dyk',
                          numberOfMessages: 2,
                          message: 'Sup? The sky looks clear today.',
                          timeOfDay: '06:11',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/OB4.jpg',
                          entityName: 'Alice Vetji',
                          numberOfMessages: 3,
                          message: 'Hello!, How have you been.',
                          timeOfDay: '10:04',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/OB1.jpg',
                          entityName: 'Bob Marry',
                          numberOfMessages: 8,
                          message: 'How are you? Why ignoring me?',
                          timeOfDay: '10:16',
                        ),
                        PlayerWidget(
                          imagePath: 'assets/wgcc.jpg',
                          entityName: 'Bob Peter',
                          numberOfMessages: 1,
                          message: 'I can not make it this weekend.',
                          timeOfDay: '12:46',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PlayerWidget extends StatelessWidget {
  final String message;
  final String imagePath;
  final String entityName;
  final int numberOfMessages;
  final String timeOfDay;
  const PlayerWidget({
    required this.entityName,
    required this.imagePath,
    required this.numberOfMessages,
    required this.message,
    required this.timeOfDay
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
                  backgroundImage: AssetImage(imagePath),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Text(
                      entityName,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]),
                    ),
                  ),
                  Text(
                    message,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 16),
                  ),
                  
                ],
              ),
              Spacer(),
              Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(timeOfDay.toString()),
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.green.shade200,
                        child: Text(numberOfMessages.toString()),
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
      padding: const EdgeInsets.only(left: 8.0,),
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
