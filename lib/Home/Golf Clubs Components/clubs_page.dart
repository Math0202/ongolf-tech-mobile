// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Golf%20Clubs%20Components/clubs_leader_boards.dart';
import 'package:ongolf_tech/basic%20components/button.dart';

class ClubsPage extends StatefulWidget {
  final DataTableSource data1 = ClubLeaderBoardTable();
  final String assetPath;
  final String clubName;
  final String description;
  
  ClubsPage({
    Key? key,
    required this.assetPath,
    required this.clubName,
    required this.description,
  }) : super(key: key);


  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  
  @override
  Widget build(BuildContext context) {
    // Implement the layout for club details page/screen here
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.clubName),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.assetPath),
                  fit: BoxFit.cover,
                ),
              ),
              height: 200,
            ),
           Container(
            padding: const EdgeInsets.only(right:8),
            alignment: Alignment.centerRight,
              child:
                const Text(
                  'Course Gallery',
                  style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.w300)
                ),
              
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left:5),
              child: Text('Course Discription:\n${widget.description}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 12,),
            Text(
                  'Facillities',
                  style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.w900)
                ),
                 const Divider(
                  indent: 0,
                  thickness: 10,
                  color: Colors.green,
                ),
               Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.golf_course, color: Colors.green,),
                    buttonName: "Golf Booking",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.emoji_events, color: Colors.green,),
                    buttonName: "Events",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.restaurant, color: Colors.green,),
                    buttonName: "Food",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.sports_golf, color: Colors.green,),
                    buttonName: "Driving Range",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.menu_book, color: Colors.green,),
                    buttonName: "Coaches",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.swap_calls, color: Colors.green,),
                    buttonName: "Item Rental",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.electric_rickshaw, color: Colors.green,),
                    buttonName: "Golf Carts||Cadies",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.wine_bar, color: Colors.green,),
                    buttonName: "Bar",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.card_membership, color: Colors.green,),
                    buttonName: "Membership",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.shopping_cart, color: Colors.green,),
                    buttonName: "Pro Shop",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.contact_page, color: Colors.green,),
                    buttonName: "Contact us",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.map, color: Colors.green,),
                    buttonName: "View map",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.calendar_today, color: Colors.green,),
                    buttonName: "Schedule",
                  ), Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.airline_seat_individual_suite, color: Colors.green,),
                    buttonName: "Accomoda..",
                  ),Spacer(),
                ],
              ),
              const SizedBox(height: 12,),
            Text(
                  'Notice board.',
                  style: TextStyle(fontSize: 20, color: Colors.green.shade500, fontWeight: FontWeight.w900)
                ),

               Divider(
                  indent: 0,
                  thickness: 10,
                  color: Colors.green.shade500,
                  ),
                  Container(
                    margin: EdgeInsets.all(3),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.green.shade500,
                      borderRadius: BorderRadiusDirectional.circular(10)
                    ),
                    child: Column(
                      children: [
                        Text('All the announcments made by ${widget.clubName}, will be displayed here.', 
                        textAlign: TextAlign.center,),
                        Spacer(),
                        Text('Last updated: Never', 
                        style: TextStyle(color:  Colors.blue[200  ], fontWeight: FontWeight.bold), 
                        textAlign: TextAlign.right,),
                      ],
                    ),
                  ),
                  Container(
                    child: PaginatedDataTable(source: widget.data1,
                                    
                    columns: [
                     DataColumn(label: Text('ID')),
                     DataColumn(label: Text('PlayerName')),
                     DataColumn(label: Text('Rounds')),
                     DataColumn(label: Text('Earnings')),
                    ], 
                    header:  Column(
                      children: [
                        Center(
                          child: Text('Club leader board', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green.shade300),
                          ),
                        ),
                        Divider(
                  indent: 0,
                  thickness: 10,
                  color: Colors.green.shade300,
                  ),
                      ],
                    ),
                    columnSpacing: 30
                    ),
                  )
                  ,
          ],
        ),
      ),
    );
  }
}