import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Navigation%20Pages%20Components/Homecomponents/playerScoreTile.dart';
import 'Homecomponents/scoreCard.dart';

class Scores extends StatefulWidget {
  const Scores({Key? key});

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap the whole column with GestureDetector
      onTap: () {}, // Add an empty onTap function
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 165,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green
              ),
              child: Column(
                children: [
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.golf_course, size: 42,),
                        Container(
                          margin: const EdgeInsets.all(6),
                          height: 46,
                          width: 144,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Center(
                            child: Text('Hole: 1',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                            ),
                            ),
                          ),
                        ),
                         const Icon(Icons.golf_course, size: 42,),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(6),
                          height: 46,
                          width: 107,
                          decoration: BoxDecoration(
                            color: Colors.grey[500],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          
                          child: const Center(
                            child: Text('Par 5',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: const EdgeInsets.all(6),
                          height: 46,
                          width: 107,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text('161m',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                            ),
                          ),
                        ),
                         Spacer(),
                        Container(
                          margin: const EdgeInsets.all(6),
                          height: 46,
                          width: 107,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: Text('178m',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                            ),
                          ),
                        ),
                    ],
                  ),
                   Text('--ONGOLF Tech Championship 2024 (Stable ford) Windhoek--',
                   style: 
                   TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold
                   )
                   ,
                   )
                ],
              )
            ),
            
           PlayerScoreTile(
            imagePath:'assets/Player1.jpg',
            playerName: 'Tangeni M.',
            handicap:13
           ),
           PlayerScoreTile(
            imagePath:'assets/Player2.jpg',
            playerName: 'Sam p.',
            handicap:24
           ),
           PlayerScoreTile(
            imagePath:'assets/OB2.jpg',
            playerName: 'Jhon V.',
            handicap:13
           ),
           PlayerScoreTile(
            imagePath:'assets/OB3.jpg',
            playerName: 'Marry',
            handicap:5
           ),
           Row(
             children: [
               GestureDetector(
                     onTap: viewScores,
                     child: Container(
                      width: 150,
                       padding: const EdgeInsets.all(24),
                       margin: const EdgeInsets.all(12),
                       decoration: BoxDecoration(color: Colors.green,
                       borderRadius: BorderRadius.circular(8.9)
                       ),
                       child: const Center(
                child: Text('View',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                )
                 ),
                     ),
                   ),
                  Spacer(),
                   GestureDetector(
                     onTap: (){
                      
                     },
                     child: Container(
                      width: 200,
                       padding: const EdgeInsets.all(24),
   
                       decoration: BoxDecoration(color: Colors.red,
                       borderRadius: BorderRadius.circular(8.9)
                       ),
                       child: const Center(
                child: Text('Submit',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
                )
                 ),
                     ),
                   ),
             ],
           ),
          ],
        ),
      ),
    );
  }

  void viewScores(){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context)=> const scoreCard()),
    );
  } 
}
