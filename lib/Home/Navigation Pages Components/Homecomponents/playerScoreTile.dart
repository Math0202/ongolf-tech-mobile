import 'package:flutter/material.dart';

class PlayerScoreTile extends StatefulWidget {
  final String imagePath;
  final String playerName;
  final int handicap;

  const PlayerScoreTile({
    required this.playerName,
    required this.handicap,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  _PlayerScoreTileState createState() => _PlayerScoreTileState();
}

class _PlayerScoreTileState extends State<PlayerScoreTile> {
  int scoreNum = 1; // Initialize with a default value

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Stack(
        children: [
          Expanded(
            child: Container(
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey[350],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 170,
                width: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey[350],
                  ),
                  child: Row(
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 12),
                              child: Text(
                                '${widget.playerName}\n  Handicap: ${widget.handicap}',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 21),
                              alignment: Alignment.center,
                              height: 63,
                              width: 68,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                scoreNum.toString(),
                                style: const TextStyle(
                                  fontSize: 46,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListWheelScrollView(
                          itemExtent: 50,
                          perspective: 0.01,
                          physics: const FixedExtentScrollPhysics(),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              scoreNum = index + 1;
                            });
                          },
                          children: List.generate(12, (index) {
                            return Text(
                              (index + 1).toString(),
                              style: const TextStyle(
                                fontSize: 46,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
