import 'package:flutter/material.dart';

class foodTile extends StatelessWidget {
  final String assetPath;
  final String clubName;
  final String description;

  const foodTile({super.key, 
    required this.assetPath,
    required this.clubName,
    required this.description,
    
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(0.01),
              height: 120,
              width: 225,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(assetPath),
                  fit: BoxFit.cover,
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
                child: const Icon(Icons.food_bank, color: Color.fromARGB(255, 45, 216, 51),))
          ],
        ),
           Expanded(
             child: Container(
              
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadiusDirectional.circular(5),
                     
                  ),
                  alignment: Alignment.bottomLeft,
                  child: Text('$clubName\n$description',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    
                  ),
                  ),
                  ),
           )
      ],
    );
  }
}