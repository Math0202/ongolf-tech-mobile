import 'package:flutter/material.dart';
import 'package:ongolf_tech/Home/Golf%20Clubs%20Components/clubs_page.dart';

class ClubsTile extends StatelessWidget {
  final String assetPath;
  final String clubName;
  final String description;

  const ClubsTile({
    Key? key, 
    required this.assetPath,
    required this.clubName,
   required this.description,
    
    }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      Navigator.push(context,
      MaterialPageRoute(
        builder: (context) => ClubsPage(
          clubName: clubName,
          assetPath: assetPath,
          description: description
          ))
      );
    },
    child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(4),
          height: 175,
          width: 225,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(assetPath),
              fit: BoxFit.cover,
            ),
          ),
          child: 
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              alignment: Alignment.bottomLeft,
              child: Text('$clubName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              ),
             
              ),
          ),
          
        ),
           Container(
            decoration: BoxDecoration(
              color: Colors.grey[800]!.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            
            child: const Icon(Icons.golf_course, color: Color.fromARGB(255, 45, 216, 51),))
      ],
    ));
  }
}