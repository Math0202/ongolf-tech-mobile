import 'dart:math';

import 'package:flutter/material.dart';

class ClubLeaderBoardTable extends DataTableSource{
  final List<Map<String, dynamic>> data1 = List.generate(
    200, 
    (index) => {
      "id": "WGCC$index",
      "player": "Player Name $index",
      "rounds": Random().nextInt(10),
      "points": Random().nextInt(100),
      "earnings": Random().nextInt(8000),

    });
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data1[index]['id'].toString())),
      DataCell(Text(data1[index]['player'].toString())),
      DataCell(Text(data1[index]['rounds'].toString())),
      DataCell(Text(data1[index]['earnings'].toString())),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => data1.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

}