// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:url_launcher/url_launcher.dart';
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
            const SizedBox(height: 30,),
            Text(
                  'Offered facilities',
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
                  OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Colors.green, // Change the color here
          width: 1.5, // Change the thickness here
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Change the roundness here
        ),
      ),
      onPressed: () {
        showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          shadowColor: Colors.green.shade500,
          title: Text('Bookings prices list.'),
          backgroundColor: Colors.green.shade300,
          content: Container(
            height: 180,
            child: Column(
              children: [
              Text('Member 18 holes \n Adult NAD[Price] Jnr NAD[Price].'),
              Text('Member 9 holes  \n Adult NAD[Price] Jnr NAD[Price].'),
              Text('Non-Member 18  \n Adult NAD[Price] Jnr NAD[Price].'),
              Text('Non-Member 9  \n Adult NAD[Price] Jnr NAD[Price].'),
            ],),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.mail),
                Spacer(),
                Icon(Icons.phone),
              ],
            )
          ],
        );
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Icon(Icons.golf_course, color: Colors.green,),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Golf Booking",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
            
          ],
        ),
      ),
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
                  Spacer(),OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Colors.green, // Change the color here
          width: 1.5, // Change the thickness here
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Change the roundness here
        ),
      ),
      onPressed: () {
        showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          shadowColor: Colors.green.shade500,
          title: Text('Hiring services fees'),
          backgroundColor: Colors.green.shade300,
          content: Container(
            height: 100,
            child: Column(
              children: [
              Text('9 Holes \n 4 sitter NAD[] 2 sitter NAD[].'),
              Text('18 Holes \n 4 sitter NAD[] 2 sitter NAD[].'),
            ],),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.mail),
                Spacer(),
                Icon(Icons.phone),
              ],
            )
          ],
          
        );
        }
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Icon(Icons.electric_rickshaw, color: Colors.green,),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Golf Carts||Cadies",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
                   Spacer(),
                  OutLinedButton1(
                    icons: Icon(Icons.wine_bar, color: Colors.green,),
                    buttonName: "Bar",
                  ),Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: Colors.green, // Change the color here
          width: 1.5, // Change the thickness here
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Change the roundness here
        ),
      ),
      onPressed: () {
        showDialog(context: context, builder: (BuildContext context){
        return AlertDialog(
          shadowColor: Colors.green.shade500,
          title: Text('Membership fees list.'),
          backgroundColor: Colors.green.shade300,
          content: Container(
            height: 100,
            child: Column(
              children: [
              Text('6 Month Membership \n Adult NAD[]/Jnr NAD[]/Ladies NAD[].'),
              Text('12 Month Membership  \n Adult NAD[]/Jnr NAD[]/Ladies NAD[].'),
            ],),
          ),
          actions: [
            Row(
              children: [
                Icon(Icons.mail),
                Spacer(),
                Icon(Icons.phone),
              ],
            )
          ],
          
        );
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          children: [
            Icon(Icons.card_membership, color: Colors.green,),
            Container(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Membership",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
                   Spacer(),
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
              const SizedBox(height: 42,),
            Text(
                  'Club notice board.',
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
                  ),SizedBox(height: 40,),
                  Container(
                
                    child: PaginatedDataTable(source: widget.data1,
                    
                    columns: [
                     DataColumn(label: Text('Player ID')),
                     DataColumn(label: Text('PlayerName')),
                     DataColumn(label: Text('Rounds')),
                     DataColumn(label: Text('Earnings')),
                    ], 
                    header:  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Text('Stableford Order of Merit', style: TextStyle(fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 112, 153, 114)),
                          ),
                        ),
                        Divider(
                  indent: 0,
                  thickness: 5,
                  color: Colors.green.shade300,
                  ),
                      ],
                    ),
                    columnSpacing: 30
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    height: 300,
                    color: Colors.green.shade900,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text('Contact', 
                                style: TextStyle( fontWeight:  FontWeight.bold, fontSize: 16,color: Colors.white),),
                                Text('[Name & title]'),
                                Text('[Name & title]'),
                        
                              ],
                            ),
                            Column(
                              children: [
                                Text('details', 
                                style: TextStyle( fontWeight:  FontWeight.bold, fontSize: 16,color: Colors.white),),
                                Text('+264 61 [ClubNumber]'),
                                Text('[ClubEmail address]'),
                              ],
                            )
                          ],
                        ),
                         Spacer(),
                         Column(
                           children: [
                             Text('[Town/city], Namibia.',
                                    style: TextStyle( fontWeight:  FontWeight.bold, fontSize: 16,color: Colors.grey[300]),),
                          InkWell(
                            onTap: (){
                              launch('https://www.google.com/maps/search/golf+courses+in+namibia/@-22.8521041,11.3368438,6z/data=!3m1!4b1?entry=ttu');
                            },
                           child:  Text('[https://www.google.com/maps/search/golf+courses+in+namibia/@-22.8521041,11.3368438,6z/data=!3m1!4b1?entry=ttu]',
                            style: TextStyle( color: Colors.blue, decoration: TextDecoration.underline),textAlign: TextAlign.center,),
                          )],
                         ),
                                
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(height: 50, child: Image.asset('assets/email.jpg',fit: BoxFit.contain)),
                            Container(height: 50, child: Image.asset('assets/Facebook.jpg',fit: BoxFit.contain)),
                            Container(height: 50,  child: Image.asset('assets/Instagram.jpg',fit: BoxFit.contain)),
                            Container(height: 50,  child: Image.asset('assets/LinkedIn.jpg',fit: BoxFit.contain)),
                            Container(height: 50, child: Image.asset('assets/WhatsApp.jpg',fit: BoxFit.contain)),
                            Container(height: 50, child: Image.asset('assets/website.jpg',fit: BoxFit.contain)),
                          ],
                        ),
                        SizedBox(height: 30,)
                      ],
                    ),
                  )
          ],
        ),
      ),
    );
  }
}