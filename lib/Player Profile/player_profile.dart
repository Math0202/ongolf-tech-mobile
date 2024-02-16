import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ongolf_tech/Player%20Profile/playedMatchesTable.dart';
import 'package:ongolf_tech/RegistrationScreens/MemberLogin.dart';

class playerProfile extends StatefulWidget {
  final DataTableSource data1 = MatchesPlayedTable();
   playerProfile({super.key});

  @override
  State<playerProfile> createState() => _playerProfileState();
}

class _playerProfileState extends State<playerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('John Don', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 95, 228, 99),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.green.shade100,
              child: Row(
                children: [
                  CircleAvatar(radius: 90,
                  backgroundImage: AssetImage('assets/RO.jpg'),
                  ),
                  Column(
                    children: [
                      Spacer(),
                      Container(
                                
                                height: 36,
                                width: 164,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.eco, color: Colors.green,),
                                      Text('Handicap: 13',
                                      style: TextStyle(
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                            margin: const EdgeInsets.only(top:8),
                            height: 36,
                            width: 164,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10)
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(Icons.settings)),
                                  Text('Edit profile',
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                  ),
                                ],
                              ),
                            ),
                          ), 
                          GestureDetector(
                            onTap: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const MemberLogin()));
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top:8),
                              height: 36,
                              width: 164,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Center(
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(4),
                                      child: Icon(Icons.logout, color: Colors.red,)),
                                    Text('Logout',
                                    style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                    ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Icon(Icons.home),
                              Text('Windhoek Golf Club',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                  ),
                            ],
                          ),
                    ],
                  ),
                         
                ],
              ),
            ),SizedBox(
              height: 30,
            ),
                              Container(
                      child: PaginatedDataTable(source: widget.data1,
                                      
                      columns: [
                       DataColumn(label: Text('Club')),
                       DataColumn(label: Text('Date')),
                       DataColumn(label: Text('Strokes')),
                       DataColumn(label: Text('Approved')),
                      ], 
                      header:  Column(
                        children: [
                          Center(
                            child: Text('Your Last 20 rounds.', 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              color: Colors.green.shade300
                              ),
                            ),
                          ),
                          Divider(
                    indent: 0,
                    thickness: 5,
                    color: Colors.black,
                    ),
                        ],
                      ),
                      columnSpacing: 30
                      ),
                    ),
          Container(
                                
                                height: 36,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Center(
                                  child: Row(
                                    children: [
                                      Icon(Icons.eco, color: Colors.green,),
                                      Text('Refresh handicap',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
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
}