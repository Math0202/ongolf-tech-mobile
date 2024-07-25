import 'package:flutter/material.dart';
import 'foodAndDrinksTile.dart';

class EatAndDrink extends StatefulWidget {
  const EatAndDrink({super.key});

  @override
  State<EatAndDrink> createState() => _EatAndDrinkState();
}

class _EatAndDrinkState extends State<EatAndDrink> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'WGCC Search...',
                        prefixIcon: Icon(Icons.search),
                        
                      ),
                    ), 
                  ),
                ],
              ),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/food1.jpg',
                      clubName: '75NAD \nMeaty taste',
                      description: 'Cooks aprox in 10 mins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/food2.jpg',
                      clubName: '45NAD \nEgg treat',
                      description: 'Cooks aprox in 15 mins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/food3.jpg',
                      clubName: '39NAD \nStir vry',
                      description: 'Cooks aprox in 10 mins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/food4.jpg',
                      clubName: '32NAD \nCheese burger',
                      description: 'Cooks aprox in 5 mins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/food5.jpg',
                      clubName: '30NAD \nLong burger',
                      description: 'Cooks aprox in 5 mins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/food6.jpg',
                      clubName: '45NAD \nLight snack',
                      description: 'Cooks aprox in 5 mins',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/drink1.jpg',
                      clubName: '12NAD \nCola',
                      description: 'Served Ice cold',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/drink2.jpg',
                      clubName: '25NAD \nRainbow',
                      description: 'Tastes like it looks',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/drink3.jpg',
                      clubName: '45NAD \nShots',
                      description: 'Brandy and vodka',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: foodTile(
                      assetPath: 'assets/drink5.jpg',
                      clubName: '13NAD \nCool drinks',
                      description: 'Served Ice cold',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
