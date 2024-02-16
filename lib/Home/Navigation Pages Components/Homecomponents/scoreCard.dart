import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Navigation%20Pages%20Components/Homecomponents/localRules.dart';

class scoreCard extends StatefulWidget {
  const scoreCard({super.key});

  @override
  State<scoreCard> createState() => _scoreCardState();
}

// ignore: camel_case_types
class _scoreCardState extends State<scoreCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Score card', style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Expanded(
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 173,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: 200,
                          padding: const EdgeInsets.all(11),
                          child: const Text('A. Tangeni M. \nB. Sam P. \nC. John V. \nD Marry j.'
                          ,style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(11),
                        child: const Text('2 up\n4 down \n3 up\n0 level'
                        ,style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70
                        ),
                        textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
                 Container(
                  padding: const EdgeInsets.only(left:6),
                  margin: const EdgeInsets.all(10),
                  height: 696,
                  width: double.infinity,
                  color: Colors.grey[400],
                  child: SizedBox(
                    width: 81,
                    child: Row(
                      children: [
                      
                        Container(
                          child: const Text('Hole \n01. \n02. \n03. \n04. \n05. \n06. \n07. \n08. \n09. \n10. \n11. \n12. \n13. \n14. \n15. \n16. \n17. \n18.'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                        ),
                         Spacer(),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text('A\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                                 Spacer(),
                       Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text('B\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                                Spacer(),
                      Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text('C\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                                Spacer(),
                       Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text('D\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-\n-'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                                ),Spacer(),
                       Container(
                                  alignment: Alignment.topLeft,
                                  child: const Text('Par\n4\n3\n6\n4\n5\n6\n4\n5\n4\n3\n5\n4\n5\n5\n5\n4\n3\n4'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                                ),Spacer(),
                       Container(
                                  padding: const EdgeInsets.only(right: 13),
                                  alignment: Alignment.topLeft,
                                  child: const Text('Strok\n4\n15\n13\n9\n7\n12\n17\n14\n21\n6\n8\n10\n11\n15\n5\n9\n19\n16'
                                  ,style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green
                                  ),
                                  textAlign: TextAlign.center,
                                  ),
                                ),
                      ],
                    ),
                  ),
                  
                 ),
                     GestureDetector( onTap:localRule,
                       child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        alignment: Alignment.bottomLeft,
                        width: 96,
                        height: 21,
                        color: Colors.grey[400],
                        child: const Text('Local rules',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 16),
                        textAlign: TextAlign.center,
                        ),
                       ),
                     ),
                  
               ],
        ),
      ),
    );
  }
  void localRule(){
    Navigator.push(context, 
    MaterialPageRoute(builder: (context)=> const localRules()),
    );
  }
}